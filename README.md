# TetrisCode
## Tetrominos
En el tetris existen 7 tetrominos. Cada unos de ellos fue representado usando una lista de numeros enteros de su representacion binaria usando 16bits para cada rotacion. 
Por ejemplo si tenemos el tetromino I:
1000
1000
1000
1000
= 4369 - Es el primer elemento de la lista I
## Rotaciones
Para la rotacion se itero por la lista del tetromino.Siendo la variable rotacion el indice de la lista.Cuando el usuario oprimela tecla del espacio, se aumenta la rotacion, lo que produce una rotacion a la derecha cuando oprime la flecha para arriba se rota hacia la izquierda.
## Guardar en Memoria Y Colisiones.
Para guardar el estado actual de el tablero se utilizo una matriz de 21 filas y 16 columnas. El tablero de este tetris es de 20 x 14, se agrego una fila y dos columnas adicionales de 1s para realizar los limtes.
La funcion Guardar en Memoria se llama varias veces, cada vez que hay movimiento o una ficha nueva. Esta función realizar varias cosas. Primero evalua de acuerdo con la ficha actual y su rotacion actual(guarda en Variable FichaEnJuego) cabe en tal posicion u ocurre una colisión. Para esto recorre los bits de la rotacion, si el bit actual es diferente a 0, se evalua si existe un espacio para dicho bit para eso se mira la Matriz. Sino hay espacio para dicho tetromino colisiona se vuelve verdadero. Es importante recalcar que aunque se este constantemente evaluando colisiones la ficha no se guarda en la matriz hasta que llegue a la parte de abajo del tablero o a colsionar con una ficha. Para esto es la segunda funcion que tiene esta función, para fijar la ficha. Cuando la ficha ya no puede mover más se guarda esta ficha en la matriz para futuras colisiones y eliminar fichas.
```
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
```
## Movimiento de Tetrominos
### Movimiento en x
Cuando el usuario oprime las flechas de derecha y izqueirda, se evalua si se puede mover a dicho sitio si, si se aumenta el valor en x una casilla y la columna en la eventualmente se va a guardar en memoria.
### Movimiento en Y
En el juego cada 500 milisegundos se baja el tetromino una casilla, si el usuario oprime la flecha de abajo es cada 45. Si la ficha colisiona con el limite de abajo o con otro ficha se fija la ficha, no disminuye más su posición y se reestablecen los valores a los originales para poder que la siguiente ficha baje.
```
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

```
## Dibujar Fichas Fijadas.
Se realizo un loop para mirar en la matriz de la memoria cuál cuadrado esta ocupado. El cuadro que esta ocupado se dibuja.
```
void DibujarFichasFijas(){
   for (int indiceM = 0 ; indiceM < 20 ;indiceM ++){ // Loop por cada cuadro cuadricula para ver si esta ocupado.
        for (int jM = 1; jM < 15; jM++) {
            if (matrix[indiceM][jM] != 0){
               fill(#94C0FF);
               rect(220 + (jM * 30), 60 + (indiceM * 30), 30, 30); }
          }
        }
      }
```
## Eliminar Ficha
Para eliminar una ficha se recorrio la la matriz en busqueda de una fila con unos la fila que tenia unos se elimnaba y se intercambian la filas anteriores. Si la fila es eliminada se tiene que suma al score y las lineas eliminadas.
```
for (int iME = 19 ; iME >0 ;iME --){
        Boolean siEliminarFila = true;
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
```
# Perder
Se realizo un exception en el loop de Guardar en Memoria, entra en este exception cuando las fichas ya no se pueden guardar en memoria por que no hay espacio. Aqui se puso un booleano de Perder igual a verdadero para poder luego dibujar un cuadrado negro encima de la cuadricula con unas letras para avisarle al usuario que ha perdido.

```

if (Perder == true){
      fill(0);
      rect(250, 60, 420, 600, 7);
      fill(255);
      MyFont = createFont("Showcard Gothic", 40);
      textFont(MyFont);
      text("You", 450, 320);
      text("Lost", 450, 390);}
      
```

