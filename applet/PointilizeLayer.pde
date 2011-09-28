class PointilizeLayer extends Layer {  
  Capture myCapture;
  //Movie myCapture; 

  PointilizeLayer (PApplet parent) {
    super(parent);
    
    //myCapture = new Capture(parent, width, height, 30);
  }

  void setCapture(Capture c) {
    this.myCapture = c;
  }  
  
  void draw() {
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
      int x = int(random(width));
      int y = int(random(height));
      color pix = ((Capture)myCapture).get(x, y);
      
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
