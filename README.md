# prolog-19-meta-orden

Se pide escribir un programa para ordenar listas en el que el criterio de comparacion no este predefinido (se da en la ejecucion) y que ademas lleve a cabo la ordenacion mediante el algoritmo de “arboles flotantes” que se explica mas abajo. La practica consta de las siguientes partes:

1. Programar un predicado ```menor(A,B,Comp,M)```, que devuelva en ```M``` el menor entre ```A``` y ```B``` usando ```Comp``` como criterio de comparacion. Comp es el nombre de un predicado que determina cuando un elemento es igual o mayor que otro. Por ejemplo, ```menor(3,4,<,M)``` devuelve ```M=3```.

2. Programar un predicado ```menor_o_igual/2``` que determina si su primer argumento es menor o igual al segundo de la siguiente forma. Una variable libre es igual a cualquier otro termino. Un termino es menor que otro, no siendo ninguno variable libre, si su nombre es ```@<``` que el del otro, si los nombres son identicos pero su aridad es ```<``` que la del otro, o nombres y aridades son identicas pero alguno de los argumentos del primer termino es menor que el correspondiente argumento del segundo termino segun el siguiente procedimiento:

    Se recorren los argumentos de cada termino de izquierda a derecha y se comparan los de la misma posicion. Si el del primero es menor que el del segundo el primer termino es menor que el segundo. Si son iguales se continua el proceso. Si todos los argumentos son iguales, ambos terminos son iguales.

3. Programar un predicado ```ordenar(Lista,Comp,Orden)``` tal que la lista ```Orden``` es la resultante de ordenar la lista ```Lista``` utilizando ```Comp``` como criterio de comparacion. Para llevar a cabo la ordenacion usaremos arboles flotantes. El arbol inicial contiene como hojas los elementos de la lista de entrada. En un arbol flotante cada nodo interno tiene dos hijos exactamente y su valor es el menor de los de sus hijos. El proceso de tomar el valor de la raız del arbol flotante, reflotarlo y continuar hasta que el arbol este vacıo obtiene la lista ordenada deseada.

    Se pide seguir los siguientes pasos:
    - Programar un predicado lista_hojas(Lista,Hojas) que, dada una lista, devuelve otra con las hojas que compondran el arbol: 
    
    ```
    lista_hojas([1,2,3],Hojas) 
    Hojas = [tree(1,void,void),tree(2,void,void),tree(3,void,void)]
    ```

    - Programar un predicado hojas_arbol(Hoja, Com, Arbol) que, dada la lista de hojas devuelve el arbol flotante inicial:

    ```
    tree(1,tree(1,tree(1,void,void),tree(2,void,void)),tree(3,void,void))
    ```

    - Programar un predicado ```ordenacion(Arbol,Comp,Orden)``` que, dado el arbol inicial, devuelve
en ```Orden``` la lista ordenada.

        El valor de la raız de este arbol es el menor de los elementos de la lista, por lo que este elemento se situa en primer lugar de la lista ordenada de salida. A continuacion se “reflota”el arbol y su nueva raız sera el siguiente elemento de la lista ordenada. Y ası sucesivamente.

        En el arbol flotante todos los nodos del camino que lleva de la raız a la hoja que tiene su mismo valor tienen ese mismo valor, ya que es el menor de todos. Para reflotar el arbol se debe recorrer dicho camino desde la hoja hasta la raız procediendo como sigue. El nodo hoja se elimina (sustituyendolo por un arbol vacıo). Cada nodo que tenga un solo hijo se sustituye por dicho unico hijo (un nodo tal sera el padre de la hoja que se ha eliminado). A cada nodo con dos hijos se le asigna como valor el menor de los de sus hijos.

    - Programar ```ordenar(Lista,Comp,Orden)``` con estos elementos. El segundo argumento de ```ordenar/3``` debe permitir ordenar segun cualquier criterio deseado, siempre que exista un predicado que se pueda utilizar para definir dicho criterio. Por ejemplo, para la ordenacion tradicional de listas de numeros se utilizarıa la llamada ```ordenar([...],’=<’,Orden)```. O, definiendo un predicado ```menor_o_igual/2``` como el de arriba que determina un criterio no estandar de comparacion de terminos se podrıan ordenar listas segun dicho criterio con llamadas como ```ordenar([...],menor_- o_igual,Orden)```.