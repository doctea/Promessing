color calculateAverage(Capture myMovie, int x, int y, int radius) {
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
   color myColor = color(rtot,gtot,btot);
   return myColor;
}
