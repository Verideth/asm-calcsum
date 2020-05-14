; simple assembly example on calculating the 
; remainder multiplier and quotient from two integers
; this code is meant to be easily understood
; there aren't a lot of super basic assembly programs lying 
; around that do beginners programs, so i decided to write
; a list of them (others found on my github) that will
; give a concise simple example on how to go about it
; using i386 assembly 
.386
.model flat,c
.data
	msg db 'DIVISION BY ZERO ERROR', 0
	fmt db '%s', 10, 0

.code
extern printf:proc
intmuldiv proc
	push ebp ; push frame pointer
	mov ebp, esp ; preserve callers stack frame
	push ebx

	xor eax, eax
	mov ecx, [ebp + 8] ; ecx, 'a' argument
	mov edx, [ebp + 12] ; edx, 'b' argument

	test edx, edx ; make sure its not zero
	jz invalid ; if it is and the ZF is set then give a division by zero error

	imul edx, ecx ; b *= a
	mov ebx, [ebp + 16] ; prod ptr
	mov [ebx], edx ; *prod = (b * a)
	
	mov eax, [ebp + 8] ; eax = ecx, 'a'
	cdq ; EDX:EAX, edx is most significant bits
	idiv dword ptr[ebp + 12] ; edx / eax, high bits get divided by low bits 
	; quotient gets stored in eax, remainder gets stored in edx
	mov ebx, [ebp + 20]
	mov [ebx], eax ; set quotient to dereferenced quotient via idiv instruction
	mov ebx, [ebp + 24] ; set quotient to dereferenced quotient via idiv instruction
	mov [ebx], edx ; set remainder to dereferenced remainder pointer via idiv instruction
	mov eax, 1 ; set return value to one
	jmp return ; finish it
invalid:
	push edi
	push esi
	movsx edi, byte ptr [fmt] ; we need to sign extend so edi register (the fmt on printf) is 32-bit, so that it may fit into edi
	movsx esi, byte ptr [msg] ; we need to sign extend so esi register (the message on printf) is 32-bit, so that it may fit into esi
	mov eax, 0
	call printf ; call the external C function printf
	pop edi ; pop edi
	pop esi ; pop esi
	mov eax, 0 ; just in case printf returned a value we'll need to reset eax

return:
	pop ebx ; pop ebx
	pop ebp ; pop frame pointer
	ret ; return
intmuldiv endp
end