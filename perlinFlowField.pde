void setup() {
  size(900,1000);
  ff = new FlowField();
  //frameRate(30);
  //colorMode(HSB, 255);
  background(0);
}

boolean run = false;
FlowField ff;

void draw() {
  println(frameRate);
  //fill(255,5);
  //rect(0,0,width,height);
  noStroke();;
  if (run) {
    ff.add();
  }
}

void mouseClicked() {
  run = true;
  
}

void keyPressed() {
  saveFrame("/output/line-######.png");
  
}