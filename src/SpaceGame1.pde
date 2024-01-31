// Malo Jourdan-Brutti | 20 Nov 2023 | SpaceGame
import processing.sound.*;
SoundFile laser;
SpaceShip s1;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<PowUp> powups = new ArrayList<PowUp>();
ArrayList<Star> stars = new ArrayList<Star>();
Timer rockTimer, puTimer;
int rTime;
int score;
boolean play;
int level;
int rocksPassed;

void setup() {
  size(800, 800);
  laser = new SoundFile(this, "laser2.wav");
  play = false;
  score = 0;
  level = 1;
  rTime = 1000;
  rocksPassed = 0;
  s1 = new SpaceShip(width/2, height/2);
  rockTimer = new Timer(rTime);
  rockTimer.start();
  puTimer = new Timer(5000);
  puTimer.start();
}

void draw() {
  if (!play) {
    startScreen();
  } else {
    noCursor();
    background(0);
    if(frameCount % 100 == 10) {
      level++;
    }
    
    
    // Add and display stars
    stars.add(new Star(int(random(width)), -10));
    for(int i=0;i<stars.size();i++) {
      Star s = stars.get(i);
      if(s.reachedBottom()) {
        stars.remove(s) ;
      } else {
        s.display();
        s.move();
      }
    }

    // Add Power Up
    if (puTimer.isFinished()) {
      powups.add(new PowUp(int(random(width)), -100));
      puTimer.start();
    }

    // Render Power Ups
    for (int i = 0; i < powups.size(); i++) {
      PowUp pu = powups.get(i);
      if (s1.intersectPU(pu)) {
        if (pu.type == 'a') {
          s1.ammo += pu.val;
        } else if (pu.type == 'h') {
          s1.health += pu.val;
        } else if (pu.type == 't') {
          if (s1.turretCount < 3) {
            s1.turretCount += pu.val;
          }
        }
        //s1.health-=pu.diam;
        //score+=pu.diam;
        powups.remove(pu);
      }
      if (pu.reachedBottom()) {
        powups.remove(pu);
      } else {
        pu.display();
        pu.move();
      }
    }


    // Add Rocks
    if (rockTimer.isFinished()) {
      rocks.add(new Rock(int(random(width)), -100));
      rocks.add(new Rock(int(random(width)), -100));
      rocks.add(new Rock(int(random(width)), -100));
      rocks.add(new Rock(int(random(width)), -100));
      rockTimer.start();
    }

    // Render Rocks
    for (int i = 0; i < rocks.size(); i++) {
      Rock r = rocks.get(i);
      if (s1.intersect(r)) {
        s1.health-=r.diam;
        score+=r.diam;
        rocks.remove(r);
      }
      if (r.reachedBottom()) {
        rocksPassed++;
        rocks.remove(r);
        score = score -100;
      } else {
        r.display();
        r.move();
      }
    }

    // Render Lasers
    for (int i = 0; i < lasers.size(); i++) {
      Laser l = lasers.get(i);
      for (int j = 0; j < rocks.size(); j++) {
        Rock r = rocks.get(j);
        if (l.intersect(r)) {
          lasers.remove(l);
          score+=r.diam;
          r.diam-=20;
          if (r.diam<10) {
            rocks.remove(r);
          }
        }
      }
      if (l.reachedTop()) {
        lasers.remove(l);
      } else {
        l.display();
        l.move();
      }
    }
    s1.display();
    s1.move(mouseX, mouseY);

    infoPanel();
    if(s1.health<1 || rocksPassed>10000)  {
      gameOver();
    } else if(score<0) {
      gameOver();
    }
  }
}

void infoPanel() {
  fill(127, 127);
  rectMode(CENTER);
  rect(width/2, 30, width, 60);
  fill(255);
  textSize(25);
  text("Score:" + score, 40, 40);
  text("Health:" + s1.health, 200, 40);
  text("Ammo:" + s1.ammo, 360, 40);
  text("Level:" + level, width-150, 40);
  text("Rokcs Passed:" + rocksPassed, 525, 40);

  println("Rocks;" + rocks.size());
  println("Lasers;" + lasers.size());
  println("Stars:;" + stars.size());
}

void startScreen() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(44);
  text("Welcome to Space Game", width/2, 300);
  text("by Malo JOURDAN-BRUTTI | 2023", width/2, 350);
  text("clic the mouse to begin...", width/2, 400);
  if (mousePressed) {
    play = true;
  }
}

void gameOver() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(44);
  text("Game Over", width/2, 300);
  text("Score: "+ score, width/2, 350);
  text("Level: "+ level, width/2, 400);
  text("Health: "+ s1.health, width/2, 450);
  noLoop();                                                                 
}     

void ticker() {
}

void mousePressed() {
  if (s1.fire()) {
    //laserSound.play();
    lasers.add(new Laser(s1.x, s1.y));
    s1.ammo -= 1;
  } else if (s1.turretCount == 2) {
    lasers.add(new Laser(s1.x-15, s1.y));
    lasers.add(new Laser(s1.x+15, s1.y));
    s1.ammo -= 1;
  }
}

void keyPressed() {
  if (key == ' ') {
    if (s1.fire()) {
      if (s1.turretCount == 1) {
        lasers.add(new Laser(s1.x, s1.y));
        s1.ammo -= 1;
      }
    }
  }
}
