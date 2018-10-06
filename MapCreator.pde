class MapCreator {
  final static int blockSize = 50;
  ArrayList<Tile> tiles;
  MapCreator() {
    tiles = new ArrayList();
    for (int i = 0; i < width; i+=blockSize) {
      for (int j = 0; j < height; j += blockSize) {
        tiles.add(new Tile(i, j, blockSize, blockSize));
      }
    }
  }

  void show() {
    for(Tile e: tiles) {
     if (e.active) {
      e.show(); 
     }
    }
  }
}
