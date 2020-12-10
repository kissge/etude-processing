static final int N = 200;
float[] h = new float[N];
float[] h2 = new float[N];

static final float k = 0.9;
static final int wv = 30;
static final int decay = 100;
float total = 0;

int dropTimer = 0;

void setup() {
  size(1200, 600);

  for (int i = 0; i < N; ++i) {
    h2[i] = h[i] = (sin(2 * PI * i / N) * 3 + sin(0.2 + 7 * PI * i / N) + 4) * 0.12;
    total += h[i];
  }
}

void draw() {
  float[] hNext = new float[N];
  float pretotal = 0;
  for (int i = 1; i < N - 1; ++i) {
    hNext[i] = 2 * (1 - k) * h[i] - h2[i] + k * (h[i - 1] + h[i + 1]);
    pretotal += hNext[i];
  }
  hNext[0] = 0.5;
  hNext[N - 1] = 0.5;
  float supplement = (total - pretotal - hNext[0] - hNext[N - 1]) / N;
  for (int i = 0; i < N; ++i) {
    hNext[i] = ((hNext[i] + supplement) * (decay - 1) + 0.5) / decay;
  }

  h2 = h;
  h = hNext;

  background(0);
  fill(0, 0, 185);
  stroke(70, 70, 200);

  float w = (float)width / N;
  for (int i = 0; i < N; ++i) {
    rect(i * w, height * (1 - h[i]), w * 5, height * 2);
  }

  if (dropTimer == 0) {
    ellipse(mouseX, 30, 20, 20);
  } else {
    dropTimer--;
  }
}

void mousePressed() {
  int center = N * mouseX / width;

  for (int i = 0; i < N; ++i) {
    int distance = abs(i - center);
    if (distance < wv) {
      h[i] -= cos(distance * PI / wv) / wv;
    }
  }

  dropTimer = 20;
}
