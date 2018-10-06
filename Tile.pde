class Tile {
  int x, y;
  int w, h;
  boolean active = false;

  Tile(int x_, int y_, int w_, int h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  Tile(int x_, int y_, int w_, int h_, boolean active_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    active = active_;
  }

  void show() {
    if (active) {
      if (start) {
        noStroke();
      } else {
        stroke(0, 0, 255);
      }
      fill(123);
      rectMode(CORNER);
      rect(x, y, w, h);
    }
  }
  void deactivate() {
    active = !active;
  }

  boolean equals(Object e) {
    return this.x == ((Tile)e).x && this.y == ((Tile)e).y;
  }
}
