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
     BitParaProbar = BitParaProbar >> 1;    
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
## Guardar Posicion de Fichas
La rotacion de la las fichas al fijarlas se guarda al igual que su posición en x  y y para luego dibujarla en el ciclo de draw.
```
void IniciarVariables(){
  ListaFigurasEnTablero.add(FichaEnJuego);
  ListaCoorXEnTablero.add(movimientox);
  ListaCoorYEnTablero.add(movimientoy);
  
```
Se dibuja en el draw
```
if (ListaFigurasEnTablero.isEmpty()== false){
     for (int i=0;i<ListaFigurasEnTablero.size();i++){
       Rotar(#94C0FF,ListaFigurasEnTablero.get(i),ListaCoorXEnTablero.get(i),ListaCoorYEnTablero.get(i));}
    }
```
