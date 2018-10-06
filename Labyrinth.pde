int cycle = 0;
Population pop;
PVector target;
MapCreator mapa;
boolean start = false;
boolean pause = false;
color co1 = color(0,80,80);
color co2 = color(0,80,0);

boolean edit = false;
boolean editAdd = true;

void setup() {
  size(1200, 1000);
  mapa = new MapCreator();
  pop = new Population();
  target = new PVector(width/2, 50);
}

void draw() {
  if (!pause) {
    if (start) {
      background(co2);
    } else {
      background(co1);
    }
    mapa.show();

    stroke(0);
    fill(255, 0, 0);
    ellipse(target.x, target.y, 20, 20);
    if (start) {
      if (cycle < Rocket.LIFECYCLES - 1) {
        cycle++;
      } else {
        cycle = 0;
        pop.newPopulation();
      }
      pop.show();
    }
  } else {
    for (Rocket rocket : pop.rockets) {
      rocket.mouseOver();
    }
  }
  text(int(frameRate), width - 20, 20);
  if (edit) {
    mapa.tiles.get(mapa.tiles.indexOf(
      new Tile(mouseX - mouseX%MapCreator.blockSize, mouseY - mouseY%MapCreator.blockSize, 
      MapCreator.blockSize, MapCreator.blockSize))).active = !editAdd;
  }
}

void mousePressed() {
  if (mouseButton == LEFT && !start) {
    edit = true;
    editAdd = mapa.tiles.get(mapa.tiles.indexOf(
      new Tile(mouseX - mouseX%MapCreator.blockSize, mouseY - mouseY%MapCreator.blockSize, 
      MapCreator.blockSize, MapCreator.blockSize))).active;
  } else if (mouseButton == RIGHT) {
    start = !start;
  }
}

void mouseReleased() {
  if(mouseButton == LEFT && !start) {
    edit = false;
  }
}
void keyPressed() {
  if (keyCode == ' ') {
    pause = !pause;
  }
}
