 PImage img; 
PFont myFont;
int [] L = {201, 15, 147, 60};
int [] T = {58, 154, 184, 178};
int [] J = {75, 39, 210, 57};
int [] O = {15};
int [] Z = {30, 306, 30, 306};
int [] S = {51, 180, 51, 180};
int [] I = {4369, 3840, 4369, 3840};
String [] Piezas = {"L","T","J","O","S","Z","I"};
int Rotation;
String PiezaRandom = Piezas[int(random(7))];
int movimientoy = 30;
int movimientox = 490;
int Segundos;
int Tablero [][];
void setup()
   {
   img = loadImage("postertetris.png");
   size(900,700);
   background(207);
   myFont = createFont("Showcard Gothic", 20);
   textFont(myFont);
   textAlign(CENTER, CENTER);
   text("JULIANA", 800, 680);
   }
void ElimanarFila()
  { 
     }
void lineasy(int x, int y)
  {
    line(x + 30, y, x + 30, 660);
   }
void lineasx(int x, int y)
  {
    line(x, y + 30, 670, y + 30);
   }
void draw()
{
   stroke(0);
   fill(185,131,77);
   rect(215, 45, 470, 630);
   fill(0);
   rect(250, 60, 420, 600, 7);
   strokeWeight(2);
   fill(240,200,159);
   rect(215, 45, 20, 630);
   rect(685, 45, 20, 630);
   rect(235, 25, 450, 20);
   rect(235, 675, 450, 20);
   rect(215, 25, 20, 20);
   rect(215, 675, 20, 20);
   rect(685, 25, 20, 20);
   rect(685, 675, 20, 20);
   line(235, 45, 255, 65);
   line(235, 675, 255, 655);
   line(665, 65, 685, 45);
   line(685, 675, 665, 655);
   ellipse(805, 160, 170, 260);
   rect(740, 340, 140, 240);
   rect(48, 73, 125, 165);
   rect(38, 300, 153, 300);
   fill(185,131,77);
   rect(52, 315, 125, 270);
   rect(750, 350, 120, 220);
   rect(58, 83, 105, 145);
   ellipse(805, 160, 140, 230);
   fill(180);
   ellipse(805, 160, 130, 220);
   rect(760, 360, 100, 200);
   rect(62, 325, 105, 250);
   line(740, 340, 760, 360);
   line(740, 580, 760, 560);
   line(880, 340, 860, 360);
   line(880, 580, 860, 560);
   line(58, 228, 68, 215); 
   line(164, 228, 138, 205);
   line(164, 82, 138, 110);
   line(58, 82, 65, 90);
   image(img, 65, 90, 90, 130);
   strokeWeight(1);
   stroke(56,51,47);
   for(int i = 250; i<640; i += 30)
   {
     lineasy(i,60);
   }
   for(int j = 60; j<630; j += 30)
   {
     lineasx(250,j);
   }
   stroke(235);
   drawFigura();
   TIEMPO(500);
   fill(#FFBA38);
   square(770, 400, 35);
   square(805, 400, 35);
   square(805, 435, 35);
   square(805, 470, 35);
}
void Rotar(int colour, int []lista){
fill(colour);
for (int i = 0; i <= 8; i++) {
  if ((lista[Rotation] & (1 << 8 - i)) != 0) {
     rect((i % 3) * 30 + movimientox, (((i / 3) | 0) * 30) + movimientoy , 30, 30); } 
 }
}
void TIEMPO(int rangoTiempo){
  if ((movimientoy < 600)&&(millis() - Segundos >= rangoTiempo)){
     movimientoy += 30;
     Segundos = millis();
    }
}
void drawFigura() {
  push();
  if ( PiezaRandom == "T")
     Rotar(#CA08CD, T); 
  if (PiezaRandom == "L")
     Rotar(#FFBA38, L);
  if (PiezaRandom == "J")
     Rotar(#7AF0F9, J);
  if (PiezaRandom == "O")
  {  fill(#F9F227);
     for (int i = 0; i <= 3; i++) {
        rect(((i % 2) * 30) + movimientox, (((i / 2) | 0) * 30) + movimientoy, 30, 30);}     
  }
  if (PiezaRandom == "S")
         Rotar(#EE1106, S);
    if (PiezaRandom == "Z")
        Rotar(#67BD52, Z);
    if (PiezaRandom == "I")
  {  fill(#4248FF);
     for (int i = 0; i <= 15; i++) {
       if ((I[Rotation] & (1 << 15 - i)) != 0) {
         rect(((i % 4) * 30) + movimientox, (((i / 4) | 0) * 30)+ movimientoy, 30, 30);}     
    }
  }
  pop();
}
void keyPressed() {
   if (key == ' ') {
       Rotation ++;
    }
   if (key == CODED) {
     if (keyCode == UP) {
      Rotation --;}
      else if(keyCode == RIGHT){
        movimientox += 30; 
      }
      else if(keyCode == LEFT){
        movimientox -= 30;}
      else if(keyCode == DOWN){
         TIEMPO(45);
      }
   if (movimientox < 250)
       movimientox = 250; 
   if (movimientox > 580)
       movimientox = 580; }
   Rotation = Rotation < 0 ? 3 : Rotation % 4;
}
method Occupado(){
  return false;
}
