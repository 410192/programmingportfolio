// Malo Jourdan-Brutti | 6 Sept 2023 | Timeline
PFont font1,font2;

void setup() {
  size(900,400);
  background(180);
  font1 = loadFont("NotoSansMyanmar-Light-48.vlw");
  font2 = loadFont("STSongti-TC-Light-48.vlw");
}

void draw() {
  background(180);
  
  // Draw the tittle info
  fill(0);
  textFont(font1);
  textSize(40);
  textAlign(CENTER);
  text("Historic Computer Systems",width/2,60);
  textSize(30);
  text("by Malo",width/2,90);
  
  //Draw the timeline 
  strokeWeight(3);
  line(100,250,800,250); // Is the timeline
  line(100,245,100,255);
  line(800,245,800,255);
  line(450,245,450,255);
  line(275,245,275,255);
  line(625,245,625,255);
  textFont(font2);
  textSize(20);
  text("1930",100,240);
  text("1970",800,240);
  text("1940",275,240);
  text("1950",450,240);
  text("1960",625,240);
  
  // Draw all histEvents
  histEvent(170,200, "ENIAC", "1946 | \n ENIAC was designed by two people, John von Neumann and J. Presper Eckert. | It is used to solve all computational problems.",true);
  histEvent(275,350, "Colossus", "1941 | \n Colossus Mark 1, is built by a team led by Thomas “Tommy” Flowers. | It was used during World War II for cryptanalysis of the Lorenz1 code. It was also used for the surprise launch of the Normandy landings.",false);
  histEvent(275,200, "Zuse 3", "1941 | \n The Z3 was an electromechanical relay computer designed by German engineer Konrad Zuse. | Use to perform statistical analyzes of wing vibrations",true);
  histEvent(650,200, "Event 4", "Date | Developper | Purpose",true);
  histEvent(375,350, "Event 5", "Date | Developper | Purpose",false);
  histEvent(500,350, "Event 6", "Date | Developper | Purpose",false);
  histEvent(650,350, "Event 7", "Date | Developper | Purpose",false);
  histEvent(750,350, "Event 8", "Date | Developper | Purpose",false);
}

void histEvent(int x, int y, String title, String detail, boolean top) {
  text(title,x,y); 
  if(top == true) {
  line(x,y,x+15,y+50);
  } else {
  line(x, y-20, x+15, y-100); 
  }
  // mouse over to effect to reveal detail text
  if(mouseX > x-30 && mouseX < x+30 && mouseY > y-15 && mouseY < y+5) {
     if(top) {
      text(detail,width/2,130);
     } else {
      text(detail,width/2,380);
     }
  }
}
