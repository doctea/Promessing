import processing.core.*; 
import processing.xml.*; 

import processing.opengl.*; 
import processing.video.*; 
import com.nootropic.processing.layers.*; 
import ddf.minim.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class sketch_sep23c extends PApplet {





AppletLayers layers;

Capture webcamStream;

MovieMaker mm;  // Declare MovieMaker object

float a = 0.01f;

boolean wave = true;
boolean doStroke = true;
boolean doTint = true;
boolean doNoNegative = true;



Minim minim;
AudioInput in;

public void setup() 
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
  
  a = 0.01f;
}

public void captureEvent(Capture myCapture) {
  if(webcamStream.available())
    webcamStream.read();
}
public void movieEvent(Movie m) {
  m.read();
}

public void draw() {
  //background(0,0);
  if (wave) a+=0.01f;
  
  a+=in.left.get(50)*250;
  
  //in.forward
  //a+= map(mouseY,0,height,0.000, 0.1);
}


public void paint(java.awt.Graphics g) {
  if (layers != null) {
    layers.paint(this);
  } 
  else {
    super.paint(g);
  }
}


// SAVE IMAGE
float saveincr;
public void mousePressed() 
{
  saveincr++;
  save("image"+saveincr+random(1024)+".jpg");
}

public void keyPressed() {
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
class PointilizeLayer extends Layer {  
  Capture myCapture;
  //Movie myCapture; 

  PointilizeLayer (PApplet parent) {
    super(parent);
    
    //myCapture = new Capture(parent, width, height, 30);
  }

  public void setCapture(Capture c) {
    this.myCapture = c;
  }  
  
  public void draw() {
    //background(0,0); 
    if (!doStroke) noStroke(); else stroke(1);
    //background(0,0);
  
    //if (myCapture.available()) myCapture.read();
    //a += 0.01;
    
    //float rel = 1/mouseX*sin(a*a);
    float rel = map(mouseX,0,width,0,1);
    
    //rotate(PI);

    float pointillize = (doNoNegative?1:0)+map(sin(a*a)*mouseX, 0, width, 2, 100) ;//* in.getGain();
    
    for (int i = 0 ; i < map(mouseY,0,height,0,3000) ; i++) {
      //float pointillize = map(random(width), 0, width, 2, 50);
      int x = PApplet.parseInt(random(width));
      int y = PApplet.parseInt(random(height));
      int pix = ((Capture)myCapture).get(x, y);
      
      //color pix = new Color(red);
      fill(pix, doTint?map(mouseX,0,width,0,128):255);
      //line(0,0, 0,0, x, y);
      //if (random(1)<0.5) 
        ellipse(x, y, pointillize, pointillize);
      //rotate(cos(a));
      //triangle(x-(15*pointillize), y-(15*pointillize), x+15*pointillize, y-15*pointillize, x+5*pointillize, y+5*pointillize);
      //else
      //rect(x, y, pointillize, pointillize); //uncomment this line to use squares
    }    
  }
  
}
class VideoLayer extends Layer {  
  Capture myCapture;
  //Movie myCapture; 

  VideoLayer (PApplet parent) {
    super(parent);
    
    //myCapture = new Capture(parent, width, height, 30);
  }

  public void setCapture(Capture c) {
    this.myCapture = c;
  }  
  
  public void draw() {
    //tint(128,0);

    background(0,0); 
    image(myCapture, 0, 0);//, 64, 64, 64, 64, 64, 64);
  
/*    //if (myCapture.available()) myCapture.read();
    a += 0.01;
    
    for (int i = 0 ; i < 1500 ; i++) {
      float pointillize = map(sin(a*a)*sin(a*a)*map(mouseX,0,width,0, width), 0, width, 2, 100);
      //float pointillize = map(random(width), 0, width, 2, 50);
      int x = int(random(width));
      int y = int(random(height));
      color pix = ((Capture)myCapture).get(x, y);
      
      //color pix = new Color(red);
      fill(pix, 255);
      //line(0,0, 0,0, x, y);
      //if (random(1)<0.5) 
        ellipse(x, y, pointillize, pointillize);
      //rotate(cos(a));
      //triangle(x-(15*pointillize), y-(15*pointillize), x+15*pointillize, y-15*pointillize, x+5*pointillize, y+5*pointillize);
      //else
      //rect(x, y, pointillize, pointillize); //uncomment this line to use squares
    }    */
  }
  
}
public int calculateAverage(Capture myMovie, int x, int y, int radius) {
   int index = 0;
   int rtot = 0;
   int gtot = 0;
   int btot = 0;
   int increment = 5;

   for (int j = x-radius/*0*/; j < x+radius/*myMovie.height*/; j += increment) {
     for (int i = y-radius; i < y+radius; i += increment) {
       int pixelColor = myMovie.pixels[j*myMovie.width + i];

       int r = (pixelColor >> 16) & 0xff;
       int g = (pixelColor >> 8) & 0xff;
       int b = pixelColor & 0xff;
       rtot = rtot + r;
       gtot = gtot + g;
       btot = btot + b;
       index++;
     }
   }

   rtot = rtot/index;
   gtot = gtot/index;
   btot = btot/index;
   int myColor = color(rtot,gtot,btot);
   return myColor;
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "sketch_sep23c" });
  }
}
