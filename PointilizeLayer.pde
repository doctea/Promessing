class PointilizeLayer extends Layer {  
  String letterOrder =
    " .`-_':,;^=+/\"|)\\<>)iv%xclrs{*}I?!][1taeo7zjLu" +
    "nT#JCwfy325Fp6mqSghVd4EgXPGZbYkOA&8U$@KHDBWNMR0Q";
  char[] letters;
  
  PFont font;
  float fontSize = 1.5;
  
  int textColumns, textRows;
  
  float[] bright;
  char[] chars;
  
  Capture myCapture;
  //Movie myCapture; 

  PointilizeLayer (PApplet parent) {
    super(parent, JAVA2D);
    
    //myCapture = new Capture(parent, width, height, 30);
  }
  
  void setup() {
    font = loadFont("UniversLTStd-Light-48.vlw");
    
    textColumns = 30;
    textRows = 20;

  }

  void setCapture(Capture c) {
    this.myCapture = c;
    
      
    // for the 256 levels of brightness, distribute the letters across
    // the an array of 256 elements to use for the lookup
    letters = new char[256];
    for (int i = 0; i < 256; i++) {
      int index = int(map(i, 0, 256, 0, letterOrder.length()));
      letters[i] = letterOrder.charAt(index);
    }

    int count = myCapture.width * myCapture.height;
  
    // current characters for each position in the video
    chars = new char[count];
  
    // current brightness for each point
    bright = new float[count];
    for (int i = 0; i < count; i++) {
      // set each brightness at the midpoint to start
      bright[i] = 128;
    }        
  }  
  
  void draw() {
    //background(0,0); 
    if (!doStroke) noStroke(); else stroke(1);//32);//random(255));
    //background(0,0);
  
    //if (myCapture.available()) myCapture.read();
    //a += 0.01;
    
    //float rel = 1/mouseX*sin(a*a);
    float rel = norm(mouseX,0,width);//width);//,0,1);
    
    int sq_mouseX = mouseX*mouseX;
    int sq_mouseY = mouseY*mouseY;
    
    int numBlobs = 0;
    
    //rotate(PI);
    
    //float zoom = 150-map(sq_mouseY,0,height*height,0,150);
    float zoom = map(mouseY,0,height,1,150);

    //float pointillize = (doNoNegative?offsetAmount:0)+map(sin(a*a)*(rel*1000), 0, width, 2, 150) ;//* in.getGain();
    float pointillize = (doNoNegative?offsetAmount:0)+map(sin(a*a)*(rel*1000), 0, width, 2, 150) ;//* in.getGain();
    //float pointillize = (doNoNegative?1:0) + lerp((rel*10*a), 2, 64); //map(a, 0, 1, 2, 64) ;//* in.getGain();
    float pointillize_b = (doNoNegative?offsetAmount:0)+map(sin(b*b)*sin(b*b), 0, width, 1, 255) ;//* in.getGain();    
    //float pointillize_b = map(sin(offsetAmount*offsetAmount)*sin(b),-1,1,2,255);
    
    if (doDrawDebug) {
      drawDebug("pointillize", pointillize);
      drawDebug("pointillize_b", pointillize_b);
    }
    
    float half_pointillize = pointillize/2;
    float half_pointillize_b = pointillize_b/2;
    float sq_pointillize = pointillize*pointillize;
    float sq_pointillize_b = pointillize_b*pointillize_b;
    
    if (!renderLetters) {

      //float requiredX = width/(zoom*pointillize); //* map(mouseY,0,height, 8, width);
      //float requiredY = height/(zoom*pointillize); //(pointillize*map(mouseX,0,width,0,10)); //* map(mouseY,0,height, 6, height);
      //float requiredX = max(width/(pointillize*2),10);
      //float requiredY = max(height/(pointillize*2),10);
      float requiredX = max(width/(pointillize*2),10);
      float requiredY = max(height/(pointillize*2),10);
      
      
      myCapture.loadPixels();
      //for (int px = 0 ; px < width ; px+= width*requiredX) {
        //for (int py = 0 ; py < height ; py+= height*requiredY) {
      
      //int numBlobs = (int) map(sq_mouseY, 0, height*height, 5, constrain(5000-((sq_pointillize*sq_pointillize)),10,4000));
      numBlobs = (int) map(zoom, 0, 150, 5, constrain((requiredX * requiredY),5,5000));// constrain(5000-((sq_pointillize*sq_pointillize)/2),10,4000));
      //numBlobs = (int) constrain(requiredX*requiredY,5,(width*height)/2/*(((5000*zoom)/100))*/);
      //numBlobs = (int) map(requiredX*requiredY,0,(width*height),5,5000); ///*(((5000*zoom)/100))*/);      
        
      int oldShape = shape;  
      if (shape==3) {
        shape = (int)random(0,3);
      }        
          
      for (int i = 0 ; i < numBlobs /*map((1/(mouseY*mouseY),0,1,50,3000)*/ ; i++) {
        //float pointillize = map(random(width), 0, width, 2, 50);
        int x = int(random(width));
        int y = int(random(height));
        //color pix = ((Capture)myCapture).get(width-x, y);
        color pix = myCapture.pixels[(width*y-1)+(width-x)];
        
        //colorMode(doColorFuck?HSB:RGB);
        

        if (doColorCunt) {
          int a = (pix >> 24) & 0xFF;  // Faster way of getting red(argb)          
          int r = (pix >> 16) & 0xFF;  // Faster way of getting red(argb)
          int g = (pix >> 8) & 0xFF;   // Faster way of getting green(argb)
          int b = pix & 0xFF;          // Faster way of getting blue(argb)
          pix = color(
            /*map((int)(r*r),0,64,1,255),
            map((int)(g*g),0,64,1,255),
            map((int)(b*b),0,64,1,255),*/
            /*(int)(r*r)/(16*(pointillize_b*(g-20))),
            (int)(g*g)/(16*(pointillize_b*(b-20))),   // <-- a good one with or without hte -20's
            (int)(b*b)/(16*(pointillize_b*(r-20))),*/ 
            (int)(r*r)/(16*(pointillize_b/8)),
            (int)(g*g)/(16*(pointillize_b/8)),   // brighter
            (int)(b*b)/(16*(pointillize_b/8))//,
            
            //255
         );
        }
        
        
        if (doColorFuck) 
          pix -= (-pix*2*pointillize_b); //orig
          
        if (doColorWank) {
          pix -= (-pix*2*(sq_pointillize_b));
          //pix = ((255*255)/(pix*pix));
        }
        
        if (doColorShift) {
          //pix = (pix*=pointillize)/64;
          pix += pix+(width/pointillize_b);
        }
        

        if (doColorZap) {
          int a = (pix >> 24) & 0xFF;  // Faster way of getting red(argb)          
          int r = (pix >> 16) & 0xFF;  // Faster way of getting red(argb)
          int g = (pix >> 8) & 0xFF;   // Faster way of getting green(argb)
          int b = pix & 0xFF;          // Faster way of getting blue(argb)
          
          //pix = color((offsetAmount*64)+r/2, (offsetAmount*64)+g/2, (offsetAmount*64)+b/2);          
          if (r<128) r += ((float)255*(offsetAmount+1.0)); else r -= ((float)255*(offsetAmount+1.0));
          if (g<128) g += ((float)255*(offsetAmount+1.0)); else g -= ((float)255*(offsetAmount+1.0));
          if (b<128) b += ((float)255*(offsetAmount+1.0)); else b -= ((float)255*(offsetAmount+1.0));
          pix = color(r,g,b);
        }        
        
        //color pix = new Color(red);

        if (!doTint) {
          fill(pix);
        } else {
          if (!doHexMode) {
            //fill(pix, map(width-mouseX,0,width,0,128));
            fill (pix, 128);
          //fill(pix, doTint?128:255);
          //fill(pix, doTint?random(0,
          } else {
            fill(pix, map(i,0,width,0,128)); // <--- interesting glitches - explore!! 
          }
        }
        
        //line(0,0, 0,0, x, y);
        //if (random(1)<0.5) 
        //if (doHexMode) {
          //Hexagon h = new Hexagon((Object) this, 0, 0, (int)pointillize);
          //h.drawHex();
        //} else {

          if (shape==0) {
            //ellipse(x-(pointillize/2), y-(pointillize/2), pointillize, pointillize);
            ellipse(x, y, pointillize, pointillize);
          } else if (shape==1) {
            rect(x-(half_pointillize),y-(half_pointillize),pointillize,pointillize);
          } else if (shape==2) {
            //shape(x-pointillize, y-pointillize, x+pointillize, y+pointillize);
            //float x2 = x+=x*tan(random(60));
            //float y2 = y+=x*cos(random(60));
            float a = random(60);
            pushMatrix();
            //translate(x-(pointillize/2), y-(pointillize/2));
            translate(x,y);
            rotate(radians(a));//x,y);            
            rect(-half_pointillize, -half_pointillize, pointillize, pointillize);
            popMatrix();
          }
//        }
        //}
        //rotate(cos(a));
        //triangle(x-(15*pointillize), y-(15*pointillize), x+15*pointillize, y-15*pointillize, x+5*pointillize, y+5*pointillize);
        //else
        //rect(x, y, pointillize, pointillize); //uncomment this line to use squares
      }    
      
      shape = oldShape;
      
    } else {
      // renderLetters
      //renderWithLetters();
    }
    
    drawFPS(numBlobs);
    
  }
    
/*  void renderWithLetters() {
      //background(0);
    
      //pushMatrix();
    
      float hgap = width / textColumns;//float(myCapture.width);
      float vgap = height / textRows; //float(myCapture.height);
    
      scale(max(hgap, vgap) * fontSize);
      textFont(font, fontSize);
    
      int index = 0;
      myCapture.loadPixels();
      for (float y = 1; y < myCapture.height; y+=vgap) {
    
        // Move down for next line
        //translate(0,  1.0 / fontSize);
        index += width;
    
        //pushMatrix();
        for (float x = 0; x < myCapture.width; x+=hgap) {
          int pixelColor = myCapture.pixels[index];
          // Faster method of calculating r, g, b than red(), green(), blue() 
          int r = (pixelColor >> 16) & 0xff;
          int g = (pixelColor >> 8) & 0xff;
          int b = pixelColor & 0xff;
    
          // Another option would be to properly calculate brightness as luminance:
          // luminance = 0.3*red + 0.59*green + 0.11*blue
          // Or you could instead red + green + blue, and make the the values[] array
          // 256*3 elements long instead of just 256.
          int pixelBright = max(r, g, b);
    
          // The 0.1 value is used to damp the changes so that letters flicker less
          float diff = pixelBright - bright[index];
          bright[index] += diff * 0.1;
    
          fill(pixelColor);
          int num = int(bright[index]);
          text(letters[num], textColumns*x, textRows*y);
          
          // Move to the next pixel
          index+=hgap;//=hgap;
    
          // Move over for next character
          //translate(1.0 / fontSize, 0);
        }
        //popMatrix();
      }
      //popMatrix();
  }*/
  
  int lineCount = 0;
  void drawDebug(String label, Object value) {
    lineCount++;
    fill(128);
    text(label +":" + value, width-150, lineCount*20);
    fill(255);
    text(label + ":" + value, width-149, (lineCount*20)+1);
    fill(0);
    text(label + ":" + value, width-148, (lineCount*20)+2);
    
  }
  
  void drawFPS(int numBlobs) {
/*    textFont(font,36);
    // white float frameRate
    fill(128,255);
    rect(width-100, 20, 100, 0);
    fill(255);
    
    text(numBlobs, width-100, 20);*/
    
    if (!doDrawDebug) {
      lineCount = 0;
      return;
    }  
    
    drawDebug("--","fps");
    drawDebug("fps", (int)frameRate);    
    drawDebug("--","fps");
   
    drawDebug("doColorCycle", doColorCycle);        
    drawDebug("doHexMode", doHexMode);   
   
    drawDebug("numBlobs", numBlobs);

    drawDebug("wave a", a);    
    drawDebug("wave b", b);

    
    drawDebug("doNoNegative", doNoNegative);
    drawDebug("cycleOffset", cycleOffset);
    drawDebug("offsetAmount", offsetAmount);
    
    drawDebug("timeScale", timeScale);
    
    drawDebug("--","render fx");
    
    drawDebug("doStroke",doStroke);
    drawDebug("doTint", doTint);
    drawDebug("doColorZap", doColorZap);
    drawDebug("doColorCunt", doColorCunt);    
    drawDebug("doColorShift", doColorShift);
    drawDebug("doColorFuck", doColorFuck);
    drawDebug("doColorWank", doColorWank);

    
    lineCount = 0;

    //text(frameRate,20,20);
    // gray int frameRate display:
    //fill(200);
    //text(int(frameRate),20,60);
    
    if (record) {
      text("recording", 20, height-20);
    }
  }  
  
}
