

class Rocket {

  
  PVector position;
  PVector velocity;
  PVector acceleration;

  
  float r;

  
  float recordDist;

  
  float fitness;
  DNA dna;
  
  int geneCounter = 0;

  boolean hitObstacle = false;    
  boolean hitTarget = false;   
  int finishTime;              

  //constructor
  Rocket(PVector l, DNA dna_, int totalRockets) {
    acceleration = new PVector();
    velocity = new PVector();
    position = l.get();
    r = 4;
    dna = dna_;
    finishTime = 0;          
    recordDist = 10000;      
  }

  
  void fitness() {
    if (recordDist < 1) recordDist = 1;

    
    fitness = (1/(finishTime*recordDist));

    
    fitness = pow(fitness, 4);

    if (hitObstacle) fitness *= 0.1; 
    if (hitTarget) fitness *= 2;
  }

  
  void run(ArrayList<Obstacle> os) {
    if (!hitObstacle && !hitTarget) {
      applyForce(dna.genes[geneCounter]);
      geneCounter = (geneCounter + 1) % dna.genes.length;
      update();
      
      obstacles(os);
    }
    
    if (!hitObstacle) {
      display();
    }
  }

  
  void checkTarget() {
    float d = dist(position.x, position.y, target.position.x, target.position.y);
    if (d < recordDist) recordDist = d;

    if (target.contains(position) && !hitTarget) {
      hitTarget = true;
    } 
    else if (!hitTarget) {
      finishTime++;
    }
  }

  
  void obstacles(ArrayList<Obstacle> os) {
    for (Obstacle obs : os) {
      if (obs.contains(position)) {
        hitObstacle = true;
      }
    }
  }

  void applyForce(PVector f) {
    acceleration.add(f);
  }


  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    
    float theta = velocity.heading2D() + PI/2;
    fill(200, 100);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);

    
    rectMode(CENTER);
    fill(0);
    rect(-r/2, r*2, r/2, r);
    rect(r/2, r*2, r/2, r);

    // Rocket body
    fill(175);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();

    popMatrix();
  }

  float getFitness() {
    return fitness;
  }

  DNA getDNA() {
    return dna;
  }

  boolean stopped() {
    return hitObstacle;
  }
}
