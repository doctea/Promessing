class VideoLayer extends Layer {  
  Capture myCapture;
  //Movie myCapture; 

  VideoLayer (PApplet parent) {
    super(parent, JAVA2D);
    
    //myCapture = new Capture(parent, width, height, 30);
  }

  void setCapture(Capture c) {
    this.myCapture = c;
  }  
  
  void draw() {
    //tint(128,0);

    //background(0,0); 
    //image(myCapture, 0, 0);//, 64, 64, 64, 64, 64, 64);
    //Capture video = myCapture;
    pushMatrix();
    scale(-1,1);
    image(myCapture, 0, 0);
    popMatrix();

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
