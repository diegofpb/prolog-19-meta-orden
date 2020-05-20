% Autores de la practica.

% menor/4
menor(A,B,Comp,M):-
	functor(T,Comp,2),
	arg(1,T,A),
	arg(2,T,B),
	call(T),!,
	M = A;
	M = B.

% menor_o_igual(X,Y) determina si su primer argumento es menor o igual al segundo teniendo en cuenta los criterios de comparacion del enunciado.

% Si es variable libre cualquiera de las dos, ya es menor o igual al segundo termino.
es_igual(X,_):-
	var(X).

es_igual(_,Y):-
	var(Y).

es_igual(X,Y):-
	X == Y.

% Una vez aqui, es que ambas son variables instanciadas. Verificamos nombre.
menor_o_igual(X,Y):-
	nonvar(X),
	nonvar(Y),
	functor(X,NombreX,_),
	functor(Y,NombreY,_),
	NombreX @< NombreY.

% Una vez aqui, verificamos aridad de terminos.
menor_o_igual(X,Y):-
	nonvar(X),
	nonvar(Y),
	functor(X,_,AridadX),
	functor(Y,_,AridadY),
	AridadX < AridadY.

% Tanto nombre, como aridad son iguales. Continua.
menor_o_igual(X,Y):-
	nonvar(X),
	nonvar(Y),
	compound(X),
	compound(Y),
	moi_recursivo(X,Y,0).

menor_o_igual(X,Y):-
	es_igual(X,Y).

moi_recursivo(X,Y,Cont):-
	Arg is Cont+1,
	arg(Arg,X,TNuevoX),
	arg(Arg,Y,TNuevoY),
	\+ es_igual(TNuevoX,TNuevoY),
	menor_o_igual(TNuevoX,TNuevoY);
	es_igual(TNuevoX,TNuevoY),
	ContNuevo is Cont+1,
	functor(X,_,Aridad),
	ContNuevo=\=Aridad,
	!,
	moi_recursivo(X,Y,ContNuevo).

% lista_hojas: Dada una lista, devuelve otra con las hojas que compondran el arbol.
lista_hojas(Lista,Hojas):-
	add_hojas_a_lista(Lista,Hojas,[]),
	Hojas = Hojas.
	
add_hojas_a_lista([PH|RH],Hojas,R):-
	functor(Hoja,tree,3),
	arg(1,Hoja,PH),
	arg(2,Hoja,void),
	arg(3,Hoja,void),
	add_hojas_a_lista(RH,Hojas,[Hoja|R]).

add_hojas_a_lista([],L,R):-
	invertir(L,R).


% meter_elemento/2: Predicado que verifica que el tercer argumento es la lista obtenida de meter los elementos de L2 despues de los de L1.
meter_elemento([], L, L).
meter_elemento([X|L1], L2, [X|L3]) :-
	meter_elemento(L1, L2, L3).

% invertir/2: Predicado que invierte la lista.
invertir([],[]).
invertir([X|L1],L2):-
	invertir(L1,L3),
	meter_elemento(L3,[X],L2).
