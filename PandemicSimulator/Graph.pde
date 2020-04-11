class Point {
  final int x;
  final int y;

  Point(int _x, int _y) {
    x = _x;
    y = _y;
  }
}

ArrayList<int[]> pointY = new ArrayList<int[]>();

void drawGraph() {
  drawLine(
    new Point(padding, (int) map(gameStates.get(0).values.get("dead"), 0, totalStartPeople, height - padding, padding)), 
    1, "dead");
  drawLine(
    new Point(padding, (int) map(gameStates.get(0).values.get("imune"), 0, totalStartPeople, height - padding, padding)), 
    1, "imune");
  drawLine(
    new Point(padding, (int) map(gameStates.get(0).values.get("infected"), 0, totalStartPeople, height - padding, padding)), 
    1, "infected");
  drawLine(
    new Point(padding, (int) map(gameStates.get(0).values.get("healthy"), 0, totalStartPeople, height - padding, padding)), 
    1, "healthy");
}

void drawLine(Point prevPoint, int i, String type) {
  Point point = new Point(
    (int) map(i, 0, gameStates.size() - 1, padding, width - padding), 
    (int) map(gameStates.get(i).values.get(type), 0, totalStartPeople, height - padding, padding));
    
  //noStroke();
  //fill(colors.get(type));
  //  quad(prevDead.x, prevDead.y, pointDead.x, pointDead.y, pointDead.x, height - padding, prevDead.x, height - padding);    
    
  strokeWeight(10);
  stroke(0);
  
  stroke(colors.get(type));
    line(prevPoint.x, prevPoint.y, point.x, point.y);

  if (i < gameStates.size() - 1) {
    drawLine(point, i + 1, type);
  }
}
