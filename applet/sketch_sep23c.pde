import processing.opengl.*;
import processing.video.*;
import com.nootropic.processing.layers.*;

AppletLayers layers;

Capture webcamStream;

MovieMaker mm;  // Declare MovieMaker object

float a = 0.01;

boolean wave = true;
boolean doStroke = true;
boolean doTint = true;
boolean doNoNegative = true;

import ddf.minim.*;

Minim minim;
AudioInput in;

void setup() 
{
  try {
    quicktime.QTSession.open();
  } catch (quicktime.QTException qte) { 
    qte.printStackTrace();
  }
  size(800, 600, P3D);//, P2D);
  //background (255);    // Set bg to white
  //noStroke();          //uncomment this line to remove the stroke
  frameRate(30);       // Set framerate
  //smooth();            // Antialiasing

  webcamStream = new Capture(this, width, height, 30);

  layers = new AppletLayers(this);
  colorMode(HSB);
  cursor(CROSS);  
  //Layer[] layers = new Layer[8];
  //layers[0] = new VideoStream(this);

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 512);


  VideoLayer vs2 = new VideoLayer(this);
  vs2.setCapture(webcamStream);
  layers.addLayer(vs2);

  PointilizeLayer vs = new PointilizeLayer(this);
  vs.setCapture(webcamStream);
  layers.addLayer(vs);

  //mm = new MovieMaker(this, width, height, "drawing"+(random(255))+".mov",
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

void draw() {
  //background(0,0);
  if (wave) a+=0.01;
  
  a+=in.left.get(50)*250;
  
  //in.forward
  //a+= map(mouseY,0,height,0.000, 0.1);
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
  saveincr++;
  save("image"+saveincr+random(1024)+".jpg");
}

void keyPressed() {
  if (key == ' ') {
    mm.finish();  // Finish the movie if space bar is pressed!
  } else if (key == 'w') {
    wave = !wave;
  } else if (key == 's') {
    doStroke = !doStroke;
  } else if (key == 't') {
    doTint = !doTint;
  } else if (key == 'n') {
    doNoNegative = !doNoNegative;
  }
}
