// Nov 2013
// http://jiyu-kenkyu.org
// http://kow-luck.com
//
// This work is licensed under a Creative Commons 3.0 License.
// (Attribution - NonCommerical - ShareAlike)
// http://creativecommons.org/licenses/by-nc-sa/3.0/
// 
// This basically means, you are free to use it as long as you:
// 1. give http://kow-luck.com a credit
// 2. don't use it for commercial gain
// 3. share anything you create with it in the same way I have
//
// If you want to use this work as more free, or encourage me,
// please contact me via http://kow-luck.com/contact

//========================================
import processing.opengl.*;

int NUM_POINTS = 600;
Points[] points = new Points[NUM_POINTS];

//========================================
void setup() {
  size(1280, 720, OPENGL);
  for (int i= 0; i < NUM_POINTS; i++) {
    float X = random(-width/2, width);
    float Y = random(-width/4, width/4);
    float Z = random(-width, width/4);
    float DIAM = random(50, 100);
    float rX = random(-5, 5);
    float rY = random(-5, 5);
    float circle_y_mov = random(-5, 5);
    float circle_z_mov = random(-5, 5);
    points[i] = new Points(X, Y, Z, DIAM, rX, rY, circle_y_mov, circle_z_mov);
  }
}
//========================================
void draw() {
  background(0);

  translate(width/3, height/2, -width/4);
  rotateY(frameCount *  0.002 + mouseY/1000);
  rotateX(frameCount * -0.003 - mouseX/1000);
  rotateZ(frameCount * -0.001);
  for (int i = 0; i < NUM_POINTS; i++) {
    points[i].display();
    points[i].move();
  }
  println(frameRate);
}
//========================================
public class Points {
  int PointSize = 15;
  int Step = 10;
  color Alpha = 70;

  int moveMax = 100;
  float circle_x, circle_y, circle_z, circle_diam, 
  spX, spY, circle_y_mov, circle_z_mov;
  //========================================
  Points(float xpos, float ypos, float zpos, float diameter, 
  float speedX, float speedY, float cYm, float cZm) {
    circle_x = xpos;
    circle_y = ypos;
    circle_z = zpos;
    circle_diam = diameter;
    spX = speedX;
    spY = speedY;
    circle_y_mov = cYm;
    circle_z_mov = cZm;
  }
  //========================================
  public void display() {
    stroke(255, Alpha);
    strokeWeight(PointSize);
    pushMatrix();
    translate(circle_x, circle_y, circle_z);

    this.rotation();
    this.drawMe();
  }
  //========================================
  private void drawMe() {
    float startRadius= (circle_diam)/2;
    for (int angle = 0; angle < 230; angle += Step) {
      float radiusNoise = random(0, 8);
      float radius = startRadius + radiusNoise;
      float point_x =radius * cos(radians(angle)); 
      float point_y =radius * sin(radians(angle));

      point(point_x, point_y);
      radius += radiusNoise;
    }
    popMatrix();
  }
  //========================================
  private void rotation() {
    float rotX = spX/100;
    float rotY = spY/100;
    rotateX(frameCount * rotX);
    rotateY(frameCount * rotY);
  }
  //========================================
  public void move() {
    circle_y += circle_y_mov;
    circle_z += circle_z_mov;
    if (circle_z < -moveMax || circle_z > moveMax) {
      circle_z_mov *=-1;
    }
    if (circle_y < -moveMax || circle_y > moveMax) {
      circle_y_mov *= -1;
    }
  }
}

