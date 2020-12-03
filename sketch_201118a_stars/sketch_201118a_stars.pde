import java.util.ArrayDeque;
ArrayDeque<Star> stars;
float a, b, da, db;

void setup() {
  stars = new ArrayDeque<Star>();

  size(1200, 1200);
  background(0, 0, 0);
  noStroke();

  a = 5;
  b = 13;
}

void draw() {
  if (frameCount % 800 == 1) {
    da = random(-1e-3, 1e-3);
    db = random(-1e-3, 1e-3);
  }
  a += da;
  b += db;

  println("a =", a, ", b =", b, ", da =", da, ", db =", db);

  fill(0, 0, 0, 12);
  rect(0, 0, width, height);
  translate(width / 2, height / 2);

  for (float t = frameCount / 25.0; t < (frameCount + 1) / 25.0; t += 0.005) {
    float r = width / 2.0 / 2.0 * sin(t * a / b / 2);
    stars.add(new Star(r * cos(t), r * sin(t)));
    if (stars.size() > 10000) {
      stars.remove();
    }
  }

  fill(0, 205, 30);
  for (Star star: stars) {
    star.draw();
  }
}

class Star {
  float x, y, t = 0;

  Star(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void draw() {
    float th = noise(x / 1000, y / 1000, t) * 10;
    x += cos(th) * t * 2;
    y += sin(th) * t * 2;
    t += 1e-2;
    float r = sin(t) * 2 + 3;

    ellipse(floor(x), floor(y), r, r);
  }
}
