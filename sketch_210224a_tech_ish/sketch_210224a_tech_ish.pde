PGraphics pg;

void setup() {
  size(1000, 1000);
  background(0);
  stroke(80, 255, 80);
  fill(80, 255, 80);
  frameRate(2);
  noLoop();

  for (int i = 0; i < 20; ++i) {
    g.filter(BLUR, 1);

    int x = (int)random(width);
    int y = -100;
    while (y < height) {
      float theta = random(PI / 6, PI * 5 / 6);
      int x2 = (int) (x + 200 * cos(theta));
      int y2 = (int) (y + 200 * sin(theta));
      int r = (int) random(0, 5) + i * i / 20;
      line(x, y, x2, y2);
      ellipse(x, y, r, r);
      x = x2;
      y = y2;
    }
  }
}
