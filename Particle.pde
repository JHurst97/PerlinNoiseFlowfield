class Particle {
  PVector loc;
  float theta;
  color c;
  float size;
  int count = 0;
  float alpha;
  PVector vel = new PVector(1, 1);

  Particle(float x, float y) {
    loc = new PVector(x, y);
    theta = 0;
    size = 2;
    alpha = 0;
    c = color(#FE7D6A);
  }

  void update(FlowField ff) {

    //size+=0.01;
    //calc where to go next
    vel.x = cos(theta);
    vel.y = sin(theta);


    PVector desired = ff.lookup(loc);
    theta = desired.z;
    PVector steer = PVector.sub(desired, vel);


    loc.x+=vel.x;
    loc.y+=vel.y;
    ellipse(loc.x, loc.y, size, size);
    
    float alphaInc = 1;
    if (loc.x<50) {
      alpha-=alphaInc;
    } else if (alpha<50) {
      alpha+=alphaInc;
    }
  }
}