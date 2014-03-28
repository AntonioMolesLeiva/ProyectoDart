import 'dart:html';
import 'dart:math';
limpiar(){
 // window.alert("Se va a limpiar la mesa");
  querySelector("#crupier").nodes.clear();
  querySelector("#jugador").nodes.clear();
  cartasuser.clear();
  cartascrupier.clear();
}
confirmarApuesta(MouseEvent event){
  apuestaconfirmada=true;
//  limpiar();
  inicializar();
  window.alert("Apuesta confirmada");
}
contarPuntosJugador(){
  var total=0;
  for(var i=0;i<cartasuser.length;i++){
        if(cartas[cartasuser[i]].substring(14, 16) == "0a"){
          if(total+11<=21){
            total+=11;
          }
          else
            total+=1;
        }
        else{
          total=total+int.parse(cartas[cartasuser[i]].substring(14, 16));
        }
      }
  return total;
}
contarPuntosCrupier(){
  var total=0;
  for(var i=0;i<cartascrupier.length;i++){
        if(cartas[cartascrupier[i]].substring(14, 16) == "0a"){
          if(total+11<=21){
            total+=11;
          }
          else
            total+=1;
        }
        else{
          total=total+int.parse(cartas[cartascrupier[i]].substring(14, 16));
        }
      }
  return total;
}
void aumentarApuesta(MouseEvent event){
  // Máximo de apuesta es 20, aumenta de 5 en 5
  if(!apuestaconfirmada){
    if(apuesta+5<=20)
      apuesta+=5;
     querySelector("#apuesta").nodes[1].text=apuesta.toString();
  }
    else
      window.alert("No puedes cambiar la apuesta una vez confirmada");
}
void disminuirApuesta(MouseEvent event){
  // Mínimo de apuesta es 20, disminuye de 5 en 5
  if(!apuestaconfirmada){
    if(apuesta-5>0)
      apuesta-=5;
    querySelector("#apuesta").nodes[1].text=apuesta.toString();
  }
  else
    window.alert("No puedes cambiar la apuesta una vez confirmada");
}
void pedirCarta(MouseEvent event){
  if(apuestaconfirmada){
    // Doy la carta
    var aleatorio = new Random();
    cartasuser.add(aleatorio.nextInt(cartas.length));
    var imagen = new ImageElement(src:cartas[cartasuser.last], width: 100, height: 150);
    querySelector("#jugador").nodes.add(imagen);
    
    // Compruebo si el usuario excede el 21
    var total=contarPuntosJugador();
    if(total>21){
      apuestaconfirmada=false;
      dinero -= apuesta;  
      window.alert("Has perdido $apuesta fichas");
//      limpiar();
    }
    //dinero+=10;
    querySelector("#fchas").nodes[1].text=dinero.toString();
//    print("Tienes $total puntos");
  }
  else
    window.alert("Debes confirmar la apuesta.");
}
void jugadaCrupier(MouseEvent event){
  if(apuestaconfirmada){
    var imagen = new ImageElement(src:cartas[cartascrupier[1]], width: 100, height: 150);
      try{
        querySelector("#crupier").nodes[2]=imagen;
      }catch(e){
//        querySelector("#crupier").nodes.add(imagen);
//        querySelector("#crupier").nodes[2]=imagen;
      }
     // if(int.parse(cartas[cartascrupier[0]].substring(14, 16))+int.parse(cartas[cartascrupier[1]].substring(14, 16))>=17){
        if(contarPuntosCrupier()<contarPuntosJugador()){
          while(contarPuntosCrupier()<contarPuntosJugador() && contarPuntosCrupier()<=21){ // 17?
            // SACO CARTA PARA EL CRUPIER
            var aleatorio = new Random();
            cartascrupier.add(aleatorio.nextInt(cartas.length));
            var imagen = new ImageElement(src:cartas[cartascrupier.last], width: 100, height: 150);
            querySelector("#crupier").nodes.add(imagen);
          }
          // comprobar si el crupier ha ganado o se ha pasado
          if(contarPuntosCrupier()<=21 && contarPuntosCrupier()>contarPuntosJugador()){
            dinero-=apuesta;
            querySelector("#fchas").nodes[1].text=dinero.toString();
            window.alert("Has perdido $apuesta fichas");
          }
          else if(contarPuntosCrupier()<contarPuntosJugador() || contarPuntosCrupier()>21){
            dinero+=apuesta;
            querySelector("#fchas").nodes[1].text=dinero.toString();
            window.alert("Has ganado $apuesta fichas");
          }
          apuestaconfirmada=false;
//          limpiar();
        }
        else{
          dinero-=apuesta;
          apuestaconfirmada=false;
          querySelector("#fchas").nodes[1].text=dinero.toString();
          window.alert("Has perdido $apuesta fichas");
//          limpiar();
        }
     // }
  }
  else
    window.alert("Debes confirmar la apuesta");
  
}

// VARIABLES GLOBALES
List cartas = new List<String>();
List cartasuser = new List();
List cartascrupier = new List();
num dinero = 200;
num apuesta = 5;
bool apuestaconfirmada = false;

inicializar(){
  // Carta incógnita
  var secreto = new ImageElement(src:"./img/reverso.jpg", width: 100, height: 150);
  
  // Generar 2 números aleatorios entre 1 y la cantidad de cartas para el crupier
  var aleatorio = new Random();
  cartascrupier.add(aleatorio.nextInt(cartas.length));
  cartascrupier.add(aleatorio.nextInt(cartas.length));
  
  
  // Mano inicial del crupier
  var imagen = new ImageElement(src:cartas[cartascrupier[0]], width: 100, height: 150);
  querySelector("#crupier").nodes.add(imagen);
  querySelector("#crupier").nodes.add(secreto);

  // Reparto cartas al usuario
  cartasuser.add(aleatorio.nextInt(cartas.length));
  cartasuser.add(aleatorio.nextInt(cartas.length));
  
  imagen = new ImageElement(src:cartas[cartasuser[0]], width: 100, height: 150);
  querySelector("#jugador").nodes.add(imagen);
  imagen = new ImageElement(src:cartas[cartasuser[1]], width: 100, height: 150);
  querySelector("#jugador").nodes.add(imagen);
  
  // Compruebo si ha salido blackjack a la primera
  if (contarPuntosCrupier()==21){
    var imagen = new ImageElement(src:cartas[cartascrupier[1]], width: 100, height: 150);
    querySelector("#crupier").nodes[2]=imagen;
    window.alert("Blackjack del crupier! Has perdido $apuesta fichas");
    dinero-=apuesta;
    apuestaconfirmada=false;
    querySelector("#fchas").nodes[1].text=dinero.toString();
//    limpiar();
  }
  else if(contarPuntosJugador()==21){
    window.alert("Blackjack for you! Has ganado $apuesta fichas");
    dinero-=apuesta;
    apuestaconfirmada=false;
    querySelector("#fchas").nodes[1].text=dinero.toString();
//    limpiar();
  }
  
}
void main() {
  // Asignamos dinero y apuesta inicial
  var dinero = new ParagraphElement();
  dinero.text = dinero.toString();
  var apuesta = new ParagraphElement();
    apuesta.text = apuesta.toString();
  querySelector("#fchas").append(dinero);
  querySelector("#apuesta").append(apuesta);
  querySelector("#fchas").nodes[1].text="200";
  querySelector("#apuesta").nodes[1].text="5";

  // Cargamos cartas del 2 al 10 y luego los ases
  for(var i=2;i<13;i++){
    if(i<10){
      cartas.add("./cartas/cora/0$i.jpg");
      cartas.add("./cartas/pica/0$i.jpg");
      cartas.add("./cartas/romb/0$i.jpg");
      cartas.add("./cartas/treb/0$i.jpg");
    }
    else{
      cartas.add("./cartas/cora/$i.jpg");
      cartas.add("./cartas/pica/$i.jpg");
      cartas.add("./cartas/romb/$i.jpg");
      cartas.add("./cartas/treb/$i.jpg");
    }
  }
  cartas.add("./cartas/cora/0a.jpg");
  cartas.add("./cartas/pica/0a.jpg");
  cartas.add("./cartas/romb/0a.jpg");
  cartas.add("./cartas/treb/0a.jpg");
  
  querySelector("#pedir")
         ..onClick.listen(pedirCarta);
  querySelector("#aumentar")
         ..onClick.listen(aumentarApuesta);
  querySelector("#disminuir")
         ..onClick.listen(disminuirApuesta);
  querySelector("#plantarse")
         ..onClick.listen(jugadaCrupier);
  querySelector("#confirmar")
         ..onClick.listen(confirmarApuesta);
//  print(cartas[0].substring(14, 16));
  
}