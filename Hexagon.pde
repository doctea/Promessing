class Hexagon {
	
	 protected Object parent;
	 protected PGraphics buffer;
	 protected float a;
	 protected float b;
	 protected float c;
	 private int startX;
	 private int startY;
	 
	public Hexagon(Object p, int newStartX, int newStartY, int sideLength){
			if (p instanceof PGraphics)
				buffer = (PGraphics) p;
			
			if (p instanceof PApplet)
				parent = (PApplet) p;

                        if (p instanceof Layer)
                                parent = (Layer) p;
			
			setStartX(newStartX);
			setStartY(newStartY);
			c = sideLength;
			a = c/2;
			b = sin(radians(60))*c;
		}

	public void drawTranslatedHex(){

		pushMatrix();
		translate(getStartX(), getStartY());
		//draw hex shape
		drawHex();
		popMatrix();
	}
	
	public void drawHex(){
		//draw hex shape
		beginShape();
			vertex(0,b);
			vertex(a,0);
			vertex(a+c,0);
			vertex(2*c,b);
			vertex(a+c,2*b);
			vertex(a+c,2*b);
			vertex(a,2*b);
			vertex(0,b);
		endShape();
	}

	public void setStartX(int startX) {
		this.startX = startX;
	}

	public int getStartX() {
		return startX;
	}

	public void setStartY(int startY) {
		this.startY = startY;
	}

	public int getStartY() {
		return startY;
	}
}
