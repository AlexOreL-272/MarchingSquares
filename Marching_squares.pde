int scale = 6;
float[][] board;
float inc = 0.01, z_off = 0.01;
int cols, rows;

OpenSimplexNoise noise;

int square_num(int a, int b, int c, int d) {
  return a * 8 + b * 4 + c * 2 + d;
}

void setup() {
  //frameRate(144);
  thread("draw_line");
  fullScreen(P2D);
  colorMode(HSB);
  noCursor();
  noise = new OpenSimplexNoise();
  cols = 1 + width / scale;
  rows = 1 + height / scale;
  board = new float[cols][rows];
}

void draw() {
  background(0); 
  float x_off = 0;
  for (int i = 0; i < cols; i++) {
    x_off += inc;
    float y_off = 0;
    for (int j = 0; j < rows; j++) {
      noStroke();
      //fill((board[i][j] + 0.2) * 255);
      fill((board[i][j] + 0.5) * 255, 255, 255);
      square(i * scale, j * scale, scale);
      //point(i * scale, j * scale);
      board[i][j] = (float)(noise.eval(x_off, y_off, z_off));
      y_off += inc;
    }
  }
  z_off += 0.01;
  
  //draw_line();
}

void line(PVector v1, PVector v2) {
  line(v1.x, v1.y, v2.x, v2.y);
}

void draw_line() {
  for (int i = 0; i < cols - 1; i++) {
    for (int j = 0; j < rows - 1; j++) {
      float x_coord = i * scale;
      float y_coord = j * scale;
      
      //float x = board[i][j];
      //float y = board[i][j + 1];
      //float z = board[i + 1][j + 1];
      //float t = board[i + 1][j];
      
      PVector a = new PVector(x_coord + scale / 2, y_coord);
      PVector b = new PVector(x_coord + scale, y_coord + scale / 2);
      PVector c = new PVector(x_coord + scale / 2, y_coord + scale);
      PVector d = new PVector(x_coord, y_coord + scale / 2);
      int num = square_num(ceil(board[i][j]), ceil(board[i+1][j]), 
                           ceil(board[i+1][j+1]), ceil(board[i][j+1]));
      
      stroke(255);
      strokeWeight(1);
      switch(num) {
      case 1:  
        line(c, d);
        break;
      case 2:  
        line(b, c);
        break;
      case 3:  
        line(b, d);
        break;
      case 4:  
        line(a, b);
        break;
      case 5:  
        line(a, d);
        line(b, c);
        break;
      case 6:  
        line(a, c);
        break;
      case 7:  
        line(a, d);
        break;
      case 8:  
        line(a, d);
        break;
      case 9:  
        line(a, c);
        break;
      case 10: 
        line(a, b);
        line(c, d);
        break;
      case 11: 
        line(a, b);
        break;
      case 12: 
        line(b, d);
        break;
      case 13: 
        line(b, c);
        break;
      case 14: 
        line(c, d);
        break;
      }
    }
  }
}
