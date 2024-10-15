ORG 100h           ; Origin, to specify that the program starts at 100h (COM file format)

_start:
    ; Display message "Enter first digit: "
    MOV DX, OFFSET msg_input1
    MOV AH, 09h
    INT 21h

    ; Get the first single-digit integer from the user
    MOV AH, 01h
    INT 21h
    CMP AL, '0'          ; Check if input is less than '0'
    JL InvalidInput      ; Jump to error if input is not a valid digit
    CMP AL, '9'          ; Check if input is greater than '9'
    JG InvalidInput      ; Jump to error if input is not a valid digit
    SUB AL, '0'          ; Convert ASCII to number (0-9)
    MOV BL, AL           ; Store first integer in BL

    ; Display message "Enter second digit: "
    MOV DX, OFFSET msg_input2
    MOV AH, 09h
    INT 21h

    ; Get the second single-digit integer from the user
    MOV AH, 01h
    INT 21h
    CMP AL, '0'          ; Check if input is less than '0'
    JL InvalidInput      ; Jump to error if input is not a valid digit
    CMP AL, '9'          ; Check if input is greater than '9'
    JG InvalidInput      ; Jump to error if input is not a valid digit
    SUB AL, '0'          ; Convert ASCII to number (0-9)
    MOV BH, AL           ; Store second integer in BH

    ; Perform the subtraction (BL - BH)
    SUB BL, BH

    ; Convert the result back to ASCII
    ADD BL, '0'

    ; Display the result message
    MOV DX, OFFSET msg_output
    MOV AH, 09h
    INT 21h

    ; Display the result of the subtraction
    MOV DL, BL
    MOV AH, 02h
    INT 21h

    JMP EndProgram       ; End program execution

InvalidInput:
    ; If input is not a valid digit, display an error message
    MOV DX, OFFSET msg_error
    MOV AH, 09h
    INT 21h

EndProgram:
    ; Terminate the program
    MOV AH, 4Ch
    INT 21h

msg_input1  DB 'Enter first digit: $'              ; Message for the first input
msg_input2  DB 0Dh, 0Ah, 'Enter second digit: $'   ; Message for the second input
msg_output  DB 0Dh, 0Ah, 'The result is: $'        ; Message for displaying the result
msg_error   DB 0Dh, 0Ah, 'Error: Invalid input! $' ; Error message for invalid input

END