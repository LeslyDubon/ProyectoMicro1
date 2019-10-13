.MODEL  small
.STACK
.DATA
    num1 DB 4
    num2 DB 4
    tamanio DB 0
    dos DB 2
    contadorfila DB 0
    contadorcolumna DB 0
    nuevaposicion DW ?
    cabeza DW ?
    pila db 30 dup(?)
.CODE
programa:
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AL,3
    MOV AH,1
    
    MOV nuevaposicion, AX
    xor bx, bx          ;Limpia lo que existe en bx
    mov bx, offset pila ;Envia lo que existe en la pila a bx
    XOR AX, AX
    MOV AL, tamanio
    add bx,ax            ;bx funcionara como contador y se le suma 9 para estar ahora en la posicion 10
    MOV AX, nuevaposicion
    mov [bx], AX      ;A la posicion 10 del arreglo se le asigna el valor de 8
    INC tamanio
    
    
    MOV AL,4
    MOV AH,2
    
    MOV nuevaposicion, AX
    xor bx, bx          ;Limpia lo que existe en bx
    mov bx, offset pila ;Envia lo que existe en la pila a bx
    XOR AX, AX
    MOV AL, tamanio
    add bx,ax            ;bx funcionara como contador y se le suma 9 para estar ahora en la posicion 10
    MOV AX, nuevaposicion
    mov [bx], AX      ;A la posicion 10 del arreglo se le asigna el valor de 8
    INC tamanio
    
    MOV AL,4
    MOV AH,3
    
    MOV nuevaposicion, AX
    xor bx, bx          ;Limpia lo que existe en bx
    mov bx, offset pila ;Envia lo que existe en la pila a bx
    XOR AX, AX
    MOV AL, tamanio
    add bx,ax            ;bx funcionara como contador y se le suma 9 para estar ahora en la posicion 10
    MOV AX, nuevaposicion
    mov [bx], AX      ;A la posicion 10 del arreglo se le asigna el valor de 8
    INC tamanio
    
    MOV AL,4
    MOV AH,5
    
    MOV nuevaposicion, AX
    xor bx, bx          ;Limpia lo que existe en bx
    mov bx, offset pila ;Envia lo que existe en la pila a bx
    XOR AX, AX
    MOV AL, tamanio
    add bx,ax            ;bx funcionara como contador y se le suma 9 para estar ahora en la posicion 10
    MOV AX, nuevaposicion
    mov [bx], AX      ;A la posicion 10 del arreglo se le asigna el valor de 8
    INC tamanio
    MOV cabeza, AX

    MOV AL, num1
    MUL dos
    ADD AL, 1
    MOV contadorfila, AL
    
    MOV AL, num2
    MUL dos
    MOV contadorcolumna, AL
    
    
    imprimirfila:
    MOV AL, contadorfila
    SUB AL, 0
    JE imprimircolumna
    JMP comprobarpunto

    imprimircolumna:
    MOV AL, contadorcolumna
    SUB AL, 0
    JE finalizar
    MOV DL, 10
    MOV AH, 02h
    INT 21h
    MOV AL, num1
    MUL dos
    ADD AL,1
    MOV contadorfila, AL
    DEC contadorcolumna
    JMP imprimirfila
    
    comprobarpunto:
    MOV AL, contadorcolumna
    MOV AH,contadorfila
    CMP cabeza,AX
    JE imprimircabeza
    JMP imprimirpunto
    
    imprimirpunto:
    MOV DL, 46
    MOV AH, 02h
    INT 21h
    DEC contadorfila
    JMP imprimirfila
    
    imprimircabeza:
    MOV DL, 81
    MOV AH, 02h
    INT 21h
    DEC contadorfila
    JMP imprimirfila
    
    imprimircuerpo:
    MOV DL, 79
    MOV AH, 02h
    INT 21h
    DEC contadorfila
    JMP imprimirfila
    

    finalizar:
        XOR AH, AH
        MOV AH, 4Ch
        INT 21h
END programa