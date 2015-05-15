
;***********************************************************************************
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;***********************************************************************************
;**																				****
;**							  TECNOLÓGICO DE COSTA RICA					     	****
;**							 ARQUITECTURA DE COMPUTADORES			            ****
;**									   Grupo 40									****
;**																			    ****
;**																				****
;**						             PROYECTO # 2								****
;**																				****
;**																				****
;**									Integrantes:								****
;**																				****
;**							   - Bryan Jimenez Chacon							****
;**		                       - Andrés Mora Miranda							****
;**			                   - Giaccomo Ubaldo Pino 							****
;**																				****
;***********************************************************************************
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;***********************************************************************************


section .bss

	; *** SECTION .BSS ***
	;
	; Aquí se reservan todos los buffers utilizados posteriormente en el programa, el
	; principal es el que contiene a la expresión. Después de este se encuentran los
	; 20 buffers utilizados para las posibles 20 variables que el usuario puede intro-
	; ducir. Además de éstos, también se agregaron otros buffers usados para el funcio-
	; namiento del programa.


	bufferExpresion:	resb buffExpresionLen
	buffExpresionLen:	equ 1024

	bufferExpTemp:		resb buffExpTempLen
	buffExpTempLen:		equ 1024

	bufferExpActual:	resb bufferExpActualLen
	bufferExpActualLen:	equ 1024

	bufferOperacion:	resb bufferOperacionLen
	bufferOperacionLen:	equ 1024

	bufferOperando1:	resb bufferOperando1Len
	bufferOperando1Len: equ 1024

	bufferOperando2:	resb bufferOperando2Len
	bufferOperando2Len: equ 1024

	bufferAtoiTemp:		resb bufferAtoiTempLen
	bufferAtoiTempLen:  equ 1024

	bufferSobra:		resb bufferSobraLen
	bufferSobraLen:		equ 1024

	bufferItoa:			resb bufferItoaLen
	bufferItoaLen:		equ 1024

	buffVar1:			resw 10
	buffVar1Len:		equ $ - buffVar1

	buffVar2:			resw 10
	buffVar2Len:		equ $ - buffVar2

	buffVar3:			resw 10
	buffVar3Len:		equ $ - buffVar3

	buffVar4:			resw 10
	buffVar4Len:		equ $ - buffVar4

	buffVar5:			resw 10
	buffVar5Len:		equ $ - buffVar5

	buffVar6:			resw 10
	buffVar6Len:		equ $ - buffVar6

	buffVar7:			resw 10
	buffVar7Len:		equ $ - buffVar7

	buffVar8:			resw 10
	buffVar8Len:		equ $ - buffVar8

	buffVar9:			resw 10
	buffVar9Len:		equ $ - buffVar9

	buffVar10:			resw 10
	buffVar10Len:		equ $ - buffVar10

	buffVar11:			resw 10
	buffVar11Len:		equ $ - buffVar11

	buffVar12:			resw 10
	buffVar12Len:		equ $ - buffVar12

	buffVar13:			resw 10
	buffVar13Len:		equ $ - buffVar13

	buffVar14:			resw 10
	buffVar14Len:		equ $ - buffVar14

	buffVar15:			resw 10
	buffVar15Len:		equ $ - buffVar15

	buffVar16:			resw 10
	buffVar16Len:		equ $ - buffVar16

	buffVar17:			resw 10
	buffVar17Len:		equ $ - buffVar17

	buffVar18:			resw 10
	buffVar18Len:		equ $ - buffVar18

	buffVar19:			resw 10
	buffVar19Len:		equ $ - buffVar19

	buffVar20:			resw 10
	buffVar20Len:		equ $ - buffVar20

section .data

	; *** SECTION .DATA ***
	;
	; Aquí se reservan todos los strings a imprimir en algún momento en el programa;
	; los cuales incluyen aquellos que le dan instrucciones al usuario y las indica-
	; ciones de posibles errores que se puedan presentar.


	instruccion1: 			db 10,"******************************* Proyecto #2 *******************************",10,0
	lenInstruccion1: 		equ $ - instruccion1

	instruccion2: 			db 10,"      Escriba la expresión matématica con un máximo de 20 variables:",10,0
	lenInstruccion2:		equ $ - instruccion2

	ErrorParentesis: 		db "             Expresión Algebraica inválida: Paréntesis incorrectos",10,0
	lenErrorParentesis:		equ $ - ErrorParentesis

	ErrorGen:				db "                         Expresión Algebraica inválida",10,0
	lenErrorGen:			equ $ - ErrorGen

	ErrorVacio:				db "             		  Expresión Algebraica inválida: Vacía",10,0
	lenErrorVacio:			equ $ - ErrorVacio

	ErrorMaxChar:			db "Expresión Algebraica inválida: Las variables deben tener un valor máximo de 9999",10,0
	lenErrorMaxChar:		equ $ - ErrorMaxChar

	ErrorVar:				db "                                Variable inválida",10,0
	lenErrorVar:			equ $ - ErrorVar

	ErrorConst:				db "		              ERROR: Faltan variables por definir",10,0
	lenErrorConst			equ $ - ErrorConst

	ErrorDivisionCero:		db "                  ERROR: División con cero",10,0
	lenErrorDivCero:		equ $ - ErrorDivisionCero

	ErrorPuntoFlotante: 	db "		           ERROR: Punto Flotante",10,0
	lenErrorPuntoFlotante	equ $ - ErrorPuntoFlotante

	Numero: db "---------", 0x0A
	NumLen: equ $-Numero

	msje:	db "ESTA DIVIDIENDOOOOOO!!! WOOO"
	lenmsje: equ $-msje

section .text

	; *** SECTION .TEXT ***
	;
	; Aquí es donde se ubica todo el código del programa.

global _start

_start:	
	; _start: Etiqueta de inicio

main:
	; main: Desde donde se llamará a todos los procedimientos principales

	call comenzar	; Esto imprimirá las instrucciones al usuario

	xor r13, r13

	mov byte[bufferExpActual + 0], '2'
	mov byte[bufferExpActual + 1], '*'
	mov byte[bufferExpActual + 2], '2'
	mov r13, 2
	call evaluarExpresionSimple
	jmp exit

ExpAlg:
	; ExpAlg: Sección del código que se encarga de leer la expresión matemática y de validar la misma

	call leerExpresion	; 

	; Desde aquí, R15 va a guardar el largo de la expresión matemática

	;==================================== RESTRICCIONES ====================================================

	call verificarCaracteres			; Verifica que la expresión sólo tenga caracteres válidos
	call verificarParentesis  			; Verifica que los paréntesis estén balanceados
	call verificarSimbolos				; Verifica que no hayan signos al principio al final, ni dos juntos
	call quitarEspacios					; Elimina los espacios de la EA
	call agregarMul				        ; Agrega los *'s en donde hay multiplicaciones implícitas

	; Desde aquí r15 deja de contar al enter en la expresión matemática
	
	jmp  verificarComa					; Verifica si la expresión termina en coma y que ésta esté al final

Vars:

	call leerVariables 			; Aquí se leen la variables, se guarda en r14 el número de éstas
	call reemplazarVariables	; Reemplaza variables por sus valores y verifica que las usadas estén especificadas

	; Después de esto r14 ya está libre para otros usos

Operar:

	call quitarComa
	call evaluarExpresionTotal
	;call encontrarParentesisInterior	; guarda en un buffer el paréntesis más interior
	;call evaluarExpresionSimple
	jmp  exit

imprimir:				
	; FUNCIÓN imprimir
	; Entradas: rsi, dirección del mensaje a imprimir
	;			rdx, largo del mensaje a imprimir
	; Salidas: 	Imprime el mensaje dado en pantalla

	mov rax,1			; file descriptor (sys_write)
	mov rdi,1			; system call number (std out)
	syscall
	ret

leerExpresion:

	; PROCEDIMIENTO
	; Hace un syscall para leer la expresión matemática del usuario

	mov rax, 0						; sys_read (code 0)
	mov rdi, 0						; file descriptor (code 0 stdin)
	mov rsi, bufferExpresion		; address to the buffer to read into
	mov rdx, buffExpresionLen		; number of bytes to read
	syscall
	mov r15, rax					; mueve el largo de la expresión a r15
	ret

verificarCaracteres:

	; PROCEDIMIENTO
	; Verificar que la expresión sólo tenga caracteres válidos
	
	xor r9, r9			; limpiar registros a usar
	xor rsi, rsi
	xor r10, r10
	mov r9, rax			; le mueve el largo de la expresión a r9 para usarlo como límite
	dec r9				; decrementa r9 para ignorar al enter que viene al final

	.comparar:

		; Compara cada caracter con todos los posibles para validar que no tenga otros inválidos

		cmp byte[bufferExpresion + rsi], '*'
		je .siguiente
		cmp byte[bufferExpresion + rsi], '+'
		je .siguiente
		cmp byte[bufferExpresion + rsi], '-'
		je .siguiente
		cmp byte[bufferExpresion + rsi], '/'
		je .siguiente
		cmp byte[bufferExpresion + rsi], '('
		je .siguiente
		cmp byte[bufferExpresion + rsi], ')'
		je .siguiente
		cmp byte[bufferExpresion + rsi], ' '
		je .siguiente
		cmp byte[bufferExpresion + rsi], ','
		je .siguiente
		cmp byte[bufferExpresion + rsi], 0Ah ; Enter
		je .siguiente
		cmp byte[bufferExpresion + rsi], 30h ; Verifica que sea un número, entre 0(30h) y 9(39h)
		jb .error
		cmp byte[bufferExpresion + rsi], 39h
		ja .buscarLetras
		jmp .siguiente

	.buscarLetras:

		;Si no fuera ninguna de las anteriores, tendrá que ser una letra(variable)

		cmp byte[bufferExpresion + rsi], 61h ; Verifica que sea una letra, entre a(61h) y z(7Ah)
		jb .error
		cmp byte[bufferExpresion + rsi], 7Ah
		jbe .siguiente

	.error:

	; Si no fuera ninguno de los caracteres válidos, muestra un error en pantalla

		mov rsi, ErrorGen     ;Error general
		mov rdx, lenErrorGen
		call imprimir
		jmp exit

	.siguiente:

	; Con esta sección cambia de caracter al siguiente después de haber validado el anterior, hasta el final

		inc rsi
		cmp rsi, r9
		jne .comparar
		ret

verificarComa:

	; PROCEDIMIENTO
	; Verifica si la expresión matemática tiene coma, y si éste es el caso, verifica que esté al final
	; Si esto se cumple, salta a leer variables, pero si no hay coma, significa que el usuario no tiene
	; variables, lo cual lleva a un error si éstas se presentan en la expresión.

	xor r9, r9				 ; limpia r9
	mov r9, r15			     ; r15 tiene el tamaño de BufferExpresion
	dec r9					 ; decrementa r9 para ignorar al enter
	xor rcx, rcx 			 ; limpia rcx
	mov rsi, bufferExpresion ; Le pasa la dirección de bufferExpresion a rsi

	.buscarComa:
		; Busca la coma en todos los caracteres

		cmp byte[rsi + rcx], ','		; Compara el caracter actual con una coma
		je .CompararFinal
		cmp rcx, r9
		je .verificarConstantes 		; Ĺlegó al final y no había comas
		inc rcx
		jmp .buscarComa					; Ciclo

	.CompararFinal:
		; Si encontró la coma, verifica que esté al final

		dec r9							
		cmp r9, rcx
		jne .Error 	; Error si no está al final
		cmp r9, 0
		je .Error
		jmp Vars	; Sí hay una coma y está al final

	.Error:

		mov rsi, ErrorGen 		; Error general
		mov rdx, lenErrorGen
		call imprimir
		jmp exit

	.verificarConstantes:


		xor rcx, rcx
		xor rax, rax		
		mov rax, r15		; Le pasa el tamaño de el buffer a rax

	.ciclo:

		cmp byte[rsi + rcx], 61h  ; ¿Es menor a 'a'?
		jb .fin					  ; Sí es menor a 'a', no es una letra
		cmp byte[rsi + rcx], 7Ah  ; ¿Es menor a 'z'?
		jbe .error       		  ; Es una letra

	.fin:
		inc rcx
		cmp rcx, rax
		je  .salir
		jmp .ciclo

	.error:

		mov rsi, ErrorConst
		mov rdx, lenErrorConst
		call imprimir
		jmp exit

	.salir:
		jmp Operar

verificarParentesis:

	; PROCEDIMIENTO
	; Verifica que los paréntesis en la expresión estén balanceados y sean correctos

	mov  rax, r15
	dec  rax
	mov  r9,  0 ; Contador de validación de paréntesis
	mov  rcx, 0
	mov  rsi, 0

	.inicio:

		cmp r9, 0	; Si los paréntesis son correctos, el contador no debería de ser nunca negativo
		jl  .parentesisDesbalanceados
		cmp byte[bufferExpresion + rsi], 28h ; Si el caracter es un paréntesis abierto '('
		je  .incrementarContador			 ; que incremente el contador
		cmp byte[bufferExpresion + rsi], 29h ; O, si el caracter es un paréntesis cerrado ')'
		je  .decrementarContador			 ; que decremente el contador
		jmp .next

	.incrementarContador:

		inc r9
		jmp .next

	.decrementarContador:

		dec r9
		jmp .next

	.parentesisDesbalanceados:
		
		mov  rsi, ErrorParentesis
		mov  rdx, lenErrorParentesis
		call imprimir
		jmp  exit

	.next:

		inc rsi 		; Para ir al siguiente caracter
		inc rcx         ; Para contar el número de caracteres que ha leído
		cmp rcx, rax 	; Compara el max de caracteres de la expresión dada, con el número de caracteres que ha leído
		jne .inicio 	; Si no ha terminado, que siga comparando caracteres
		cmp r9, 0		; Si los paréntesis son correctos, deberían de quedar en cero al final
		jne .parentesisDesbalanceados
		ret

verificarSimbolos:

	; PROCEDIMIENTO
	; Verifica que no haya dos símbolos(+, -, *, /) juntos, ni que +, * y / puedan estar al inicio


	xor rsi, rsi 		; contador de índices
	xor rcx, rcx		; contador de veces repetidas
	xor rbx, rbx		; contador de pares de caracteres juntos

	.verSignoInicio:
		; Verifica que el primer caracter no sea un símbolo, a excepción de '-' 
		cmp byte[bufferExpresion + rsi], '+'
		je .error
		cmp byte[bufferExpresion + rsi], '*'
		je .error
		cmp byte[bufferExpresion + rsi], '/'
		je .error

	.verSignoFinal:
		; Verifica que el último caracter no sea un símbolo, a excepción de '-' 
		mov rsi, r15
		sub rsi, 1
		cmp byte[bufferExpresion + rsi], '+'
		je .error
		cmp byte[bufferExpresion + rsi], '-'
		je .error
		cmp byte[bufferExpresion + rsi], '*'
		je .error
		cmp byte[bufferExpresion + rsi], '/'
		je .error

		xor rsi, rsi

	.buscarDobles:
		; Buscar pares de caracteres juntos
		inc rbx
		cmp rbx, 3
		je .resetBnC
		inc rsi
		cmp rsi, r15
		je .terminar

		cmp byte[bufferExpresion + rsi], '+'
		je .sumarUno
		cmp byte[bufferExpresion + rsi], '-'
		je .sumarUno
		cmp byte[bufferExpresion + rsi], '*'
		je .sumarUno
		cmp byte[bufferExpresion + rsi], '/'
		je .sumarUno

		jmp .buscarDobles

	.resetBnC:
		xor rbx, rbx
		xor rcx, rcx
		jmp .buscarDobles

	.sumarUno:
		inc rcx
		cmp rcx, 2
		je .error
		jmp .buscarDobles

	.error:
		mov rsi, ErrorGen
		mov rdx, lenErrorGen
		call imprimir
		jmp exit

	.terminar:

		ret

leerVariables: 
	; PROCEDIMIENTO
	; Lee las variables, le pide al usuario que digite una mientras siga poniendo comas al final

	xor r14, r14						; va a guardar el número de variables
	xor r12, r12						; bandera para indicar si una variable no tiene coma al final
	mov r12, 2							; empieza siempre con dos

	.Var1:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar1
		mov rdx, buffVar1Len
		syscall							; Pide leer de consola
		mov rcx, 0
		mov rsi, buffVar1				
		call .buscarComa				; Busca la coma en la variable, para saber si seguir o no pidiendo más
		cmp rcx, -1						; Bandera: -1 indica que ha terminado de leer
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra=Num"
		inc r14

	.Var2:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar2
		mov rdx, buffVar2Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar 
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var3:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar3
		mov rdx, buffVar3Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var4:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar4
		mov rdx, buffVar4Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var5:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar5
		mov rdx, buffVar5Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var6:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar6
		mov rdx, buffVar6Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var7:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar7
		mov rdx, buffVar7Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var8:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar8
		mov rdx, buffVar8Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var9:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar9
		mov rdx, buffVar9Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var10:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar10
		mov rdx, buffVar10Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var11:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar11
		mov rdx, buffVar11Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var12:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar12
		mov rdx, buffVar12Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar 
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var13:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar13
		mov rdx, buffVar13Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var14:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar14
		mov rdx, buffVar14Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var15:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar15
		mov rdx, buffVar15Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var16:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar16
		mov rdx, buffVar16Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var17:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar17
		mov rdx, buffVar17Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var18:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar18
		mov rdx, buffVar18Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var19:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar19
		mov rdx, buffVar19Len
		syscall
		mov rcx, 0
		call .buscarComa
		cmp rcx, -1
		je .terminar
		call verificarFormatoVariables 		; Verifica que las variables sean de formato: "Letra = Num"
		inc r14

	.Var20:
		mov rax, 0						; sys_read (code 0)
		mov rdi, 0						; file descriptor (code 0 stdin)
		mov rsi, buffVar20
		mov rdx, buffVar20Len
		syscall
		mov rcx, 0
		inc r14
		jmp .terminar

	.buscarComa:
		cmp byte[rsi+rcx], 0  ; Si llega al final del buffer y no encontró una coma
			je .salir
		cmp byte[rsi+rcx],',' ; Si es una coma, se cambia de linea y termina el ciclo
			je .seguir
		inc rcx
		jmp .buscarComa; Continúa buscando

	.seguir:
		ret

	.salir:
		mov rcx, -1			; Bandera: No encontró coma al final
		ret

	.terminar:
		mov r12, 1
		call verificarFormatoVariables 		; En este caso, r12 indica que ya no tiene coma
		ret

verificarFormatoVariables: 

	; FUNCIÓN
	; Entradas: rsi, dirección del buffer a leer
	; 			rax, largo del buffer
	; 			r12, es 1 si es la última variable a verificar

	sub rax, r12			; Para que sólo tome en cuenta el tamaño hasta antes de la coma
	xor r10, r10			; Contador para índices
	xor r11, r11
	mov r11, 7				; El límite de dígitos que una variable podrá tener: "a = 9999"
	
	.compararLetra:
		; Verifica que el primer caracter sea siempre una letra
		cmp byte[rsi + r10], 61h
		jb .error
		cmp byte[rsi + r10], 7Ah
		ja .error ; da error si no es así
		inc r10
		jmp .buscarSimboloIgual

	.buscarSimboloIgual:
		; Verifica que el segundo caracter sea siempre un símbolo '='
		cmp r10, rax
		je .error

	.buscar:
		cmp byte[rsi + r10], '='
		jne .error
		inc r10
		jmp .buscarNumero

	.buscarNumero:
		; Verifica que desde el tercer caracter sólo hayan números
		cmp r10, rax
		je .error

	.posibleNegativo:
		; Admite un y sólo un símbolo de '-' para aceptar números negativos
		cmp byte[rsi + r10], '-'
		jne .buscarNum
		inc r10
		cmp r10, rax
		je .error

	.buscarNum:

		cmp byte[rsi + r10], 30h
		jb .error
		cmp byte[rsi + r10], 39h
		ja .error

	.nextCont:

		dec r11
		cmp r11, 0
		je .errorMaxChar  ; llegó al máximo de caracteres

	.next:

		inc r10
		cmp r10, rax
		je .compararMax
		jmp .buscarNum

	.compararMax:

		cmp r11, 7
		jb .terminar
		jmp .error

	.error:

		mov rsi, ErrorVar
		mov rdx, lenErrorVar
		call imprimir
		jmp exit

	.errorVacio:

		mov rsi, ErrorVacio
		call imprimir
		jmp exit

	
	.errorMaxChar:

		mov rsi, ErrorMaxChar
		mov rdx, lenErrorMaxChar
		call imprimir
		jmp exit

	.terminar:
		ret

borrarEspacios:
	
	; FUNCIÓN
	; Le borra los espacios al buffer indicado en rsi

	; Entradas: rdx, largo de la expresión, 
	;			r9,  largo sin coma ni enter 
	;			rsi, dirección del buffer

	xor r13, r13
	xor r10, r10  ; contador de espacios 
	xor rcx, rcx  ; contador de índices
	xor r11, r11  ; contador de veces a correr un caracter
	xor r8, r8	  

	mov r13, r9	  
	sub r13, 2
	mov r8, r13	  ; para tener en r8 el largo sin coma ni enter
	inc r8

	.buscarEspacios:
		; busca espacios para empezar a correr caracteres

		cmp byte[rsi + rcx], ' '
		je .contadorEspacios
		inc rcx
		cmp rcx, r13
		jne .buscarEspacios
		jmp .salir

	.contadorEspacios:

		mov r10, rcx

	.ciclo:
		inc r10
		cmp r10, r8		
		je .salir
		inc r11					; contador de las veces que hay que correr a la izquierda un caracter
		cmp byte[rsi + r10], ' '
		je .ciclo

	.mover:
		mov bl, byte[rsi + r10]
		mov byte[rsi + r10 -1], bl
		mov byte[rsi + r10], ' '
		dec r10
		dec r11
		cmp r11, 0
		je .buscarEspacios
		jmp .mover

	.salir:
		ret

copiarBuffer:
	; FUNCIÓN
	; Copia lo que está en bufferExpTemp a bufferExpresion

	xor r9, r9
	xor rax, rax
	xor r10, r10
	mov r10, r15
	dec r10

	.ciclo:

		mov al, [bufferExpTemp + r9]
		mov [bufferExpresion + r9], al
		inc r9
		cmp r9, r10	; condición de parada
		jne .ciclo
		call limpiarBufferTemp
		ret

limpiarBufferTemp:
	; FUNCIÓN
	; Limpia el bufferExpTemp
	
	push r9
	xor r9, r9

	.ciclo:

		mov byte[bufferExpTemp + r9], 0
		inc r9
		cmp byte[bufferExpTemp + r9], 0
		jne .ciclo
		pop r9
		ret

reemplazarVariables:
	; PROCEDIMIENTO
	; Reemplaza cada variable que se encuentre en la expresión por su valor correspondiente
	; y si no encuentra la variable, da error
	
	xor r8, r8	  ; contador de índices
	xor r9, r9    ; va a guardar el largo del valor de cada variable
	xor r10, r10
	xor r12, r12
	xor rsi, rsi
	xor rax, rax
	xor rbx, rbx

	mov r12, r15
	dec r12

	.buscarVariable:
		; Busca una variable en la expresión

		cmp byte[bufferExpresion + r8], 61h
		jb .siguiente
		cmp byte[bufferExpresion + r8], 7Ah
		ja .siguiente
		mov bl, byte[bufferExpresion + r8] ; bl va a guardar la letra de la variable
		jmp .reemplazar

	.siguiente:
		; Avanza caracter por caracter buscando variables
		mov al, byte[bufferExpresion + r8]
		mov byte[bufferExpTemp + r10], al 		; va copiando a bufferExpTemp todo lo que no sean variables
		inc r8
		inc r10
		cmp r8, r12			; condición de parada, si llegó al final y terminó de reemplazar
		je .salir
		jmp .buscarVariable

	.reemplazar:
		; Si se encuentra una, la busca en los buffers de variables
		inc r8		; para que el valor de la variable empiece a caer sobre el sgte espacio
		cmp byte[buffVar1], bl
		je .var1
		cmp byte[buffVar2], bl
		je .var2
		cmp byte[buffVar3], bl
		je .var3
		cmp byte[buffVar4], bl
		je .var4
		cmp byte[buffVar5], bl
		je .var5
		cmp byte[buffVar6], bl
		je .var6
		cmp byte[buffVar7], bl
		je .var7
		cmp byte[buffVar8], bl
		je .var8
		cmp byte[buffVar9], bl
		je .var9
		cmp byte[buffVar10], bl
		je .var10
		cmp byte[buffVar11], bl
		je .var11
		cmp byte[buffVar12], bl
		je .var12
		cmp byte[buffVar13], bl
		je .var13
		cmp byte[buffVar14], bl
		je .var14
		cmp byte[buffVar15], bl
		je .var15
		cmp byte[buffVar16], bl
		je .var16
		cmp byte[buffVar17], bl
		je .var17
		cmp byte[buffVar18], bl
		je .var18
		cmp byte[buffVar19], bl
		je .var19
		cmp byte[buffVar20], bl
		je .var20
		jmp .error

	.var1:

		mov rsi, buffVar1 ; Mueve la variable encontrada a rsi para su siguiente análisis
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var2:

		mov rsi, buffVar2
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var3:

		mov rsi, buffVar3
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var4:

		mov rsi, buffVar4
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var5:

		mov rsi, buffVar5
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var6:

		mov rsi, buffVar6
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var7:

		mov rsi, buffVar7
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var8:

		mov rsi, buffVar8
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var9:

		mov rsi, buffVar9
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var10:

		mov rsi, buffVar10
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var11:

		mov rsi, buffVar11
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var12:

		mov rsi, buffVar12
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var13:

		mov rsi, buffVar13
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var14:

		mov rsi, buffVar14
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var15:

		mov rsi, buffVar15
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var16:

		mov rsi, buffVar16
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var17:

		mov rsi, buffVar17
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var18:

		mov rsi, buffVar18
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var19:

		mov rsi, buffVar19
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.var20:

		mov rsi, buffVar20
		xor r9, r9
		inc r9
		dec r15
		jmp .tomarValor

	.tomarValor:
		; Copia el valor de la variable, número por número 
		;y dejando entrar un menos para aceptar negativos
		inc r9
		cmp byte[rsi + r9], '-'
		je .copiar
		cmp byte[rsi + r9], 30h
		jb .buscarVariable
		cmp byte[rsi + r9], 39h
		ja .buscarVariable

	.copiar:
		; Copia caracter por caracter
		mov al, [rsi + r9]
		mov [bufferExpTemp + r10], al
		inc r10
		inc r15
		jmp .tomarValor

	.error:
		; Error de constantes no definidas en la expresión
		mov rsi, ErrorConst
		mov rdx, lenErrorConst
		call imprimir
		jmp exit

	.salir:
		call copiarBuffer
		ret

agregarMul:
	
	; PROCEDIMIENTO
	; Agrega asteriscos(*) en los lugares en donde hay multiplicaciones implícitas

	xor r9, r9
	xor r10, r10
	xor r12, r12
	xor rax, rax

	mov r12, r15			; Movemos el tamaño de la expresión algebraica a r12
	dec r12					; Para ignorar el enter

	.buscarCaso:
		; Distingue entre los posibles casos en dónde pueda haber una

		cmp byte[bufferExpresion + r9], ')'
		je .compararCasoParentesis
		cmp byte[bufferExpresion + r9], 30h
		jb .siguiente							; No es número ni letra
		cmp byte[bufferExpresion + r9], 39h
		jb .compararCasoNumero					; Es una número
		cmp byte[bufferExpresion + r9], 61h
		jb .siguiente							; No es letra
		cmp byte[bufferExpresion + r9], 7Ah
		jb .compararCasoLetra
		jmp .siguiente

	.siguiente:
		; Se copian los caracteres anteriores en donde no existen multiplicaciones implícitas
		mov al, byte[bufferExpresion + r9]
		mov byte[bufferExpTemp + r10], al		; Copia al buffer temporal

	.copiar:
		inc r9
		inc r10 
		cmp r9, r12 
		je .salir
		jmp .buscarCaso

	.compararCasoParentesis:

		cmp byte[bufferExpresion + r9 + 1], ','
		je .terminar
		cmp byte[bufferExpresion + r9 + 1], '('
		je .ponerAsterisco
		cmp byte[bufferExpresion + r9 + 1], 30h
		jb .siguiente
		cmp byte[bufferExpresion + r9 + 1], 39h
		jb .ponerAsterisco
		cmp byte[bufferExpresion + r9 + 1], 61h
		jb .siguiente
		cmp byte[bufferExpresion + r9 + 1], 7Ah
		jb .ponerAsterisco
		jmp .siguiente

	.ponerAsterisco:
		; Pone el asterisco en el bufferExpTemp que es en donde va copiando la expresión
		mov al, byte[bufferExpresion + r9]
		mov byte[bufferExpTemp + r10], al
		inc r10			; para que llegue al espacio siguiente en donde pondrá el *
		mov byte[bufferExpTemp + r10], '*'
		inc r15
		jmp .copiar


	.compararCasoNumero:
		
		cmp byte[bufferExpresion + r9 + 1], ','
		je .terminar
		cmp byte[bufferExpresion + r9 + 1], '('
		je .ponerAsterisco
		cmp byte[bufferExpresion + r9 + 1], 61h
		jb .siguiente
		cmp byte[bufferExpresion + r9 + 1], 7Ah
		jb .ponerAsterisco
		jmp .siguiente

	.compararCasoLetra:

		cmp byte[bufferExpresion + r9 + 1], ','
		je .terminar
		cmp byte[bufferExpresion + r9 + 1], '('
		je .ponerAsterisco
		cmp byte[bufferExpresion + r9 + 1], 30h
		jb .siguiente
		cmp byte[bufferExpresion + r9 + 1], 39h
		jb .ponerAsterisco
		cmp byte[bufferExpresion + r9 + 1], 61h
		jb .siguiente
		cmp byte[bufferExpresion + r9 + 1], 7Ah
		jb .ponerAsterisco
		jmp .siguiente

	.terminar:
		mov al, byte[bufferExpresion + r9]
		mov byte[bufferExpTemp + r10], al
		inc r9
		inc r10
		mov al, byte[bufferExpresion + r9]
		mov byte[bufferExpTemp + r10], al

	.salir:
		call copiarBuffer
		call limpiarBufferTemp
		ret

quitarEspacios:

	xor r8, r8			; contador de caracteres para bufferExpresion
	xor r9, r9			; contador de caracteres para bufferExpTemp
	xor r10, r10
	mov r10, r15		; guarda el largo original para comparar y detenerse después
						; r15 (tamaño de EA) puede disminuir

	.recorrerExpresion:
		cmp byte[bufferExpresion + r8], ' '
		je .ignorarEspacio						; Si se encuentra un espacio, no lo copia
		mov al, byte[bufferExpresion + r8]
		mov byte[bufferExpTemp + r9], al 		; Copia en el buffer temporal
		inc r9									; Incrementa índice
		inc r8									; Incrementa índice
		cmp r8, r10								; Condición de parada: Terminó con caracteres
		jne .recorrerExpresion
		jmp .salir

	.ignorarEspacio:
		dec r15					 ; Por cada espacio que no copia, disminuye el largo de EA
		inc r8					 ; Sólo aumenta el contador de bufferExpresion
		cmp r8, r10				 ; Condición de parada de nuevo
		je .salir
		jmp .recorrerExpresion

	.salir:
		call copiarBuffer		 ; Copia al bufferExpresion lo que tiene en el temporal
		ret 					 ; La EA termina sin espacios intermedios

encontrarParentesisInterior:
	; PROCEDIMIENTO
	; Busca el paréntesis más interno en la expresión y guarda su contenido en bufferExpActual
	; para operarlo después
	;push r8
	;push r9
	;push r10

	xor r8, r8
	xor r9, r9
	xor r10, r10
	xor r13, r13
	call limpiarBufferTemp

	mov r9, -1

	.cicloDeComparacion:
		cmp byte[bufferExpresion + r8], '('
		je .guardarPosicion

	.condicionParada:
		inc r8
		cmp r8, r15
		je .verificarSiHayParentesis
		jmp .cicloDeComparacion

	.guardarPosicion:
		mov r9, r8		; guardamos la posición del '('
		inc r8
		jmp .cicloDeComparacion

	.verificarSiHayParentesis:
		cmp r9, -1
		jne .copiarExpresion
		jmp .copiarBufferExpresionAExpActual ; No habían paréntesis

	.copiarExpresion:
		inc r9		; para omitir el '('
		cmp byte[bufferExpresion + r9], ')'
		je .guardarLargo
		mov al, byte[bufferExpresion + r9]
		mov byte[bufferExpActual + r10], al
		inc r10
		jmp .copiarExpresion

	.copiarBufferExpresionAExpActual:
		mov r13, r15		; se guarda el largo en r13 para pasarlo después 
		xor r8, r8

	.cicloDeCopiado:
		mov al, byte[bufferExpresion + r8]
		mov byte[bufferExpActual + r8], al
		inc r8
		cmp byte[bufferExpresion + r8], 0
		jne .cicloDeCopiado
		jmp .terminar

	.guardarLargo:
		mov r13, r10		; se guarda el largo en r13 para pasarlo después

	.terminar:
		push rdi
		push rdx
		push rsi
		push rax

		mov rsi, bufferExpActual
		mov rdx, bufferExpActualLen
		call imprimir

		pop rax
		pop rsi
		pop rdx
		pop rdi
		;pop r10
		;pop r9
		;pop r8	
		ret

evaluarExpresionSimple:	
	; FUNCIÓN				
	; Evalúa expresiones sin paréntesis
							
	; Entradas: bufferExpActual, operación
							
	; Toma r13 como el largo

	.inicio:
		
	xor r8, r8
	xor r9, r9
	xor r10, r10
	xor r11, r11
	xor r12, r12

	;dec r13

	.buscarUnicoNumeroNegativo:
		cmp byte[bufferExpActual + r8], '-'
		jne .buscarMultiplicacionODivision
		inc r8

	.cicloDeBusqueda:

		cmp byte[bufferExpActual + r8], 10h
		je .continuaCiclo
		cmp byte[bufferExpActual + r8], 30h
		jb .seguirBuscando
		cmp byte[bufferExpActual + r8], 39h
		ja .seguirBuscando

	.continuaCiclo:
		inc r8
		cmp r8, r13
		jne .cicloDeBusqueda
		jmp exit;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	.seguirBuscando:
		xor r8, r8
		inc r8

	.buscarMultiplicacionODivision:
		; Busca por precedencia, primero multiplicaciones o divisiones

		cmp byte[bufferExpActual + r8], '*'
		je .obtenerOperacionSimple
		cmp byte[bufferExpActual + r8], '/'
		je .obtenerOperacionSimple
		inc r8
		cmp r8, r13
		jne .buscarMultiplicacionODivision 
		xor r8, r8
	
	.buscarSumaOResta:
		; Si no encuentra multiplicaciones o divisiones, busca sumas y restas
		cmp byte[bufferExpActual + r8], '+'
		je .obtenerOperacionSimple
		cmp byte[bufferExpActual + r8], '-'
		je .verificarResta
		inc r8
		cmp r8, r13
		jne .buscarSumaOResta
		ret

	.verificarResta:
		cmp r8, 0
		jne .obtenerOperacionSimple
		inc r8
		cmp r8, r13
		jne .buscarSumaOResta
		ret

	.obtenerOperacionSimple:
		; Busca la operación más simple de forma: *Num Op Num* y la guarda en bufferOperacion
		mov r9, r8
		mov r12, r8

	.irAtras:
		; Retrocede hasta el inicio del primer operando y marca el índice
		cmp r9, 0
		je .marcarPosicionYSeguir
		
		cmp byte[bufferExpActual + r9 - 1], '-'
		je .verificarNegativo
		cmp byte[bufferExpActual + r9 - 1], 30h
		jb .marcarPosicionYSeguir
		cmp byte[bufferExpActual + r9 - 1], 39h
		ja .marcarPosicionYSeguir
		dec r9
		jmp .irAtras

	.verificarNegativo:
		dec r9
		cmp r9, 0
		je .marcarPosicionYSeguir

		cmp byte[bufferExpActual + r9 - 1], 30h
		jb .contarNegativo
		cmp byte[bufferExpActual + r9 - 1], 39h
		ja .contarNegativo
		jmp .marcarPosicionYSeguir

	.contarNegativo:
		;dec r9
		jmp .marcarPosicionYSeguir

	.marcarPosicionYSeguir:
		mov r11, r9		; Guarda la posición del comienzo de la operación simple

	.irAdelante:
		; Avanza hasta el final del segundo operando y marca el índice
		cmp r8,r12
		je .verificarMenosOp2
		cmp byte[bufferExpActual + r8 + 1], 30h
		jb .copiarABufferSobra
		cmp byte[bufferExpActual + r8 + 1], 39h
		ja .copiarABufferSobra
		inc r8
		jmp .irAdelante

	.verificarMenosOp2:
		cmp byte[bufferExpActual + r8 + 1], '-'
		je  .contarMenos
		inc r8
		jmp .irAdelante

	.contarMenos:
		inc r8
		jmp .irAdelante

	.copiarABufferSobra:
		push r8
		push r9	

		xor r9, r9 	; para usar como contador
		inc r8

	.cicloDeCopiadoABufferSobra:
		mov al, byte[bufferExpActual + r8]
		mov byte[bufferSobra + r9], al
		mov byte[bufferExpActual + r8], 0
		inc r9
		inc r8
		cmp byte[bufferExpActual + r8], 0
		jne .cicloDeCopiadoABufferSobra

		pop r9
		pop r8

	.copiarABufferOperacion:
		; Con ambos indices, copia a bufferOperacion la operación simple
		mov al, byte[bufferExpActual + r9]
		mov byte[bufferOperacion + r10], al
		mov byte[bufferExpActual + r9], 0
		inc r10
		inc r9
		cmp r9, r8
		ja .prepararOperacion
		jmp .copiarABufferOperacion


	.prepararOperacion:		
		xor r8, r8

	.copiarPrimerOperando:
		; Separa el primer operando en otro buffer
		cmp byte[bufferOperacion + r8], '-'
		je .agregarMenos
		;cmp r8, 0
		jmp .seguirComparando

	.agregarMenos:
		mov al, byte[bufferOperacion + r8]
		mov byte[bufferOperando1 + r8], al
		inc r8

	.seguirComparando:

		cmp byte[bufferOperacion + r8], 30h
		jb .copiarSegundoOperando
		cmp byte[bufferOperacion + r8], 39h
		ja .copiarSegundoOperando
		mov al, byte[bufferOperacion + r8]
		mov byte[bufferOperando1 + r8], al
		inc r8
		jmp .seguirComparando

	.copiarSegundoOperando:
		; Separa el segundo operando en otro buffer
		xor r12, r12
		xor r10, r10
		mov r10, r8			; Posición del símbolo de operación
		inc r8
		;inc r9?????

	.copiarSegundo:

		mov al, byte[bufferOperacion + r8]
		mov byte[bufferOperando2 + r12], al
		inc r12
		inc r8
		
		cmp r8, r9
		jne .copiarSegundo

	.aplicarAtoi:
		; Convierte a números los dos operandos y los pone en rax y rbx, listos para ser operados
		mov rsi, bufferOperando1

		call getLargoBuffer			 ; r14 consigue el largo del buffer
		call copiarBufferABufferAtoi ; copia el operando a bufferAtoiTemp

		call atoi 					 ; la respuesta en número ahora está en rax
		mov rbx, rax				 ; el primer operando queda en rbx
		xor rax, rax

		mov rsi, bufferOperando2

		call getLargoBuffer
		call copiarBufferABufferAtoi

		call atoi
		xchg rax, rbx				; Para que el primer y segundo operando
									; queden en rax y rbx respectivamente

	.identificarOperacion:
		; Identifica la operación a realizar
		cmp byte[bufferOperacion + r10], '*'
		je .multiplicar
		cmp byte[bufferOperacion + r10], '/'
		je .dividir
		cmp byte[bufferOperacion + r10], '+'
		je .sumar
		cmp byte[bufferOperacion + r10], '-'
		je .restar
		jmp .error

	.multiplicar:
		call multiplicar
		jmp .transformarEnAscii
	.dividir:
		call dividir
		jmp .transformarEnAscii
	.sumar:
		call sumar
		jmp .transformarEnAscii
	.restar:
		call restar
		jmp .transformarEnAscii

	.error:
		jmp esigual

	.transformarEnAscii:
		call itoa   ; después de esto, bufferItoa ya guarda el valor en ASCII del resultado
		push rdx
		push rdi
		push rsi
		push rax

		;mov rsi, bufferItoa
		;mov rdx, bufferItoaLen
		;call imprimir
		pop rax
		pop rsi
		pop rdi
		pop rdx

	.juntarBuffers:
		push r8
		push r9
		xor r8, r8
		xor r9, r9

		mov rsi, bufferExpActual
		call getLargoBuffer		; el largo queda en r14, tomamos a éste como índice para empezar a copiar
		mov r8, r14  	 		; en r8 queda guardado el largo de bufferExpActual
		mov rsi, bufferItoa
		call getLargoBuffer		; el largo de bufferItoa queda en r14


	.cicloDeCopiadoItoaAExpActual:
		mov al, byte[bufferItoa + r9]
		mov byte[bufferExpActual + r8], al
		inc r8
		inc r9
		cmp r9, r14				; Si son iguales, terminó
		jne .cicloDeCopiadoItoaAExpActual
		

		xor r9, r9 		; para volver a usarlo como contador
		mov rsi, bufferSobra
		call getLargoBuffer	; r14 tendrá el largo de bufferSobra


	.cicloDeCopiadoSobraAExpActual:
		mov al, byte[bufferSobra + r9]
		mov byte[bufferExpActual + r8], al
		inc r8
		inc r9
		cmp r9, r14
		jne .cicloDeCopiadoSobraAExpActual

		pop r9
		pop r8

	.terminar:

		push rdx
		push rdi
		push rsi
		push rax

		mov rsi, bufferExpActual
		mov rdx,  bufferExpActualLen
		call imprimir

		pop rax
		pop rsi
		pop rdi
		pop rdx

		mov rsi, bufferItoa
		call limpiarBuffer
		mov rsi, bufferSobra
		call limpiarBuffer
		mov rsi, bufferAtoiTemp
		call limpiarBufferAtoi
		mov rsi, bufferOperacion
		call limpiarBuffer
		mov rsi, bufferOperando1
		call limpiarBuffer
		mov rsi, bufferOperando2
		call limpiarBuffer

		xor r8, r8
		xor r9, r9
		xor r10, r10
		xor r11, r11
		xor r12, r12
		xor r13, r13

		mov rsi, bufferExpActual
		call getLargoBuffer	; el largo queda en r14

		mov r13, r14
		dec r13

		jmp .buscarUnicoNumeroNegativo

		ret

evaluarExpresionTotal:

	xor r8, r8
	xor r9, r9
	xor r10, r10		; contador de paréntesis izquierdos
	xor r12, r12
	call limpiarBufferTemp
	call limpiarBufferSobra
	mov r9, -1			; Bandera: -1 indica que no hay paréntesis
	
	.cicloDeComparacion:
		cmp byte[bufferExpresion + r8], '('
		je .guardarPosicion

	.condicionParada:
		inc r8
		cmp r8, r15
		je .verificarSiHayParentesis
		jmp .cicloDeComparacion

	.guardarPosicion:
		mov r9, r8		; guardamos la posición del '('
		;inc r10			; incrementa contador de paréntesis izquierdos
		inc r8
		jmp .cicloDeComparacion

	.verificarSiHayParentesis:
		cmp r9, -1
		jne .guardarIndice
		jmp .evaluarExpresionFinal

	.guardarIndice:
		push r9	; guardamos la posición del paréntesis

	.evaluarParentesis:
		call encontrarParentesisInterior ; esto dejará la expresión en bufferExpActua
		push rsi
		mov rsi, bufferExpActual
		call getLargoBuffer
		mov r13, r14
		pop rsi
		call evaluarExpresionSimple ; esto la tómará, la operará y la dejará en bufferExpActual
		;push r10; guardamos el número de paréntesis izquierdos
		;xor r10, r10
		;call limpiarBufferSobra
		pop r9


		push rdx
		push rdi
		push rsi
		push rax

		mov rsi, msje
		mov rdx, lenmsje
		;call imprimir

		pop rax
		pop rsi
		pop rdi
		pop rdx

		jmp exit

	.borrarInterior:
		cmp byte[bufferExpresion + r9], ')'
		je .guardarResto
		mov byte[bufferExpresion + r9], 0
		inc r9
		jmp .borrarInterior

	.guardarResto:
		mov byte[bufferExpresion + r9], 0
		cmp byte[bufferExpresion + r9 + 1], 0
		je .reemplazarValor
		inc r9
		mov al, byte[bufferExpresion + r9]
		mov byte[bufferSobra + r10], al
		inc r10
		mov byte[bufferExpresion + r9], 0
		jmp .guardarResto

	.reemplazarValor:
		xor r10, r10
		pop r9	; se recupera la posición del paréntesis izquierdo
		inc r9

	.copiarResultado:
		mov al, byte[bufferExpActual + r10]
		mov byte[bufferExpresion + r9], al
		inc r10
		inc r9
		cmp byte[bufferExpActual + r10], 0
		jne .copiarResultado
		xor r10, r10

	.agregarRestos:
		mov al, byte[bufferSobra + r10]
		mov byte[bufferExpresion + r9], al
		inc r9
		inc r10
		cmp byte[bufferSobra + r10], 0
		jne .agregarRestos
		jmp	evaluarExpresionTotal

	.evaluarExpresionFinal:
		call encontrarParentesisInterior
		; copiar BufferExpresion a bufferExpActual
		push rsi
		mov rsi, bufferExpActual
		call getLargoBuffer
		mov r13, r14
		pop rsi

		call evaluarExpresionSimple
		ret

quitarComa:
	
	xor r8, r8
	
	;mov rsi, bufferExpTemp
	;call limpiarBufferTemp


	.ciclo:
		cmp byte[bufferExpresion + r8], ','
		je .salir
		cmp byte[bufferExpresion + r8], 0Ah
		je .quitarEnter
		cmp byte[bufferExpresion + r8], 0Dh
		je .quitarEnter
		;cmp byte[bufferExpresion + r8], 0
		;je .noHayComa
		;mov al, byte[bufferExpresion + r8]
		;mov byte[bufferExpTemp + r8], al
		inc r8
		cmp r8, r15
		jb .ciclo
		ret

	.salir:
		mov byte[bufferExpresion + r8 + 1], 0
		dec r15
	.quitarEnter:
		mov byte[bufferExpresion + r8], 0
		;call copiarBuffer
		mov rsi, bufferExpresion
		call getLargoBuffer
		mov r15, r14
		ret

itoa:
	; FUNCIÓN
	; Convierte números a caracteres ASCII

	; Entrada: rax, número a convertir
	; Salida: bufferItoa, número convertido

	push rdx
	push rbx
	xor rdx, rdx
	xor rbx, rbx
	call getLargoNumero						; en rcx se guarda el largo
	dec rcx
	mov rbx, 10								; mueve un 10 para que puede dividir

	cmp rax, 0
	jl .ponerSigno

	.ciclo:
		div rbx								; divide al rax (el numero), por 10 esto nos da el digito menos significativo
		add rdx, 30h						; convierta al residuo de la division en un numero
		mov [bufferItoa + rcx], dl			; mueve el numero convertido a ascii al buffer en su posicion correspondiente.
		xor rdx, rdx 						; limpia el rdx, donde quedan los residuos de las divisiones por 10
		dec rcx								; decrementa al rcx, para seguir con el siquiente operando

		cmp byte[bufferItoa], '-'			
		je .finDeCicloAlternativo		

		cmp rcx, 0							; compara el rcx con el tamaño del numero, si es menor a 0 sale del cilo
		jl  .salir
		jmp .ciclo							; si no es menor a cero, vuelve al loop 

	.finDeCicloAlternativo:
		cmp rcx, 1
		jl .salir
		jmp .ciclo

	.salir:
		pop rbx
		pop rdx
		ret

	.ponerSigno:
		neg rax
		inc rcx
		mov byte[bufferItoa], '-'
		jmp .ciclo

atoi:
	; FUNCIÓN
	; Convierte caracteres ASCII a números

	; Entradas: bufferAtoiTemp, hilera de caracteres
	;			r14, largo del buffer
	; Salidas: rax, número convertido

	push rbx
	push r10
	xor rbx, rbx
	mov rcx, 0
	xor r8, r8 	
	xor r10, r10												; contador

	cmp byte[bufferAtoiTemp + rcx], '-'
	je .setBandera

	.inicio:

		mov al, byte[bufferAtoiTemp + rcx]			; mueve el primer caracter
		sub rax, 30h								; transforma el rax a numero
		mov r10, 10	
													; mueve 10 para multiplicar con el rax
	.loopAtoi:	
		inc rcx										; incrementa contador
		cmp rcx, r14								; compara el rcx con el largo del numero.
		je .terminar								; regresa al loop del atoi
		mov bl, byte[bufferAtoiTemp + rcx]			; mueve el siguiente caracter al bl
		sub rbx, 30h								; transforma a numero
		mul r10										; multiplica el rax * 10
		add rax, rbx								; suma el rbx con el rax 
		jmp .loopAtoi
		
	.terminar:
		cmp r8, -1
		je .agregarSigno
		pop r10
		pop rbx
		ret

	.agregarSigno:
		; Si había un caracter '-' al inicio, niega el número de resultado
		neg rax
		pop r10
		pop rbx
		ret

	.setBandera:
		mov r8, -1
		inc rcx
		jmp .inicio

copiarBufferABufferAtoi:

	; FUNCIÓN
	; Copia el contenido de un buffer a bufferAtoiTemp

	; Entradas: rsi, dirección del buffer del cuál se copiará
	;			r14, largo del buffer
	; Salidas:  bufferAtoiTemp, contenido copiado

	push rcx
	xor rcx, rcx
	call limpiarBufferAtoi

	.ciclo:
		mov al, byte[rsi + rcx]
		mov byte[bufferAtoiTemp + rcx], al
		inc rcx
		cmp rcx, r14
		jne .ciclo

	.terminar:
		pop rcx
		ret

limpiarBufferAtoi:

	; FUNCIÓN
	; Limpia el bufferAtoiTemp

	push r9
	xor r9, r9

	.ciclo:
		mov byte[bufferAtoiTemp + r9], 0
		inc r9
		cmp byte[bufferAtoiTemp + r9], 0
		jne .ciclo
		pop r9
		ret

limpiarBuffer:
	
	; FUNCIÓN
	; Limpia el bufferItoa

	; Entradas: rsi, dirección del buffer

	push r9
	xor r9, r9

	.ciclo:
		mov byte[rsi + r9], 0
		inc r9
		cmp byte[rsi + r9], 0
		jne .ciclo
		pop r9
		ret

limpiarBufferSobra:

	; FUNCIÓN
	; Limpia el bufferItoa

	push r9
	xor r9, r9

	.ciclo:
		mov byte[bufferSobra + r9], 0
		inc r9
		cmp byte[bufferSobra + r9], 0
		jne .ciclo
		pop r9
		ret

limpiarBufferOperacion:

	; FUNCIÓN
	; Limpia el bufferItoa

	push r9
	xor r9, r9

	.ciclo:
		mov byte[bufferOperacion + r9], 0
		inc r9
		cmp byte[bufferOperacion + r9], 0
		jne .ciclo
		pop r9
		ret

getLargoBuffer:
	; FUNCIÓN
	; Obtiene el largo de un buffer

	; Entradas: rsi, dirección del buffer
	; Salidas:  r14, largo de buffer

	xor r14, r14

	.ciclo:
		cmp byte[rsi + r14], 0
		je .terminar
		inc r14
		jmp .ciclo

	.terminar:
		ret

getLargoNumero:
	; FUNCIÓN
	; Obtiene el largo de un número

	; Entradas: rax, número
	; Salidas:  rcx, largo del número

	push rax
	push rbx
	push rdx

	mov rbx, 10
	xor rcx, rcx ; Contador 
	xor rdx, rdx

	cmp rax, 0
	je .salir
	cmp rax, 0
	jl .negarNumero


	.ciclo:
		div rbx
		cmp rax, 0
		je .salir
		inc rcx
		xor rdx, rdx
		jmp .ciclo

	.salir:
		inc rcx
		pop rdx
		pop rbx
		pop rax
		ret

	.negarNumero:
		neg rax
		jmp .ciclo

sumar:	
	; FUNCIÓN
	; Suma lo que está en rax con lo que está en rbx

	; Entradas: rax, primer operando
	;			rbx, segundo operando 
	; Salidas: 	rax, resultado de la suma
	add rax, rbx
	ret

restar:
	; FUNCIÓN
	; Resta lo que está en rax con lo que está en rbx

	; Entradas: rax, primer operando
	;			rbx, segundo operando 
	; Salidas: 	rax, resultado de la resta
	sub rax, rbx
	ret

multiplicar:
	; FUNCIÓN
	; Multiplica lo que está en rax con lo que está en rbx

	; Entradas: rax, primer operando
	;			rbx, segundo operando 
	; Salidas: 	rax, resultado de la multiplicación
	mul rbx
	ret

dividir:
	; FUNCIÓN
	; Divide lo que está en rax con lo que está en rbx

	; Entradas: rax, primer operando
	;			rbx, segundo operando 
	; Salidas: 	rax, resultado de la división

	; Verifica que no existan divisiones con cero
	cmp rax, 0
	je .errorCero
	cmp rbx, 0
	je .errorCero
	cmp rbx, 1		; Si el denominador es 1, retorna el numerador
	je .retornar
	cmp rax, rbx   	; Si son iguales, retorna 1
	je .sonIguales

	push rdx
	push rcx

	xor rcx, rcx
	xor rdx, rdx

	call .divNegativo	; Verifica signos para que la división sea sólo de positivos
						; y que se niegue el resultado al final si así corresponde

	div rbx

	cmp rdx, 0		; Si el residuo es distinto de cero, no es división exacta y da error
	jne .errorPuntoFlotante

	cmp rcx, -1			; Bandera: -1 indica que hay que negar la respuesta
	je .negarResultado

	pop rcx
	pop rdx

	ret

	.retornar:
		ret

	.sonIguales:
		mov rax, 1
		ret

	.divNegativo:
		; Verifica que se cumplan todos los casos posibles de división entre signos iguales y distintos
		cmp rax, 0
		jl .verificarDenominadorConNumeradorNegativo
		jmp .verificarDenominadorConNumeradorPositivo


	.verificarDenominadorConNumeradorNegativo:
		neg rax
		cmp rbx, 0
		jl .negarRBX
		call .setBandera
		ret

	.verificarDenominadorConNumeradorPositivo:
		cmp rbx, 0
		jl .niegaRBXySetBandera
		ret

	.negarRBX:
		neg rbx
		ret

	.niegaRBXySetBandera:
		neg rbx

	.setBandera:
		mov rcx, -1
		ret

	.negarResultado:
		pop rcx
		pop rdx
		neg rax
		ret

	.errorCero:

		mov rsi, ErrorDivisionCero
		mov rdx, lenErrorDivCero
		call imprimir
		jmp exit

	.errorPuntoFlotante:

		mov rsi, ErrorPuntoFlotante
		mov rdx, lenErrorPuntoFlotante
		call imprimir
		jmp exit

esigual:
	push rax
	mov rsi, instruccion1
	mov rdx, lenInstruccion1
	call imprimir
	pop rax
	jmp exit

msjeee:
	push rax
	mov rsi, msje
	mov rdx, lenmsje
	call imprimir
	pop rax
	jmp exit

comenzar:
	; PROCEDIMIENTO
	; Imprime las primeras instrucciones para dar al usuario

	mov rsi, instruccion1
	mov rdx, lenInstruccion1
	call imprimir

	mov rsi, instruccion2
	mov rdx, lenInstruccion2
	call imprimir

	ret

exit:
	; PROCEDIMIENTO
	; Sale del programa

	mov rax, 60
	mov rdi, 0
	syscall

