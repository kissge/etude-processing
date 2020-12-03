import ddf.minim.*;

Minim minim = new Minim(this);

int LOOP = 16;
int SPEED = 10;
int INSTS = 3;

AudioPlayer[] se;

int notes[][] = new int[INSTS][LOOP];
int cursorX = 0;
int cursorY = 0;

void setup() {
  colorMode(HSB, 100);
  textAlign(CENTER, CENTER);
  size(800, 400);
  se = new AudioPlayer[INSTS];
  se[0] = minim.loadFile("Closed Hat.wav");
  se[1] = minim.loadFile("Sample 1.wav");
  se[2] = minim.loadFile("Kick.wav");
}

void draw() {
  // スピード調整のため、に何フレームか一回に実行
  if (frameCount % SPEED == 0) {
    background(0);
    noStroke();

    fill(100);
    text("HOW TO USE = SPACE: on/off, ARROW: move cursor", 0, 0, width, height / (INSTS + 2) * 1);

    // 今何拍目か
    int tick = floor(frameCount / SPEED) % LOOP;

    for (int y = 0; y < INSTS; ++y) {
      fill(y * 100 / INSTS, 50, 50);

      for (int x = 0; x < LOOP; ++x) {
        int r = floor((notes[y][x] > 0 ? 30 : 10) * (tick == x ? 1.5 : 1));
        ellipse(width / (LOOP + 1) * (x + 1), height / (INSTS + 2) * (y + 2), r, r);
      }
    }

    // カーソル
    stroke(60);
    noFill();
    ellipse(width / (LOOP + 1) * (cursorX + 1), height / (INSTS + 2) * (cursorY + 2), 40, 40);

    // 音鳴らす
    for (int i = 0; i < INSTS; ++i) {
      if (notes[i][tick] > 0) {
        se[i].play();
        se[i].rewind();
      }
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    // 0 or 1 逆にする
    notes[cursorY][cursorX] = 1 - notes[cursorY][cursorX];
  } else if (keyCode == LEFT) {
    cursorX = (cursorX + LOOP - 1) % LOOP;
  } else if (keyCode == RIGHT) {
    cursorX = (cursorX + 1) % LOOP;
  } else if (keyCode == UP) {
    cursorY = (cursorY + INSTS - 1) % INSTS;
  } else if (keyCode == DOWN) {
    cursorY = (cursorY + 1) % INSTS;
  }
}
