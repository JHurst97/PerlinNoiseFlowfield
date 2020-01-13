class FlowField {
  PVector[][] cells;
  PVector[][] cellAngles;
  int rows, cols;
  int spacing = 5;
  int total = 1000;
  Particle particles[];
  

  FlowField() {
    rows = height/spacing;
    cols = width/spacing;
    cells = new PVector[cols][rows];
    cellAngles = new PVector[cols][rows];
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        float theta = map(noise(i, j), 0, 1, 0, 255);
        cells[i][j] = new PVector(theta, 0);
        cellAngles[i][j] = new PVector(0, 0, 0);
      }
    }

    particles = new Particle[total];
    for (int n = 0; n < particles.length; n++) {
      particles[n] = new Particle(random(width),random(height));
    }
  }


  float baseNoise = 0; 

  void add() {
    float xOff = noise(baseNoise);
    for (int i = 0; i < cols; i++) {
      float yOff = xOff;
      for (int j = 0; j < rows; j++) {
        pushMatrix();
        translate(i*spacing, j*spacing);
        float n = map(noise(xOff, yOff), 0, 1, 0, TWO_PI);
        cellAngles[i][j] = new PVector(i*spacing, j*spacing, n);
        float x = spacing*cos(n);
        float y = spacing*sin(n);
        //line(x, y, 0, 0);
        popMatrix();
        yOff+=0.1;
      }
      xOff+=0.1;
    }

    //baseNoise+=0.01;


    //show particles
    for (int n = 0; n < particles.length; n++) {
      color c = color(particles[n].c);
      //if at sides
      if (particles[n].loc.x < 0) {
        particles[n] = new Particle(random(width), random(height));
      }
      if (particles[n].loc.y < 0) {
        particles[n] = new Particle(random(width), random(height));
      }
      if (particles[n].loc.y > height) {
        particles[n] = new Particle(random(width),random(height));
      }

      //set color and alpha
      float alpha = particles[n].alpha;
      fill(c, alpha);
      //update and move
      for (int i = 0; i < 10; i ++) {
        particles[n].update(this);
      }
    }
  }
  
  PVector lookup(PVector lookup){
    int column = int(constrain(lookup.x/spacing, 0, cols-1));
    int row = int(constrain(lookup.y/spacing, 0, rows-1));
    return cellAngles[column][row].get();
  }
}