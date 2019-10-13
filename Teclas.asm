.MODEL small
.STACK
.DATA
    num1 DB ?
    num2 DB ?
    pedirnumero DB 10,'Ingrese un numero:$'
    stotal DB 10,'Total:$'
    sdiferencia DB 10,'Diferencia:$'
    sproducto DB 10,'Producto:$'
    scociente DB 10,'Cociente:$'
    sresiduo DB 10,'Residuo:$'
    key_up DB 10,'Tecla arriba$'
    key_down DB 10,'Tecla abajo$'
    key_right DB 10,'Tecla derecha$'
    key_left DB 10,'Tecla izquierda$'
    fila DB ?
    columna DB ?
.CODE
programa:

    MOV AX, @Data
    MOV DS, AX

PedirTecla:
    ;Imprimir para pedir numero 1
    XOR DX, DX
    XOR AX, AX
    MOV DX, offset pedirnumero
    MOV AH, 09h
    INT 21h


    ;Leer numero 1
    XOR AX, AX
    XOR AL, AL
    MOV AH, 01h
    INT 21h
    MOV num1, AL
    ;SUB num1, 30h


            ;Imprimir enter
    XOR DX, DX
    XOR AX, AX
    MOV DL, 10
    MOV AH, 02h
    INT 21h
    
    XOR CX, CX
    MOV Cl, num1
    
    CMP Cl, 48h
    JE Arriba
    CMP Cl, 50h
    JE Abajo
    CMP Cl, 4Dh
    JE Derecha
    CMP Cl, 4Bh
    JE Izquierda
    JMP PedirTecla
    
    
 Arriba:
    XOR DX, DX
    XOR AX, AX
    MOV DX, offset key_up
    MOV AH, 09h
    INT 21h
    JMP PedirTecla 
Abajo:
    XOR DX, DX
    XOR AX, AX
    MOV DX, offset key_down
    MOV AH, 09h
    INT 21h
    JMP PedirTecla 
Derecha:
    XOR DX, DX
    XOR AX, AX
    MOV DX, offset key_right
    MOV AH, 09h
    INT 21h
    JMP PedirTecla 
Izquierda:
    XOR DX, DX
    XOR AX, AX
    MOV DX, offset key_left
    MOV AH, 09h
    INT 21h
    JMP PedirTecla 
;    MOV Cl, num1
;Imprimir:
;    XOR DX, DX
;    MOV Dl, Cl
;    MOV Ah, 02h
;    INT 21h
;    Loop Imprimir

;    Imprimir para pedir numero 2
;    XOR DX, DX
;    MOV DX, offset pedirnumero
;    MOV AH, 09h
;    INT 21h
;
;
;    Leer numero 2
;    XOR AX, AX
;    XOR AL, AL
;    MOV AH, 01h
;    INT 21h
;    MOV num2, AL
;    SUB num2, 30h
;
;
;            Imprimir enter
;    XOR DL, DL
;    XOR AH, AH
;    MOV DL, 10
;    MOV AH, 02h
;    INT 21h
;
;
;    Imprimir TOTAL
;    XOR DX, DX
;    MOV DX, offset stotal
;    MOV AH, 09h
;    INT 21h
;
;
;    SUMA Y MOSTRAR
;    XOR AL, AL
;    MOV AL, num1
;    ADD AL, num2
;    ADD AL, 30h
;    MOV DL, AL
;    MOV AH, 02h
;    INT 21h
;
;
;    Imprimir DIFERENCIA
;    XOR DX, DX
;    MOV DX, offset sdiferencia
;    MOV AH, 09h
;    INT 21h
;
;
;    DIFERENCIA Y MOSTRAR
;    XOR AL, AL
;    MOV AL, num1
;    SUB AL, num2
;    ADD AL, 30h
;    MOV DL, AL
;    MOV AH, 02h
;    INT 21h
;
;
;    Imprimir PRODUCTO
;    XOR DX, DX
;    MOV DX, offset sproducto
;    MOV AH, 09h
;    INT 21h
;
;
;    PRODUCTO Y MOSTRAR
;    XOR AL, AL
;    MOV AL, num1
;    MUL num2
;    ADD AL, 30h
;    MOV DL, AL
;    MOV AH, 02h
;    INT 21h
;
;
;    Imprimir COCIENTE
;    XOR DX, DX
;    MOV DX, offset scociente
;    MOV AH, 09h
;    INT 21h
;
;
;    COCIENTE Y MOSTRAR
;    XOR AX,AX
;    XOR CX,CX
;    MOV CL, num1
;    XOR CH,CH
;    MOV AX,CX
;    div num2
;    ADD AL, 30h
;    MOV DL, AL
;    MOV AH, 02h
;    INT 21h
;
;
;    Imprimir RESIDUO
;    XOR DX, DX
;    MOV DX, offset sresiduo
;    MOV AH, 09h
;    INT 21h
;
;    RESIDUO Y MOSTRAR
;    XOR AX,AX
;    XOR CX,CX
;    MOV CL, num1
;    XOR CH,CH
;    MOV AX,CX
;    div num2
;    ADD AH, 30h
;    MOV DL, AH
;    MOV AH, 02h
;    INT 21h

Finalizar:
    ;Finalizar Programa
    XOR AH, AH
    Mov AH,4CH
    INT 21h

END programa