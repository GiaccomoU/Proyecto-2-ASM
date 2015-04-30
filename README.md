section .bss

	bufferExpresion: resb buffExpresionLen
	buffExpresionLen: equ 1024

section .data

	instruccion1: 		db 10,"******************************* Proyecto #2 *******************************",10,0
	lenInstruccion1: 	equ $ - instruccion1

	instruccion2: 		db 10,"      Escriba la expresión matématica con un máximo de 20 variables:",10,0
	lenInstruccion2:	equ $ - instruccion2

	Error1: 			db "                 Expresión Algebraica inválida: Paréntesis incorrectos",0,10
	lenError1:			equ $ - Error1

	Acept:				db "Parentesis balanceados",0,10
	lenAcept:			equ $ - Acept

section .text

global _start

_start:

main:

	mov rsi, instruccion1
	mov rdx, lenInstruccion1
	call imprimir

	mov rsi, instruccion2
	mov rdx, lenInstruccion2
	call imprimir

	call leer

	;==================================== RESTRICCIONES ====================================================

	mov  r9,  0 ; Contador de validación de paréntesis
	mov  rcx, 0
	mov  rsi, 0
	call verificarParentesis

	mov  rsi, bufferExpresion
	mov  rdx, buffExpresionLen
	call imprimir
	jmp  exit


imprimir:				; rsi: Mensaje a imprimir, rdx: Longitud del mensaje

	mov rax,1			; file descriptor (sys_write)
	mov rdi,1			; system call number (std out)
	syscall
	ret

leer:

	mov rax, 0						; sys_read (code 0)
	mov rdi, 0						; file descriptor (code 0 stdin)
	mov rsi, bufferExpresion		; address to the buffer to read into
	mov rdx, buffExpresionLen		; number of bytes to read
	syscall
	ret

verificarParentesis:

	cmp r9, 0
	jl  parentesisDesbalanceados
	cmp byte[bufferExpresion + rsi], 28h ; Si el caracter es un paréntesis abierto '('
	je  incrementarR9
	cmp byte[bufferExpresion + rsi], 29h ; Si el caracter es un paréntesis cerrado ')'
	je  decrementarR9
	jmp next

incrementarR9:

	inc r9
	jmp next

decrementarR9:

	dec r9
	jmp next

parentesisDesbalanceados:
	
	mov  rsi, Error1
	mov  rdx, lenError1
	call imprimir
	jmp  exit

next:

	inc rsi
	inc rcx
	cmp rcx, rax 	; Compara el max de caracteres de la expresión dada, con el número de caracteres que ha leído
	jne verificarParentesis
	cmp r9, 0
	jne parentesisDesbalanceados
	ret
	;mov rsi, Acept
	;mov rdx, lenAcept
	;call imprimir
	;jmp exit

exit:

	mov rax, 60
	mov rdi, 0
	syscall
