PImage img; 
PFont myFont;
int [] L = {17504, 3712, 50240, 736};
int [] T = {3648, 19520, 19968, 17984};
int [] J = {17600, 36352, 25664, 3616};
int [] O = {52224,52224,52224,52224};
int [] Z = {3168, 19584, 3168,19584};
int [] S = {1728,35904, 1728, 35904};
int [] I = {4369, 3840, 4369, 3840};
String [] Piezas = {"L","T","J","O","S","Z","I"};
int Rotation;
String PiezaRandom = Piezas[int(random(7))];
int movimientoy = 30;
int movimientox = 490;
int Segundos;
int [][] matrix = new int [21][16];
int FilaEnJuego = 0;
int ColumnaEnJuego = 9;
Boolean Coliciona = false;
Boolean FijarFicha = false;
void setup()
   {
   img = loadImage("postertetris.png");
   size(900,700);
   background(207);
   myFont = createFont("Showcard Gothic", 20);
   textFont(myFont);
   textAlign(CENTER, CENTER);
   text("JULIANA", 800, 680);
   for(int i = 0; i <21;i ++){
       matrix [i][0] = 1;
       matrix [i][15]= 1;}
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
for (int i = 0; i <= 15; i++) {
  if ((lista[Rotation] & (1 << 15 - i)) != 0) {
     rect((i % 4) * 30 + movimientox, (((i / 4) | 0) * 30) + movimientoy , 30, 30); } 
 }
 GuadarEnMatriz(lista[Rotation]);
}
void TIEMPO(int rangoTiempo){
  if ((movimientoy < 600)&&(millis() - Segundos >= rangoTiempo)){
     movimientoy += 30;
     Segundos = millis();
    }
  else if (movimientoy >= 600){
     FijarFicha = true;
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
     Rotar(#F9F227, O);
  if (PiezaRandom == "S")
         Rotar(#EE1106, S);
  if (PiezaRandom == "Z")
        Rotar(#67BD52, Z);
   if (PiezaRandom == "I")
        Rotar(#4248FF, I);
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
        ColumnaEnJuego += 1;
      }
      else if(keyCode == LEFT){
        movimientox -= 30;
        ColumnaEnJuego -= 1;
    }
      else if(keyCode == DOWN){
         TIEMPO(45);
      }
   if (movimientox < 250)
       movimientox = 250; 
   if (movimientox > 580)
       movimientox = 580; }
   Rotation = Rotation < 0 ? 3 : Rotation % 4;
}
void GuadarEnMatriz( int t)
{
int l = ColumnaEnJuego;
int z = FilaEnJuego;
int BitParaProbar = 32768;
for (int m = 0; m < 16; m++) {      
     if ((t & BitParaProbar)!= 0)
       { 
         if (matrix[z][l] == 0 ){
             if (FijarFicha == true){
                  matrix[z][l] = 1;}
           }
          else
             {
               Coliciona= true;
               break;    
             }
     }
     if (l >(ColumnaEnJuego + 2)){
          l =ColumnaEnJuego;
          z += 1;}
           else{
                l++;} 
     BitParaProbar = BitParaProbar >> 1;
  }
System.out.println("Inicio Juego");
for (int k = 0; k < matrix.length; k++) {
        for (int j = 0; j < matrix[k].length; j++) {
                System.out.print(matrix[k][j] + " ");}
  System.out.println();
     }
}
