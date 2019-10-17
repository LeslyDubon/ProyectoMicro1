.MODEL  small
.STACK
.DATA
                        ;;;;;VARIABLES PARA ALMACENAR POSICIONES GENERALES
    filas DB ?              ;variable que guarda el numero de filas del tablero
    columnas DB ?           ;variable que guarda el numero de columnas del tablero
    contarr DB 0
    posicionx DB ?
    tecla DB ?
    repeticion DB ?
                        ;;;;;VARIABLES QUE MUESTRAN UN MENSAJE EN PANTALLA
    mensajeGO DB 'GAME OVER$'
    mensajeFilas DB 'Ingrese la cantidad de filas: $'
    mensajeColumnas DB 'Ingrese la cantidad de columnas: $'
    mensajeRetroceso DB 'No es un movimiento valido, no se puede retroceder$'
                        ;;;;;VARIABLES CONTADORES
    tamanio Dw 0
    dos DB 2
    contadorfila DB 0
    contadorcolumna DB 0
    tamanioAJ DB 0
                        ;;;;;VARIABLES DE LA SERPIENTE
    pila dw 30 dup(?)       ;arreglo donde se guardan las posiciones de la serpiente
    nuevaposicion Dw ?
    cabeza DW ?
    puntero DB 0
    viejacabeza DW ?
    nuevacabeza DW ?
                        ;;;;;VARIABLES DE LAS MANZANAS
    manzanas dw 5 dup(5)    ;arreglo donde se guardan las posiciones de las manzanas
    punteromanzana DW 0
    tamaniomanzanas DW 0
.CODE
programa:
                        ;;;;;TRASLACION DE DATA AL DATA SEGMENT
    MOV AX, @DATA
    MOV DS, AX
                        ;;;;;INGRESO DEL TAMANIO DEL TABLERO
                            ;\\\INGRESO DEL NUMERO DE FILAS\\\
                            ;se imprime el mensaje para pedir el numero de filas
    MOV DX, offset mensajeFilas
    MOV AH, 09h
    INT 21h
    XOR AX, AX
                            ;se lee el numero de filas ingresadas por el usuario
    MOV AH, 01h
    INT 21h
                            ;se le resta 30h para que sea el numero real y lo mueve a filas
    SUB AL, 30h
    MOV filas, AL 
                            ;salto de linea
    MOV DL, 10
    MOV AH, 02
    INT 21h
                            ;\\\INGRESO DEL NUMEOR DE COLUMNAS\\\
                            ;se imprimer el mensaje para pedir el numero de columnas
    MOV DX, offset mensajeColumnas
    MOV AH, 09h
    INT 21h
    XOR AX,AX
                            ;se lee el numeor de columnas ingresadas por el usuario
    MOV AH, 01h
    INT 21h
                            ;se le resta 30h para que sea el numero real y lo mueve a columnas
    SUB AL, 30h
    MOV columnas,AL
                            ;salto de l?nea
    MOV DL, 10
    MOV AH, 02
    INT 21h
                        ;;;;;CREACION DE LA SESION DE JUEGO E INICIALIZACION DE VARIABLES DE JUEGO
iniciartablero:
                            ;\\\ASIGNACION DEL PUNTO 0,0 DEL PLANO\\\
                            ;asignacion de AH como x
    MOV AL, filas
    MOV posicionx, AL
    ADD posicionx,5
    MOV AH,posicionx
                            ;asignacion de AL como y
    MOV AL,columnas
                            ;asignacion de la nueva posicion
    MOV nuevaposicion, AX
                            ;\\\INICIALIZACION DE LA SERPIENTE\\\
                            ;llenado de la --PRIMERA-- posicion (cola) en el arreglo de la serpiente
    xor bx, bx
    mov bx, offset pila     ;asigna lo que existe en el arreglo pila a Bx
    XOR AX, AX
    MOV Ax, tamanio
    add bx,ax               ;bx funcionara como puntero y se le suma el tamanio actual de la serpiente
    MOV cx, nuevaposicion
    mov [bx], cx            ;en la posicion tamanio del arreglo pila se asigna el nuevo valor 
    INC tamanio
    INC tamanio
                            ;llenado de la --SEGUNDA-- poscion en el arreglo de la serpiente
    SUB posicionx, 1        ;se le resta 1 para moverse una posicion a la derecha en x
    XOR AX, AX 
    xor bx, bx 
    MOV AH,posicionx        ;se asigna un nuevo valor para x
    MOV AL,columnas         ;se signa el mismo valor anterior de y
    MOV nuevaposicion, AX   ;se genear la nueva posicion de la serpiente
    xor bx, bx
    mov bx, offset pila     ;asigna lo que existe en el arreglo pila a Bx
    XOR AX, AX
    MOV Ax, tamanio
    add bx,ax               ;bx funcionara como puntero y se le suma el tamanio actual de la serpiente
    XOR AX,AX
    MOV AX, nuevaposicion 
    mov [bx], AX            ;en la posicion tamanio del arreglo pila se asigna el nuevo valor 
    INC tamanio
    INC tamanio
    INC tamanioAJ
                            ;llenado de la --TERCERA-- posicion en el arreglo de la serpiente
    SUB posicionx, 1        ;se le resta 1 para moverse una posicion a la derecha en x
    XOR AX, AX 
    xor bx, bx 
    MOV AH,posicionx        ;se asigna un nuevo valor para x
    MOV AL,columnas         ;se signa el mismo valor anterior de y
    MOV nuevaposicion, AX   ;se genear la nueva posicion de la serpiente
    xor bx, bx
    mov bx, offset pila     ;asigna lo que existe en el arreglo pila a Bx
    XOR AX, AX
    MOV Ax, tamanio
    add bx,ax               ;bx funcionara como puntero y se le suma el tamanio actual de la serpiente
    XOR AX,AX
    MOV AX, nuevaposicion 
    mov [bx], AX            ;en la posicion tamanio del arreglo pila se asigna el nuevo valor
    INC tamanio
    INC tamanio
    INC tamanioAJ
                            ;llenado de la --CUARTA-- posicion en el arreglo de la serpiente
    SUB posicionx, 1        ;se le resta 1 para moverse una posicion a la derecha en x
    XOR AX, AX 
    xor bx, bx 
    MOV AH,posicionx        ;se asigna un nuevo valor para x
    MOV AL,columnas         ;se signa el mismo valor anterior de y
    MOV nuevaposicion, AX   ;se genear la nueva posicion de la serpiente
    xor bx, bx
    mov bx, offset pila     ;asigna lo que existe en el arreglo pila a Bx
    XOR AX, AX
    MOV Ax, tamanio
    add bx,ax               ;bx funcionara como puntero y se le suma el tamanio actual de la serpiente
    MOV AX, nuevaposicion
    mov [bx], AX            ;en la posicion tamanio del arreglo pila se asigna el nuevo valor
    mov viejacabeza, AX     ;se guarda la posicion anterior a la final (cabeza) en la variable cabeza anterior
    INC tamanio
    INC tamanio
    INC TamanioAJ
                            ;llenado de la --QUINTA-- posicion (cabeza) en el arreglo de la serpiente
    SUB posicionx, 1        ;se le resta 1 para moverse una posicion a la derecha en x
    XOR AX, AX 
    xor bx, bx
    MOV AH,posicionx        ;se asigna un nuevo valor para x
    MOV AL,columnas         ;se signa el mismo valor anterior de y
    MOV nuevaposicion, AX   ;se genear la nueva posicion de la serpiente
    xor bx, bx
    mov bx, offset pila     ;asigna lo que existe en el arreglo pila a Bx
    XOR AX, AX
    MOV ax, tamanio
    add bx,ax               ;bx funcionara como puntero y se le suma el tamanio actual de la serpiente
    MOV AX, nuevaposicion
    mov [bx], AX            ;en la posicion tamanio del arreglo pila se asigna el nuevo valor
    MOV cabeza, AX          ;se guarda la ultima posicion (cabeza) en la variable cabeza
    INC tamanio
    INC tamanio
    INC tamanioAJ
                            ;\\\INICIALIZACION DE LAS MANZANAS\\\
                            ;llenado de la --PRIMERA-- posicion en el arreglo de manzanas
    XOR BX,BX
    XOR AX,AX
    MOV AH,2              
    MOV AL,1
    MOV nuevaposicion,AX
    XOR BX, BX         
    MOV BX, offset manzanas 
    MOV AX, punteromanzana
    ADD BX,AX           
    MOV AX, nuevaposicion
    MOV [BX], AX  
    INC punteromanzana
    INC punteromanzana 
                            ;llenado de la --SEGUNDA-- posicion en el arreglo de manzanas
    XOR BX,BX
    XOR AX,AX
    MOV AH,7             
    MOV AL,1
    MOV nuevaposicion,AX
    XOR BX, BX         
    MOV BX, offset manzanas 
    MOV AX, punteromanzana
    ADD BX,AX           
    MOV AX, nuevaposicion
    MOV [BX], AX  
    INC punteromanzana
    INC punteromanzana 
                            ;llenado de la --TERCERA-- posicion en el arreglo de manzanas
    XOR BX,BX
    XOR AX,AX
    MOV AH, 7            
    MOV AL, 7
    MOV nuevaposicion,AX
    XOR BX, BX         
    MOV BX, offset manzanas 
    MOV AX, punteromanzana
    ADD BX,AX           
    MOV AX, nuevaposicion
    MOV [BX], AX  
    INC punteromanzana
    INC punteromanzana
                            ;llenado de la --CUARTA-- posicion en el arreglo de manzanas
    XOR BX,BX
    XOR AX,AX
    MOV AH,7             
    MOV AL,1
    MOV nuevaposicion,AX
    XOR BX, BX         
    MOV BX, offset manzanas 
    MOV AX, punteromanzana
    ADD BX,AX           
    MOV AX, nuevaposicion
    MOV [BX], AX  
    INC punteromanzana
    INC punteromanzana  
                            ;llenado de la --QUINTA-- posicion en el arreglo de manzanas
    XOR BX,BX
    XOR AX,AX
    MOV AH,4              
    MOV AL,4
    MOV nuevaposicion,AX
    XOR BX, BX         
    MOV BX, offset manzanas 
    MOV AX, punteromanzana
    ADD BX,AX           
    MOV AX, nuevaposicion
    MOV [BX], AX  
    INC punteromanzana
    INC punteromanzana 
    MOV punteromanzana,0
                        ;;;;;IMPRESION DEL TABLERO Y DE LOS ELEMENTOS DE JUEGO
inicioimpresion:
    MOV repeticion, 00h
    XOR Dx,Dx
    MOV AL, filas
    MUL dos
    ADD AL, 1
    MOV contadorfila, AL
    
    MOV AL, columnas
    MUL dos
    MOV contadorcolumna, AL
                            ;\\\IMPRESION DEL TABLERO\\\
                            ;impresion de las --FILAS-- del tablero
    imprimirfila:
        MOV AL, contadorfila
        SUB AL, 0
        JE imprimircolumna
        JMP comprobarpunto
                            ;impresion de las --COLUMNAS-- del tablero
    imprimircolumna:
        MOV AL, contadorcolumna
        SUB AL, 0
        JE saltocomprobarpared
        MOV DL, 10
        MOV AH, 02h
        INT 21h
        MOV AL, filas
        MUL dos
        ADD AL,1
        MOV contadorfila, AL
        DEC contadorcolumna
        JMP imprimirfila
                            ;impresion de los --PUNTOS-- vacios del tablero
    comprobarpunto:         ;comprueba si el punto actual es un punto que no ocupa una posicion de la serpiente o una manzana (punto vacio)
        MOV AL, contadorcolumna
        MOV AH,contadorfila
        CMP cabeza,AX
        JE imprimircabeza
        xor bx, bx
        mov bx, offset pila
        JMP comprobarcuerpo
    imprimirpunto:          ;imprime un punto en el tablero
        MOV DL, 46
        MOV AH, 02h
        INT 21h
        DEC contadorfila
        JMP imprimirfila
                            ;impresion de la --SERPIENTE-- en el tablero
    comprobarcuerpo:        ;comprueba si el punto actual es un punto que ocupa una posicion del cuerpo de la serpiente 
        mov cx,[bx]
        cmp cx, ax
        JE imprimircuerpo
        CMP cabeza,cx
        JE manzana
        add bx, 2 
        JMP comprobarcuerpo
    imprimircabeza:         ;imprime una Q(cabeza de la serpiente) en el tablero
        MOV DL, 81
        MOV AH, 02h
        INT 21h
        DEC contadorfila
        JMP imprimirfila
    imprimircuerpo:         ; imprime una O(cuerpo de la serpiente) en el tablero
        MOV DL, 79
        MOV AH, 02h
        INT 21h
        DEC contadorfila
        JMP imprimirfila
                            ;----------SALTO INTERMEDIO----------
    saltocomprobarpared:    ;----salta hacia comprobar pared-----
        JMP comprobarpared  ;------------------------------------
                            ;impresion de las --MANZANAS-- en el tablero
    manzana:                ;comprueba si el punto actual es la posicion de una manzana 
        MOV AL,contadorcolumna
        MOV AH,contadorfila
        MOV BX, offset manzanas
        MOV DX, punteromanzana
        ADD BX,DX
        CMP [BX],AX
        JE imprimirmanzana
        JMP imprimirpunto
    imprimirmanzana:        ;imprime una o tildada(manzana) en el tablero
        MOV DL, 224
        MOV AH, 02h
        INT 21h
        DEC contadorfila
        JMP imprimirfila
                            ;\\\IMPRIMIR MENSAJE DE ERROR AL TRATAR DE RETROCEDER\\\
ImprimirRetroceso:
    XOR DX, DX
    MOV DL, 10
    MOV AH, 02h
    INT 21h
    MOV DX, offset mensajeRetroceso
    MOV AH, 09h
    INT 21h
    XOR DX, DX
    MOV DL, 10
    MOV AH, 02h
    INT 21h
    JMP PedirTecla
                        ;;;;;VALIDACION DE NO TOCAR PARED
    ComprobarPared:         ;comprueba si la cabeza de la serpiente esta tocando un pared
        MOV DX,cabeza
        MOV AL,filas
        MUL dos
        ADD AL, 1
        CMP AL,DH
        JE ImprimirGO
        MOV AL,1
        CMP AL,DH
        JE ImprimirGO
        MOV AL, columnas
        MUL dos
        CMP AL,DL
        JE ImprimirGO
        MOV AL,0
        CMP AL,DL
        JE ImprimirGO
                        ;;;;;SECCIONES DE JUCABILIDAD DE SNAKE
PedirTecla:
                            ;\\\LECTURA DE TECLA\\\
    XOR AX, AX
    XOR AL, AL
    MOV AH, 01h
    INT 21h
    MOV tecla, AL           ;se guarda la tecla presionada por el usuario
    MOV Cl, tecla
                            ;\\\COMPARACION DE TECLA\\\
    CMP Cl, 48h             ;compara si se presiona la tecla desplazamiento hacia arriba
    JE Arriba
    CMP Cl, 50h             ;compara si se presiona la tecla desplazamiento hacia abajo
    JE Abajo
    CMP Cl, 4Dh             ;compara si se presiona la tecla desplazamiento hacia derecha
    JE Derecha
    CMP Cl, 4Bh             ;compara si se presiona la tecla desplazamiento hacia izquierda
    JE Izquierda
    CMP Cl, 58h             ;compara si se presiona X mayuscula para salir
    JE saltofinalizar
    CMP Cl, 78h             ;compara si se presion x minuscula para salir
    JE saltofinalizar
    JMP ComprobarPared
                        ;;;;;MENSAJE DE ERROR GAME OVER
ImprimirGO:
    XOR Cx, Cx
    MOV Cl, 20h    
    CicloRT1:    
        MOV Dl, 10
        MOV Ah, 02h
        INT 21h
        LOOP CicloRT1
    XOR DX, DX
    MOV DL, 10
    MOV AH, 02h
    INT 21h
    MOV DX, offset mensajeGO
    MOV AH, 09h
    INT 21h
    XOR DX, DX
    MOV DL, 10
    MOV AH, 02h
    INT 21h
    MOV tamanio, 0
    MOV tamanioAJ, 0
    JMP iniciartablero
                            ;\\\POSIBLES TECLAS QUE PUEDE PRESIONAR EL USUARIO\\\
    Arriba:                 ;al presionar la tecla desplazamiento hacia arriba se realiza lo siquiente
        XOR Cx,Cx
        MOV Cl, tamanioAJ
        MOV Bx, offset pila
        JMP ComprobarManzanaArriba  
    Abajo:                  ;al presionar la tecla desplazamiento hacia abajo se realiza lo siguiente
        XOR Cx,Cx
        MOV Cl, tamanioAJ
        MOV Bx, offset pila
        JMP ComprobarManzanaAbajo
    Derecha:                ;al presionar la tecla desplazamiento hacia derecha se realiza lo siguiente
        XOR Cx,Cx
        MOV Cl, tamanioAJ
        MOV Bx, offset pila
        JMP ComprobarManzanaDerecha
    Izquierda:              ;al presionar la tecla desplazamiento hacia izquierda se realiza lo siguiente
        XOR Cx,Cx
        MOV Cl, tamanioAJ
        MOV Bx, offset pila
        JMP ComprobarManzanaIzquierda
                            ;----------SALTO INTERMEDIO----------
    saltofinalizar:         ;--salta hacia el final del programa-
        JMP finalizar       ;------------------------------------
                            ;----------SALTO INTERMEDIO----------
    saltoinicioimpresion: 
        XOR Cx, Cx
        MOV Cl, 20h      
        CicloRT4:    
            MOV Dl, 10
            MOV Ah, 02h
            INT 21h
            LOOP CicloRT4  ;--salta hacia el final del programa-
        JMP inicioimpresion ;------------------------------------
    RegresarTecla:          ;regresa al inicio de todo para volver a imprimir el nuevo tablero y serpiente
        XOR Cx, Cx
        MOV Bx, offset manzanas
        ADD Bx, punteromanzana
        MOV Ax, [Bx]
        MOV Cl, tamanioAJ
        MOV Bx, offset pila
        CicloPT:            ;compara con todas las posiciones de la serpiente
            MOV Dx, [Bx]
            CMP Dx, Ax
            JE ActualizarManzana
            ADD Bx, 02h
            LOOP CicloPT
        MOV Dx, [Bx]
        CMP Dx, Ax
        JE ActualizarManzana
        XOR Cx, Cx
        MOV Cl, 20h    
        CicloRT:    
            MOV Dl, 10
            MOV Ah, 02h
            INT 21h
            LOOP CicloRT
        JMP InicioImpresion
    ActualizarManzana:
        ADD repeticion, 01h
        CMP repeticion, 05h
        JE saltoinicioimpresion
        INC punteromanzana
        INC punteromanzana
        CMP punteromanzana,10
        JNE RegresarTecla
        MOV punteromanzana,0
        JMP RegresarTecla  
                            ;----------SALTO INTERMEDIO----------
    saltoimprimirGO:        ;---salta hacia imprimir GAME OVER---
        JMP imprimirGO      ;------------------------------------    
                            ;----------SALTO INTERMEDIO----------
    saltoimprimirRetroceso: ;---salta hacia imprimir retroceso---
        JMP imprimirRetroceso;-----------------------------------        
                            ;\\\SI EL USUARIO PRESIONA LA TECLA DESPLAZAMIENTO HACIA ARRIBA\\\
    ComprobarManzanaArriba: ;comprueba si la cabeza de la serpiente toca una manzana al ir hacia arriba
        MOV AX, cabeza
        ADD Al,01h
        MOV nuevacabeza, AX
        MOV BX, offset manzanas
        MOV DX, punteromanzana
        ADD BX,DX
        CMP [BX],AX
        JNE ComprobarRArriba
        INC punteromanzana
        INC punteromanzana 
        CMP punteromanzana,10
        JE  saltoreiniciopunteromanzana
        JMP Incremento
    ComprobarRArriba:       ;comprueba si intenta retroceder al ir hacia arriba
        MOV Bx, offset pila
        MOV AX, cabeza
        ADD Al,01h
        MOV DX, viejacabeza
        CMP AX, DX
        JE saltoimprimirRetroceso
    ComprobarCArriba:       ;comprueba si la cabeza de la serpiente toca una parte del cuerpo al ir hacia arriba
        MOV Ax, cabeza
        ADD Al, 01h
        CicloCA:            ;compara con todas las posiciones de la serpiente
            MOV Dx, [Bx]
            CMP Dx, Ax
            JE saltoimprimirGO
            ADD Bx, 02h
            LOOP CicloCA
        MOV Dx, [Bx]
        CMP Dx, Ax
        JE saltoimprimirGO
        XOR Cx,Cx
        MOV Cl, tamanioAJ
        MOV Bx, offset pila   
    MoverArriba:            ;Mueve todas las posiciones de la serpiente y la nueva cabeza incrementa en 1 el eje y de la anterior cabeza
        XOR AX,AX
        ADD Bx, 02h
        MOV Ax, [Bx]
        SUB Bx, 02h
        MOV [Bx], Ax
        ADD Bx, 02h
        LOOP MoverArriba
        XOR Ax,Ax           ;Asignar el nuevo inicio
        MOV Ax, [Bx]
        MOV viejacabeza, AX
        ADD Al, 01h
        MOV [Bx], Ax
        MOV cabeza, Ax
        JMP RegresarTecla
                            ;----------SALTO INTERMEDIO----------
    saltoimprimirGO1:       ;-----salta hacia saltoimprimirGO----
        JMP saltoimprimirGO ;------------------------------------
                            ;----------SALTO INTERMEDIO----------
    saltoregresartecla:     ;---salta hacia regresar tecla--
        JMP RegresarTecla   ;----------------------------------
                                ;----------SALTO INTERMEDIO----------
    saltoreiniciopunteromanzana:;---salta hacia el reinicio manzana--
        JMP ReinicioPunteroManzana;----------------------------------
                                ;----------SALTO INTERMEDIO----------
    saltoimprimirRetroceso1:    ;---salta hacia imprimir retroceso---
        JMP saltoimprimirRetroceso;----------------------------------
                            ;\\\SI EL USUARIO PRESIONA LA TECLA DESPLAZAMIENTO HACIA ABAJO\\\
    ComprobarManzanaAbajo:  ;comprueba si la cabeza de la serpiente toca una manzana al ir hacia abajo
        MOV AX, cabeza
        SUB Al,01h
        MOV nuevacabeza, AX
        MOV BX, offset manzanas
        MOV DX, punteromanzana
        ADD BX,DX
        CMP [BX],AX
        JNE ComprobarRAbajo
        INC punteromanzana
        INC punteromanzana
        CMP punteromanzana,10
        JE  ReinicioPunteroManzana
        JMP Incremento
    ComprobarRAbajo:        ;comprueba si intenta retroceder al ir hacia abajo
        MOV Bx, offset pila
        MOV AX, cabeza
        SUB Al,01h
        MOV DX, viejacabeza
        CMP AX, DX
        JE saltoimprimirRetroceso1
    ComprobarCAbajo:        ;comprueba si la cabeza de la serpiente toca una parte del cuerpo al ir hacia abajo
        MOV Ax, cabeza
        SUB Al, 01h
        CicloCB:            ;compara con todas las posiciones de la serpiente
            MOV Dx, [Bx]
            CMP Dx, Ax
            JE saltoimprimirGO1
            ADD Bx, 02h
            LOOP CicloCB
        MOV Dx, [Bx]
        CMP Dx, Ax
        JE saltoimprimirGO1
        XOR Cx,Cx
        MOV Cl, tamanioAJ
        MOV Bx, offset pila   
    MoverAbajo:             ;Mueve todas las posiciones de la serpiente y la nueva cabeza decrementa en 1 el eje y de la anterior cabeza
        XOR AX,AX
        ADD Bx, 02h
        MOV Ax, [Bx]
        SUB Bx, 02h
        MOV [Bx], Ax
        ADD Bx, 02h
        LOOP MoverAbajo
        XOR Ax,Ax           ;Asignar el nuevo inicio
        MOV Ax, [Bx]
        MOV viejacabeza, AX
        SUB Al, 01h
        MOV [Bx], Ax
        MOV cabeza, Ax
        JMP RegresarTecla
                            ;\\\SI LA SERPIENTE SE COME UNA MANZANA DEL TABLERO\\\
    ReinicioPunteroManzana: ;reinicia el puntero de manzanas y se dirige al incremento
        MOV punteromanzana, 0
    Incremento:         ;incrementa en un 1 unidad el tamananio de la serpiente, la cabeza anterior se vuelve cuerpo y la nueva cabeza se genera segun la tecla que presiono
        xor bx, bx
        mov bx, offset pila ;Envia lo que existe en la pila a bx
        XOR AX, AX
        MOV AX, cabeza
        MOV viejacabeza, AX
        MOV ax, tamanio
        add bx,ax           ;bx funcionara como contador y se le suma 9 para estar ahora en la posicion 10
        MOV AX, nuevacabeza
        mov [bx], AX        ;A la posicion 10 del arreglo se le asigna el valor de 8
        INC tamanio
        INC tamanio
        INC tamanioAJ
        MOV cabeza, ax 
        JMP saltoregresartecla
                                ;----------SALTO INTERMEDIO----------
    saltoregresartecla1:        ;---salta hacia saltoregresartecla---
        JMP saltoregresartecla  ;------------------------------------
                            ;----------SALTO INTERMEDIO----------
    saltoimprimirGO2:       ;-----salta hacia saltoimprimirGO1---
        JMP saltoimprimirGO1;------------------------------------
                                ;----------SALTO INTERMEDIO----------
    saltoimprimirRetroceso2:    ;---salta hacia imprimir retroceso---
    JMP saltoimprimirRetroceso1 ;------------------------------------
                            ;\\\SI EL USUARIO PRESIONA LA TECLA DESPLAZAMIENTO HACIA DERECHA\\\
    ComprobarManzanaDerecha:;comprueba si la cabeza de la serpiente toca una manzana al ir hacia la derecha
        MOV AX, cabeza
        SUB Ah,01h
        MOV nuevacabeza, AX
        MOV BX, offset manzanas
        MOV DX, punteromanzana
        ADD BX,DX
        CMP [BX],AX
        JNE ComprobarRDerecha
        INC punteromanzana
        INC punteromanzana
        CMP punteromanzana,10
        JE  ReinicioPunteroManzana
        JMP Incremento
    ComprobarRDerecha:      ;comprueba si intenta retroceder al ir hacia derecha
        MOV Bx, offset pila
        MOV AX, cabeza
        SUB Ah,01h
        MOV DX, viejacabeza
        CMP AX, DX
        JE saltoimprimirRetroceso2
    ComprobarCDerecha:      ;comprueba si la cabeza de la serpiente toca una parte del cuerpo al ir hacia derecha
        MOV Ax, cabeza
        SUB Ah, 01h
        CicloCD:            ;compara con todas las posiciones de la serpiente
            MOV Dx, [Bx]
            CMP Dx, Ax
            JE saltoimprimirGO2
            ADD Bx, 02h
            LOOP CicloCD
        MOV Dx, [Bx]
        CMP Dx, Ax
        JE saltoimprimirGO2
        MOV Cl, tamanioAJ
        MOV Bx, offset pila   
    MoverDerecha:           ;Mueve todas las posiciones de la serpiente y la nueva cabeza decrementa en 1 el eje x de la anterior cabeza
        XOR AX,AX
        ADD Bx, 02h
        MOV Ax, [Bx]
        SUB Bx, 02h
        MOV [Bx], Ax
        ADD Bx, 02h
        LOOP MoverDerecha
        XOR Ax,Ax           ;Asignar el nuevo inicio
        MOV Ax, [Bx]
        MOV viejacabeza, AX
        SUB Ah, 01h
        MOV [Bx], Ax
        MOV cabeza, Ax
        JMP saltoregresartecla1
                                ;----------SALTO INTERMEDIO----------
    saltoreiniciopunteromanzana1:;---salta hacia el reinicio manzana--
        JMP ReinicioPunteroManzana;----------------------------------
                                ;----------SALTO INTERMEDIO----------
    saltoregresartecla2:        ;---salta hacia saltoregresartecla1--
        JMP saltoregresartecla1 ;------------------------------------
                            ;----------SALTO INTERMEDIO----------
    saltoimprimirGO3:       ;-----salta hacia saltoimprimirGO2---
        JMP saltoimprimirGO2;------------------------------------
                                ;----------SALTO INTERMEDIO----------
    saltoimprimirRetroceso3:    ;---salta hacia imprimir retroceso---
        JMP saltoimprimirRetroceso2 ;--------------------------------
                            ;\\\SI EL USUARIO PRESIONA LA TECLA DESPLAZAMIENTO HACIA IZQUIERDA\\\
    ComprobarManzanaIzquierda:;comprueba si la cabeza de la serpiente toca una manzana al ir hacia la izquierda
        MOV AX, cabeza
        ADD Ah,01h
        MOV nuevacabeza, AX
        MOV BX, offset manzanas
        MOV DX, punteromanzana
        ADD BX,DX
        CMP [BX],AX
        JNE ComprobarRIzquierda
        INC punteromanzana
        INC punteromanzana
        CMP punteromanzana,10
        JE  saltoreiniciopunteromanzana1
        JMP Incremento
    ComprobarRIzquierda:    ;comprueba si intenta retroceder al ir hacia izquierda
        MOV Bx, offset pila
        MOV AX, cabeza
        ADD Ah,01h
        MOV DX, viejacabeza
        CMP AX, DX
        JE saltoimprimirRetroceso3
    ComprobarCIzquierda:    ;comprueba si la cabeza de la serpiente toca una parte del cuerpo al ir hacia izquierda
        MOV Ax, cabeza
        ADD Ah, 01h
        CicloCI:            ;compara con todas las posiciones de la serpiente
            MOV Dx, [Bx]
            CMP Dx, Ax
            JE saltoimprimirGO3
            ADD Bx, 02h
            LOOP CicloCI
        MOV Dx, [Bx]
        CMP Dx, Ax
        JE saltoimprimirGO3
        MOV Cl, tamanioAJ
        MOV Bx, offset pila
    MoverIzquierda:         ;Mueve todas las posiciones de la serpiente y la nueva cabeza incrementa en 1 el eje x de la anterior cabeza
        XOR AX,AX
        ADD Bx, 02h
        MOV Ax, [Bx]
        SUB Bx, 02h
        MOV [Bx], Ax
        ADD Bx, 02h
        LOOP MoverIzquierda
        XOR Ax,Ax           ;Asignar el nuevo inicio
        MOV Ax, [Bx]
        MOV viejacabeza, AX
        ADD Ah, 01h
        MOV [Bx], Ax
        MOV cabeza, Ax
        JMP RegresarTecla

        ;;;;;FINAL DE TODO EL PROGRAMA
finalizar:
        XOR AH, AH
        MOV AH, 4Ch
        INT 21h
END programa