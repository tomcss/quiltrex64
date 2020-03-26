!zone macros
;======================================================================
;
; Macros!
;
;======================================================================

!macro backup_registers {
	; store registers acc,x,y on the stack
	pha
	
	txa
	pha
	
	tya
	pha
}

!macro restore_registers
	; restores registers y,x,acc from the stack
	pla
	tay
	
	pla
	tax
	
	pla
!end
