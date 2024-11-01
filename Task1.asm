addition_numbers macro var1 var2
           
    lea dx, output_add
    mov ah, 9
    int 21h
    
    mov al, var1
    add al, var2
    add al, '0' 
    mov dl, al
    mov ah, 2
    int 21h
endm

subtract_numbers macro  var1 var2
    
    
     lea dx, output_sub
    mov ah, 9
    int 21h
    
    mov al, var1
    sub al, var2
    add al, '0' ; Convert number to ASCII
    mov dl, al
    mov ah, 2
    int 21h
    
endm

 divide_numbers macro var1 var2
    
     lea dx, output_div
    mov ah, 9
    int 21h
    
    mov al, var1
    mov ah, 0  ; Clear AH for division
    div var2   
    add al, '0'
    mov dl, al
    mov ah, 2
    int 21h
    
    endm
.model small
.stack 100h

.data
prompt db "Please select the proper number from the following:$"
option1 db "1. Addition$"
option2 db "2. Subtraction$"
option3 db "3. Division$"

input1 db "Enter number 1:$"
input2 db "Enter number 2:$"

var1 db ?
var2 db ?

output_add db "The sum of the above numbers is:$"
output_sub db "The difference of the above numbers is:$"
output_div db "The quotient of the above numbers is:$"

.code 
main proc 
    mov ax, @data
    mov ds, ax
    
    lea dx, prompt
    mov ah, 9
    int 21h
    
    call nextline
    
    lea dx, option1
    mov ah, 9
    int 21h
    
    call nextline
    
    lea dx, option2
    mov ah, 9
    int 21h
    
    call nextline
    
    lea dx, option3
    mov ah, 9
    int 21h
    
    call nextline
    
    mov ah, 1
    int 21h
    
    cmp al, '1'
    je addition
    cmp al, '2'
    je subtraction
    cmp al, '3'
    je division
    
    ; Terminate program
    mov ah, 4ch
    int 21h

main endp

addition proc
    call number1
    call nextline
    
    mov ah, 1
    int 21h 
    sub al, '0' ; Convert ASCII to number
    mov var1, al
    
    call number2
    call nextline
    
    mov ah, 1
    int 21h
    sub al, '0' ; Convert ASCII to number
    mov var2, al
    
    call nextline 
    
    addition_numbers var1 var2
    ; Terminate program
    mov ah, 4ch
    int 21h
addition endp

subtraction proc
    call number1
    call nextline
    
    mov ah, 1
    int 21h 
    sub al, '0' ; Convert ASCII to number
    mov var1, al
    
    call number2
    call nextline
    
    mov ah, 1
    int 21h
    sub al, '0' ; Convert ASCII to number
    mov var2, al
    
    call nextline
    
    subtract_numbers var1 var2
   
    ; Terminate program
    mov ah, 4ch
    int 21h
subtraction endp

division proc
    call number1
    call nextline
    
    mov ah, 1
    int 21h 
    sub al, '0' ; Convert ASCII to number
    mov var1, al
    
    call number2
    call nextline
    
    mov ah, 1
    int 21h
    sub al, '0' ; Convert ASCII to number
    mov var2, al
    
    call nextline
    
    divide_numbers var1 var2
    
   
    
    ; Terminate program
    mov ah, 4ch
    int 21h
division endp

number1 proc 
    call nextline
    lea dx, input1
    mov ah, 9
    int 21h
    ret
number1 endp

number2 proc 
    call nextline
    lea dx, input2
    mov ah, 9
    int 21h
    ret
number2 endp

nextline proc
    mov dl, 10
    mov ah ,2
    int 21h
    
    mov dl, 13
    mov ah, 2
    int 21h 
    ret 
nextline endp

end main
