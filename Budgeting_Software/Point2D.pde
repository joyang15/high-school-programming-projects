class Point2D {
  
  //Fields
  float x, y;
  int d;
  int numTextInACell;
  
  //Constructor takes in how many different exp/rev are in a cell, day, and x and y coordinates
  Point2D(int numTextInACell, int d, float x, float y) { 
    this.x = x;
    this.y = y;
    this.d = d;
    this.numTextInACell = numTextInACell;
  }
}
