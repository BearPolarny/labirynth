class Rocket {

  static final int LIFECYCLES = 200;
  PVector[] moves;
  PVector position;
  PVector speed;
  PVector acceleration;
  boolean won = false;
  boolean crashed = false;
  float fitness;
  PImage rocketImage = loadImage("data/rakieta.png");
  float speedMult = 0.5;


  int time;

  Rocket() {
    position = new PVector(width/2, height - 50);
    acceleration = new PVector();
    speed = new PVector();
    moves = new PVector[LIFECYCLES];
    for (int i = 0; i < LIFECYCLES; i++) {
      moves[i] = PVector.random2D();
      moves[i].setMag(speedMult);
    }
  }
  Rocket(PVector[] dna) {
    position = new PVector(width/2, height - 50);
    acceleration = new PVector();
    speed = new PVector();
    moves = dna;
  }



  void update() {
    if (! (crashed || won)) {
      acceleration.add(moves[cycle]);
      speed.add(acceleration);
      position.add(speed);
      acceleration.mult(0);
    }

    pushMatrix();
    noStroke();
    imageMode(CENTER);
    translate(position.x, position.y);
    rotate(speed.heading());
    image(rocketImage, 0, 0);
    popMatrix();
    boundries();
  }

  void mutate() {
    for (int i = 0; i< moves.length; i++) {
      if (random(100)<2) moves[i] = PVector.random2D();
    }
  }
  Rocket crossover(Rocket partner) {
    PVector[] dna = new PVector[moves.length];
    int n = int(random(moves.length));
    //println(n);
    for (int i = 0; i <moves.length; i++) {
      if (i<n) {
        dna[i] = moves[i].copy();
      } else {
        dna[i] = partner.moves[i].copy();
      }
    }

    return new Rocket(dna);
  }

  float fitness() {
    float fitness;
    if (won) {
      fitness = 4;
      fitness *= map(time/LIFECYCLES, 0, 1, 1.5, 0.5);
    } else {
      fitness = PVector.dist(position, target);
      fitness = 1 / fitness;
    }

    if (crashed) {
      fitness *= 0.1;
    }

    return fitness;
  }
  void boundries() {  //TODO: 
    if (PVector.dist(position, target) < 10) {
      won = true;
      position = target.copy();
      time = cycle;
    }
    if (position.x < 0 || position.x > width ||
      position.y < 0 || position.y > height) {
      crashed = true;
    }

    for (Tile tile : mapa.tiles) {
      if (tile.active) {
        if (position.x > tile.x && position.x < tile.x + tile.w) {
          if (position.y > tile.y && position.y < tile.y + tile.h) {
            crashed = true;
          }
        }
      }
    }
  }

  void mouseOver() {
    PVector mouse = new PVector(mouseX, mouseY);
    if ( PVector.dist(mouse, position)<10) {
      rectMode(CORNER);
      fill(0,80,0);
      noStroke();
      rect(50,40,100,11);
      fill(0);
      textSize(10);
      text("fit: " + fitness(), 50, 50);
    }
  }
}
