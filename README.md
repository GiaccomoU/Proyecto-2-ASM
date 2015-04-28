section .bss

	bufferExpresion: resb BuffExpresionLen
	BuffExpresionLen: equ 1024

section .data

	instruccion1 db "******************************* Proyecto #2 *******************************",0,10,10
	instruccion2 db "      Escriba la expresión matématica con un máximo de 20 variables:",0,10,10
	lenInstruccion equ $-instruccion1
	lenInstruccion2 equ $-instruccion2

section .text

global _start

_start:

mov edx, lenInstruccion
mov ecx, instruccion1
call imprimir
mov edx, lenInstruccion2
mov ecx, instruccion2

leerYGuardar:

	mov rax, 0
	mov rdi, 0
	mov rsi, bufferExpresion
	mov rdx, BuffExpresionLen
	syscall

	mov rcx, 0
	mov rsi, 0

leerExpresion:

	cmp byte[bufferExpresion + rsi], 28h
	jne next
	push byte[bufferExpresion + rsi]

next:
	inc rsi
	inc rcx
	cmp rcx, rax 	; Compara el max de caracteres de la expresión dada, con el número de caracteres que ha leído
	jne leerExpresion

imprimir:

	mov edx,edx			; largo del mensaje a imprimir
	mov ecx,ecx			; mensaje a imprimir
	mov eax,4			; file descriptor (sys_write)
	mov ebx,1			; system call number (std out)
	syscall

salir:

	mov eax,1
	syscall
