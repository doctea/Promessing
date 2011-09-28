import processing.opengl.*;
import processing.video.*;
import com.nootropic.processing.layers.*;

AppletLayers layers;

Capture webcamStream;

MovieMaker mm;  // Declare MovieMaker object

PFont font;

int lastMillis;

float a = 1.01;
float b = 0.01;

boolean wave = true;
boolean doStroke = true;
boolean doTint = true;
boolean doNoNegative = true;
boolean doColorShift = false;
boolean doColorCycle = false;
boolean doColorFuck = false;
boolean doColorZap = false;
boolean doColorWank = false;
boolean doHexMode = false;
boolean doColorCunt = false;
boolean cycleOffset = false;

int shape = 0;

boolean screenGrab = false;
boolean doDrawDebug = true;

boolean renderLetters = false;

boolean record = false;

import ddf.minim.*;

float offsetAmount = 0;
float timeScale = 0.125;

Minim minim;
AudioInput in;

void setup() 
{
  try {
    quicktime.QTSession.open();
  } catch (quicktime.QTException qte) { 
    qte.printStackTrace();
  }
  size(800, 600, JAVA2D);//, P2D);
  //background (255);    // Set bg to white
  //noStroke();          //uncomment this line to remove the stroke
  frameRate(30);       // Set framerate
  //smooth();            // Antialiasing

  font = createFont("Arial Bold",48);

  registerPost(this);

  webcamStream = new Capture(this, width, height, 30);

  layers = new AppletLayers(this);
  colorMode(RGB);
  cursor(CROSS);  
  
  lastSecond = millis();///1000;
  //Layer[] layers = new Layer[8];
  //layers[0] = new VideoStream(this);

/*
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);
*/

/*  VideoLayer vs2 = new VideoLayer(this);
  vs2.setCapture(webcamStream);
  layers.addLayer(vs2);*/

  PointilizeLayer vs = new PointilizeLayer(this);
  vs.setCapture(webcamStream);
  layers.addLayer(vs);

  //mm = new MovieMaker(this, width, height, "drawing"+(random(1024))+".mov", 15);
  //                     15, MovieMaker.H263, MovieMaker.HIGH);
  
  a = 0.01;
}

void captureEvent(Capture myCapture) {
  if(webcamStream.available())
    webcamStream.read();
}
void movieEvent(Movie m) {
  m.read();
}

int lastSecond;
void draw() {
  //background(0,0);
  //if (wave) a+=0.01;//a = millis()*millis();//a+=0.01;
  
  //if (wave) a = millis()/1000;//%16;//32;
  if (wave) {
    //a += 0.01;
    //a += 0.005;
    //a = frameCount*0.01;
    //a += ((millis()-lastMillis)*100) * 0.01;
    //a = (((float)millis()-lastMillis)) * 0.01;
    float dur = 25000;
    int tM = millis();
    //a = sin(radians(tM-lastSecond)*dur);
    a = sin(millis()/500)%2;
    /*if (tM>lastSecond) {
      //a = sin(radians(tM));
      a = 0.01;
      lastSecond = tM;
    }*/
    //a = radians(millis()%100000);//*0.0005;
  }
  
  if (doColorCycle) b += 0.01; //(millis()/1000)%3;//*0.01;//b+=0.01;
  //delay(250);
  //a += in.left.get(50)*250;
  
  if (cycleOffset) {
    offsetAmount = (sin(millis()/(timeScale*1000))%3);//*0.125;
  }
    
  
  //in.forward
  //a+= map(mouseY,0,height,0.000, 0.1);
  if (screenGrab) {
    saveImage();
    screenGrab = false;
  }
}


void post() {
  if (record) {
    layers.loadPixels();
    mm.addFrame(layers.pixels, width, height);
  }
  //layers.loadPixels();
  //if (screenGrab) {
    //savedpix = layers.pixels;
    //saveImage();
    //screenGrab = false;
  //} 
}


void paint(java.awt.Graphics g) {
  if (layers != null) {
    layers.paint(this);
  } 
  else {
    super.paint(g);
  }
}


// SAVE IMAGE
float saveincr;
void mousePressed() 
{
  saveImage();
//  saveincr++;
//  save("image"+saveincr+random(1024)+".jpg");
}

void saveImage () {
  saveincr++;
  delay(100); // give the buffer enough time to catch up. 50 is too slow, 250 works
  layers.loadPixels();
  PImage s = createImage(width, height, ARGB);
  s.loadPixels();
  for (int i = 0 ; i < layers.pixels.length ; i++) {
    s.pixels[i] = layers.pixels[i];//get(i, i*width);
  }
  s.updatePixels();
  //updatePixels();
  s.save("image"+saveincr+random(1024)+".jpg");
}

void keyPressed() {
  if (key == ' ') {
    screenGrab = true;
  } else if (key == 'm') {
    //mm.finish();  // Finish the movie if space bar is pressed!
    //record = false;    
    //save("image"+saveincr+random(1024)+".jpg");  
    //saveImage();
    /*offsetAmount += 0.25;
    if (offsetAmount>1.5) {
      offsetAmount = 0;
    }*/
    timeScale += 0.125;
    if (timeScale>3) {
      timeScale = 0.125;
    }
  } else if (key ==',') {
    cycleOffset = !cycleOffset;
  } else if (key == 'w') {
    wave = !wave;
  } else if (key == 'e') {
    doColorCycle = !doColorCycle; 
  } else if (key == 's') {
    doStroke = !doStroke;
  } else if (key == 't') {
    doTint = !doTint;
  } else if (key == 'n') {
    doNoNegative = !doNoNegative;
  } else if (key == 'c') {
    doColorShift = !doColorShift;
  } else if (key == 'v') {
    doColorFuck = !doColorFuck;
  } else if (key == 'b') {
    doColorWank = !doColorWank;
  } else if (key == 'h') {
    doHexMode = !doHexMode;
  } else if (key == ']') {
    doDrawDebug = !doDrawDebug;
  } else if (key == 'l') {
    renderLetters = !renderLetters;
  } else if (key == 'r') {
    shape += 1;
    if (shape>3) shape = 0;
  } else if (key == 'k') {
    record = !record;
  } else if (key == 'x') {
    doColorCunt = !doColorCunt;
  } else if (key == 'z') {
    doColorZap = !doColorZap;
  }
}
