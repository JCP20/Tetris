PImage img; 
PFont myFont;
PFont MyFont;
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
Boolean FijarFicha = false;
Boolean Perder = false;
int FichaEnJuego;
int pindice;
int score;
int FilasCompletas;
String ProximaFicha = PiezaRandom;
void setup()
   {
   img = loadImage("postertetris.png");
   size(900,700);
   background(207);
   myFont = createFont("Showcard Gothic", 25);
   textFont(myFont);
   textAlign(CENTER, CENTER);
   for(int indice = 0; indice <20;indice ++){ // Pone los unos en para los limites
       pindice =  pindice >= 15 ? 15 : indice;
       matrix [indice][0] = 1;
       matrix [indice][15]= 1;
       matrix [20][pindice] = 1;}
   }
void lineasy(int x, int y){  // Dibuja las lineas de la cuadricula
    line(x + 30, y, x + 30, 660); }
void lineasx(int x, int y){
    line(x, y + 30, 670, y + 30);}
void draw()
{  
   stroke(0);
   fill(185,131,77);
   rect(215, 45, 470, 630);
   fill(0); // Rectangulo de cuadricula
   rect(250, 60, 420, 600, 7);
   stroke(56,51,47);
   for(int i = 250; i<640; i += 30) { //Cuadricula
     lineasy(i,60);}
   for(int j = 60; j<630; j += 30){
     lineasx(250,j);} 
   stroke(255);
   stroke(56,51,47);
   strokeWeight(2);
   fill(240,200,159); // Realiza los marcos - decoracion
   rect(215, 45, 20, 630);
   rect(685, 45, 20, 630);
   rect(235, 25, 450, 20);
   rect(235, 675, 450, 23);
   rect(215, 25, 20, 20);
   rect(215, 675, 20, 23);
   rect(685, 25, 20, 20);
   rect(685, 675, 20, 23);
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
   fill(130);
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
   image(img, 65, 90, 90, 130); // Pone la imagen
   strokeWeight(1);
   stroke(255);
   drawFigura(); 
   BajarFicha(500);
   DibujarFichasFijas();
   EliminarFila();
   if (Perder == true){
      fill(0);
      rect(250, 60, 420, 600, 7);
      fill(255);
      MyFont = createFont("Showcard Gothic", 40);
      textFont(MyFont);
      text("You", 450, 320);
      text("Lost", 450, 390);}
   else{
   fill(255);
   text("SCORE", 805, 130);
   text(score, 805, 190);
   text("LINEAS", 115, 430);
   text(FilasCompletas, 115, 490);}
}
void DibujarFichasFijas(){
   for (int indiceM = 0 ; indiceM < 20 ;indiceM ++){ // Loop por cada cuadro cuadricula para ver si esta ocupado.
        for (int jM = 1; jM < 15; jM++) {
            if (matrix[indiceM][jM] != 0){
               fill(#94C0FF);
               rect(220 + (jM * 30), 60 + (indiceM * 30), 30, 30); }
          }
        }
      }
void IniciarVariables(){ //Inicia las variables para cada tetromino
  FilaEnJuego = 0;
  ColumnaEnJuego = 9;
  Rotation = 0;
  PiezaRandom = ProximaFicha;
  ProximaFicha = Piezas[int(random(7))];
  movimientoy = 30;
  movimientox = 490; 
}
void Rotar(int colour, int lista, int x, int y){
fill(colour);
for (int i = 0; i <= 15; i++) {
  if ((lista & (1 << 15 - i)) != 0) {
     rect((i % 4) * 30 + x, (((i / 4) | 0) * 30) + y , 30, 30); } 
  }
 }
void BajarFicha(int rangoTiempo){
  Boolean coliciona = GuadarEnMatriz(FichaEnJuego);
  if ((coliciona == false)&&(millis() - Segundos >= rangoTiempo)){
     movimientoy += 30;
     FilaEnJuego += 1;
     Segundos = millis();
    }
  else if (coliciona == true){
     FijarFicha = true;
     FilaEnJuego -= 1;
     GuadarEnMatriz(FichaEnJuego);
     IniciarVariables();
  }
}
void drawFigura() {
  push();
  if ( PiezaRandom == "T"){  // Dibuja Tetromino
     FichaEnJuego = T[Rotation];
     Rotar(#CA08CD, FichaEnJuego, movimientox, movimientoy); }
  if (PiezaRandom == "L"){
     FichaEnJuego = L[Rotation];
     Rotar(#FFBA38, FichaEnJuego, movimientox, movimientoy);}
  if (PiezaRandom == "J"){
     FichaEnJuego = J[Rotation];
     Rotar(#7AF0F9, J[Rotation], movimientox, movimientoy);}
  if (PiezaRandom == "O"){
     FichaEnJuego = O[Rotation];
     Rotar(#F9F227, FichaEnJuego, movimientox, movimientoy);}
  if (PiezaRandom == "S"){
      FichaEnJuego = S[Rotation];
      Rotar(#EE1106, FichaEnJuego, movimientox, movimientoy);}
  if (PiezaRandom == "Z"){
       FichaEnJuego = Z[Rotation];
       Rotar(#67BD52, FichaEnJuego ,movimientox, movimientoy);}
  if (PiezaRandom == "I"){
       FichaEnJuego = I[Rotation];
       Rotar(#4248FF, FichaEnJuego, movimientox, movimientoy);}
    if ( ProximaFicha == "T"){ // Dibuja Proxima Ficha
     Rotar(#CA08CD, T[0], 765, 400); }
  if (ProximaFicha == "L"){
     Rotar(#FFBA38, L[0], 755, 410);}
  if (ProximaFicha == "J"){
     Rotar(#7AF0F9, J[0],778, 410);}
  if (ProximaFicha == "O"){
     Rotar(#F9F227, O[0], 780, 420);}
  if (ProximaFicha == "S"){
      Rotar(#EE1106, S[0], 765, 400);}
  if (ProximaFicha == "Z"){
       Rotar(#67BD52, Z[0] ,765, 400);}
  if (ProximaFicha == "I"){
       Rotar(#4248FF, I[0], 710, 400);}
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
        ColumnaEnJuego += 1;
        if(GuadarEnMatriz(FichaEnJuego) ==false)
           movimientox += 30; 
        else
           ColumnaEnJuego -= 1;
      }
      else if(keyCode == LEFT){
        ColumnaEnJuego -= 1;
        if(GuadarEnMatriz(FichaEnJuego) ==false)
           movimientox -= 30; 
        else
           ColumnaEnJuego += 1;
    }
      else if(keyCode == DOWN){
         BajarFicha(45);
         score += 5;
      }
   Rotation = Rotation < 0 ? 3 : Rotation % 4;
   }
}
public Boolean GuadarEnMatriz(int t){
int l = ColumnaEnJuego; // Para recorrer las columnas para evaluar colisiones sin modificar la columna real en la que esta la ficha
int z = FilaEnJuego;
int BitParaProbar = 32768; // Número entero del número binario 10000000000000000
Boolean Coliciona = false;
for (int m = 0; m < 16; m++) {
  try{
     if ((t & BitParaProbar)!= 0)
       {
         if (matrix[z][l] == 0 ){
             if (FijarFicha == true){
                  matrix[z][l] = 1;  //Dibuja la ficha en la Matriz del tablero
                  }
           }
          else
             {
               Coliciona= true;
             }
     }
     if (l >(ColumnaEnJuego + 2)){
          l =ColumnaEnJuego;
          z += 1;}
           else{
                l++;} 
     BitParaProbar = BitParaProbar >> 1;}
   catch(RuntimeException ex){
         Perder = true;}
  }
FijarFicha = false;
return Coliciona;
}
void EliminarFila(){
Boolean siEliminarFila= true;
for (int iME = 19 ; iME >0 ;iME --){
        siEliminarFila = true;
        for (int jME = 0; jME < 16; jME ++) {
                if (matrix[iME][jME] == 0 ){
                   siEliminarFila = false;}
        }
        if (siEliminarFila){
              for (int k = iME; k >=0; k--) {
                for (int m = 0; m < 16; m++) {
                 if (k !=0){
                     matrix [k][m] = matrix [k- 1][m]; 
                    }
                 else {        
                      matrix [k][0] = 1;
                      matrix [k][m] = 0;
                      matrix [k][15]= 1;                
                   }            
                }
            }         
                     iME =iME +1;
                     score += 50;
                     FilasCompletas += 1;
          }
     }
}
