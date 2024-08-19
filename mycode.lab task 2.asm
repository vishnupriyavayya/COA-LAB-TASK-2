ORG 100h
NUM1 DW 1234h  ; Define first 16-bit number
NUM2 DW 5678h  ; Define second 16-bit number
START:
    MOV AX, NUM1  ; Move NUM1 to AX register
    ADD AX, NUM2  ; Add NUM2 to AX register (AX = NUM1 + NUM2)
    ; Convert result to ASCII and display
    MOV BX, AX    ; Copy result to BX for further processing
    ; Process higher byte of the result
    MOV AH, BH    ; Move higher byte of result to AH
    SHR AH, 4     ; Shift right by 4 to get upper nibble
    ADD AH, 30h   ; Convert to ASCII
    CMP AH, 39h   ; Compare if less than '9'
    JLE PRINT_HIGH_NIBBLE
    ADD AH, 7     ; Convert to ASCII letter if necessary
PRINT_HIGH_NIBBLE:
    MOV DL, AH    ; Move AH to DL for printing
    MOV AH, 02h   ; BIOS interrupt to display character
    INT 21h
    ; Process lower nibble of the higher byte
    MOV AH, BH    ; Move higher byte of result to AH
    AND AH, 0Fh   ; Mask upper nibble
    ADD AH, 30h   ; Convert to ASCII
    CMP AH, 39h   ; Compare if less than '9'
    JLE PRINT_LOW_NIBBLE
    ADD AH, 7     ; Convert to ASCII letter if necessary
PRINT_LOW_NIBBLE:
    MOV DL, AH    ; Move AH to DL for printing
    MOV AH, 02h   ; BIOS interrupt to display character
    INT 21h
    ; Process upper nibble of the lower byte
    MOV AH, BL    ; Move lower byte of result to AH
    SHR AH, 4     ; Shift right by 4 to get upper nibble
    ADD AH, 30h   ; Convert to ASCII
    CMP AH, 39h   ; Compare if less than '9'
    JLE PRINT_HIGH_NIBBLE2
    ADD AH, 7     ; Convert to ASCII letter if necessary
PRINT_HIGH_NIBBLE2:
    MOV DL, AH    ; Move AH to DL for printing
    MOV AH, 02h   ; BIOS interrupt to display character
    INT 21h
    ; Process lower nibble of the lower byte
    MOV AH, BL    ; Move lower byte of result to AH
    AND AH, 0Fh   ; Mask upper nibble
    ADD AH, 30h   ; Convert to ASCII
    CMP AH, 39h   ; Compare if less than '9'
    JLE PRINT_LOW_NIBBLE2
    ADD AH, 7     ; Convert to ASCII letter if necessary
PRINT_LOW_NIBBLE2:
    MOV DL, AH    ; Move AH to DL for printing
    MOV AH, 02h   ; BIOS interrupt to display character
    INT 21h
    MOV AH, 4Ch   ; Terminate program
    INT 21h