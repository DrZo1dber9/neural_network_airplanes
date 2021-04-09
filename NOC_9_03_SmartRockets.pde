// neural network
// create by kinematicbody

int lifetime;  

Population population;  

int lifecycle;          
int recordtime;         

Obstacle target;        

//int diam = 24;          

ArrayList<Obstacle> obstacles;  

void setup() {
  size(640, 360);
  
  lifetime = 300;

  
  lifecycle = 0;
  recordtime = lifetime;
  
  target = new Obstacle(width/2-12, 24, 24, 24);

  
  float mutationRate = 0.01;
  population = new Population(mutationRate, 50);

    
  obstacles = new ArrayList<Obstacle>();
  obstacles.add(new Obstacle(width/2-100, height/2, 200, 10));
}

void draw() {
  background(255);

  
  target.display();


  
  if (lifecycle < lifetime) {
    population.live(obstacles);
    if ((population.targetReached()) && (lifecycle < recordtime)) {
      recordtime = lifecycle;
    }
    lifecycle++;
    
  } 
  else {
    lifecycle = 0;
    population.fitness();
    population.selection();
    population.reproduction();
  }

  
  for (Obstacle obs : obstacles) {
    obs.display();
  }

  
  fill(0);
  text("Generation #: " + population.getGenerations(), 10, 18);
  text("Cycles left: " + (lifetime-lifecycle), 10, 36);
  text("Record cycles: " + recordtime, 10, 54);
  
  
}


void mousePressed() {
  target.position.x = mouseX;
  target.position.y = mouseY;
  recordtime = lifetime;
}
