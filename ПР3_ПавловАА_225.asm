; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    A DB ?
    X DB ?
    Y DB ?
    Y1 DB ?
    Y2 DB ?
    PERENOS DB 13,10,"$"
    VVOD_A DB 13,10,"VVEDITE A=$"
    VVOD_X DB 13,10,"VVEDITE X=$",13,10
    VIVOD_Y DB "Y=$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax
    
    xor ax,ax
    mov dx,offset VVOD_A
    mov ah,9
    int 21h
    
    sled2:
    mov ah,1
    int 21h
    cmp al,"-"
    jnz sled1
    mov bx,1
    jmp sled2
    
    sled1:
    sub al,30h
    test bx,bx
    jz sled3
    neg al
    
    sled3:
    mov a,al
    xor ax,ax
    xor bx,bx
    mov dx,offset VVOD_X
    mov ah,9
    int 21h
    
    sled4:
    mov ah,1
    int 21h
    cmp al,"-"
    jnz sled5
    mov bx,1
    jmp sled4
    
    sled5:
    sub al,30h
    test bx,bx
    jz sled6
    neg al
    
    sled6:
    mov cl,al
    mov dl,a
    mov x,al
    mov al,a
    cmp x,4
    jle @left
    mov al,-5 
    jmp short @vixod
    @left:
    sub x,al
    mov al,x
    @vixod:
    mov y1,al
    jmp sled9
    
    sled9:
    mov x,cl
    mov al,x
    mov bl,dl
    cmp al,bl
    jle @left1
    mov al,bl
    cmp al,0
    jge @vixod1
    neg al 
    jmp short @vixod1
    @left1:
    mov al,9
    @vixod1:
    mov y2,al
    jmp sled10
    
    sled10:
    mov al,y1
    cmp al,0
    jge @itog
    neg al
    jmp short @itog
    @itog:
    add al,y2
    mov y,al 
            
    mov dx,offset PERENOS
    mov ah,9
    int 21h
    
    mov dx,offset VIVOD_Y
    mov ah,9
    int 21h
    
    mov al,y
    cmp y,0
    jge sled7
    
    neg al
    mov bl,al
    mov dl,"-"
    mov ah,2
    int 21h
    mov dl,bl
    add dl,30h
    int 21h
    jmp sled8
    
    sled7:
    mov dl,y
    add dl,30h
    mov ah,2
    int 21h
    
    sled8:
    mov dx,offset PERENOS
    mov ah,9
    int 21h

    ; add your code here
            
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
