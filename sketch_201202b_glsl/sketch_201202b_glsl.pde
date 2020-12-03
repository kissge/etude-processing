PShader sd;

void setup() {
  size(800, 800, P2D);
  sd = loadShader("shader.glsl");
}

void draw() {
  sd.set("t", millis() / 1000.0);
  sd.set("r", (float)width, (float)height);
  shader(sd);
  rect(0, 0, width, height);
}
