# poker
Necesario:
- Ruby: 2.3.1p112
- Rails: 5.1.4


Breve reseña de los metodos:

Metodos en ApplicationController
  - pars: retorna las cartas pares que hay en la mano.*
  - three: retorna la carta que se repite tres veces.*
  - direct: retorna verdadero o falso si la mano tiene una combinacion de escalera.*
  - flush: retorna verdadero o falso si la mano tiene todas las cartas del mismo palo.*
  - full_house: retorna verdadero o falso si la mano tiene tres de una clase y un par.*
  - four_class: retorna verdadero o falso si la mano tiene cuatro cartas del mismo valor.*
  - straight_flush: retorna verdadero o falso si la mano tiene todas las cartas son valores consecutivos del mismo palo.
  - royal_flush: retorna verdadero o falso si la mano tiene Diez, Jack, Reina, Rey, As del mismo palo.
  - qualification: retorna un array [rango, combinacion] las cuales depende de la clasificacion de la mano.
  - earch_high_card: retorna un array [rango de carta alto, nombre de la carta]

Metodos en PokersController
  - before_action :set_token: verifica si el token para las consultas se encuentra vacio, en dado caso solicita uno.
  - get_hand: El metodo regresa un array de las dos manos solicitadas para la comparacion.
  
Notas extras:

- Al momento de solicitar las manos para posteriormente compararlas y clasificarlas se verifica la vigencia del token para la solicitud, en caso que haya expirado lo regenera(Barajea la baraja) y en el mismo caso si se llegan a culminar las cartas.

- EL problema de conexion se solvento con un bucle que verifica el code del responde de la peticion http.
