;
; Autoloader
;
* = $0801
!byte $0c,$08,$0a,$00,$9e,$20,$34,$30,$39,$36,$00,$00,$00
; Executes "SYS 4096" in BASIC
;
;========================================================

*=$1000

!source "macros.asm"

SCREEN = $0400
KEYBOARD = $00CB
KEYBOARD_META = $028D
screen_colours = $D800
RASTER_LINE = $D012

BORDER_COLOUR = $D020
BACKGROUND_COLOUR = $D021

JOY1 = $DC01
JOY2 = $DC00

JOY_UP     = %00000001
JOY_DOWN   = %00000010
JOY_LEFT   = %00000100
JOY_RIGHT  = %00001000
JOY_BUTTON = %00010000

ZPP1 = $40 ; Zero page pointers
ZPP2 = $42
ZPP3 = $44

VIC = $D000
VIC_COLOURRAM = $D800

CHRIN = $FFCF

!zone init
;==========================================================================
;
; first run initialization code
;
;==========================================================================

init
	jsr init_sidrng ; setting up the random number generator
	
	jmp mainmenu

!zone mainmenu
mainmenu

	jsr loadscreen_mainmenu
	-
	jsr .draw_mainmenu
	jsr .handle_input
	jsr vsync
	;jmp -
	; testing, skipping menu
	jmp playing
	
.handle_input

	lda JOY2       ; Joystick 2 state
	
	cmp .joy2_pstate ; Is the input new?
	bne+
	rts		; return if it isn't
	
+	sta .joy2_pstate
	
	;{ Check JOY2_UP
	
	lda JOY2
	
	and #JOY_UP ; Up is pressed
	cmp #0
	bne++
	
	sec
	lda .status    ; Decrease .status
	sbc #1         ; by 1
	cmp #255       ; is it now 255?
	bne+
	lda #2         ; then set it to 2
+	sta .status    ; and store it back into .status
	;}
++
	;{ Check JOY2_DOWN
		
	lda JOY2
	
	and #JOY_DOWN   ; Down is pressed
	cmp #0
	bne++
	
	clc
	lda .status     ; load .status into a
	adc #1          ; add 1
	cmp #3          ; is equal to 3?
	bne+
	lda #0          ; then set it to 0
+	sta .status     ; and store it back into .status
	;}
++
	;{ Check JOY2_BUTTON
		
	lda JOY2
	
	and #JOY_BUTTON
	cmp #0
	bne++
	jmp playing
	++
	;}

	rts

;{ .draw_mainmenu
.draw_mainmenu

	;
	; Checking the main menu status. 0 = New game
	;
	lda .status
	cmp #0
	bne+
	jsr .draw_newgame_active_text
	jsr .draw_info_inactive_text
	jsr .draw_quit_inactive_text
+

	;
	; 1 = Info
	;
	lda .status
	cmp #1
	bne+
	jsr .draw_newgame_inactive_text
	jsr .draw_info_active_text
	jsr .draw_quit_inactive_text
+

	;
	; 2 = Quit
	;
	lda .status
	cmp #2
	bne+
	jsr .draw_newgame_inactive_text
	jsr .draw_info_inactive_text
	jsr .draw_quit_active_text
+
	
	rts	
; .draw_mainmenu}

;
; Text drawing routines
;

; { New Game

.draw_newgame_inactive_text

	; Text to draw
	
	lda #<.text_newgame_inactive
	sta arg16b1
	lda #>.text_newgame_inactive
	sta arg16b1+1
	
	; Location to draw it to
	
	lda #<(SCREEN+.location_newgame)
	sta arg16b2
        lda #>(SCREEN+.location_newgame)
        sta arg16b2+1
	
	; Length of text
	
	lda #12
	sta arg16b3
	lda #0
	sta arg16b3+1
	
	; Calling memcopy with the previously set arguments
	
	jsr memcopy
	
	; Now to copy the colour information

	; Colour location
	
	lda #<.colour_inactive
	sta arg16b1
	lda #>.colour_inactive
	sta arg16b1+1
	
	; Location to draw it to
	
	lda #<(VIC_COLOURRAM+.location_newgame)
	sta arg16b2
        lda #>(VIC_COLOURRAM+.location_newgame)
        sta arg16b2+1
	
	; Length of text
	
	lda #12
	sta arg16b3
	lda #0
	sta arg16b3+1
	
	jsr memcopy
	
	rts


.draw_newgame_active_text

	; Text to draw
	
	lda #<.text_newgame_active
	sta arg16b1
	lda #>.text_newgame_active
	sta arg16b1+1
	
	; Location to draw it to
	
	lda #<(SCREEN+.location_newgame)
	sta arg16b2
        lda #>(SCREEN+.location_newgame)
        sta arg16b2+1
	
	; Length of text
	
	lda #12
	sta arg16b3
	lda #0
	sta arg16b3+1
	
	; Calling memcopy with the previously set arguments
	
	jsr memcopy
	
	; Now to copy the colour information

	; Colour location
	
	lda #<.colour_active
	sta arg16b1
	lda #>.colour_active
	sta arg16b1+1
	
	; Location to draw it to
	
	lda #<(VIC_COLOURRAM+.location_newgame)
	sta arg16b2
        lda #>(VIC_COLOURRAM+.location_newgame)
        sta arg16b2+1
	
	; Length of text
	
	lda #12
	sta arg16b3
	lda #0
	sta arg16b3+1
	
	jsr memcopy
	
	rts

; New Game }

; { Info

.draw_info_inactive_text

	; Text to draw
	
	lda #<.text_info_inactive
	sta arg16b1
	lda #>.text_info_inactive
	sta arg16b1+1
	
	; Location to draw it to
	
	lda #<(SCREEN+.location_info)
	sta arg16b2
        lda #>(SCREEN+.location_info)
        sta arg16b2+1
	
	; Length of text
	
	lda #12
	sta arg16b3
	lda #0
	sta arg16b3+1
	
	; Calling memcopy with the previously set arguments
	
	jsr memcopy
	
	; Now to copy the colour information

	; Colour location
	
	lda #<.colour_inactive
	sta arg16b1
	lda #>.colour_inactive
	sta arg16b1+1
	
	; Location to draw it to
	
	lda #<(VIC_COLOURRAM+.location_info)
	sta arg16b2
        lda #>(VIC_COLOURRAM+.location_info)
        sta arg16b2+1
	
	; Length of text
	
	lda #12
	sta arg16b3
	lda #0
	sta arg16b3+1
	
	jsr memcopy
	
	rts


.draw_info_active_text

	; Text to draw
	
	lda #<.text_info_active
	sta arg16b1
	lda #>.text_info_active
	sta arg16b1+1
	
	; Location to draw it to
	
	lda #<(SCREEN+.location_info)
	sta arg16b2
        lda #>(SCREEN+.location_info)
        sta arg16b2+1
	
	; Length of text
	
	lda #12
	sta arg16b3
	lda #0
	sta arg16b3+1
	
	; Calling memcopy with the previously set arguments
	
	jsr memcopy
	
	; Now to copy the colour information

	; Colour location
	
	lda #<.colour_active
	sta arg16b1
	lda #>.colour_active
	sta arg16b1+1
	
	; Location to draw it to
	
	lda #<(VIC_COLOURRAM+.location_info)
	sta arg16b2
        lda #>(VIC_COLOURRAM+.location_info)
        sta arg16b2+1
	
	; Length of text
	
	lda #12
	sta arg16b3
	lda #0
	sta arg16b3+1
	
	jsr memcopy
	
	rts

; Info }

; { Quit

.draw_quit_inactive_text

	; Text to draw
	
	lda #<.text_quit_inactive
	sta arg16b1
	lda #>.text_quit_inactive
	sta arg16b1+1
	
	; Location to draw it to
	
	lda #<(SCREEN+.location_quit)
	sta arg16b2
        lda #>(SCREEN+.location_quit)
        sta arg16b2+1
	
	; Length of text
	
	lda #12
	sta arg16b3
	lda #0
	sta arg16b3+1
	
	; Calling memcopy with the previously set arguments
	
	jsr memcopy
	
	; Now to copy the colour information

	; Colour location
	
	lda #<.colour_inactive
	sta arg16b1
	lda #>.colour_inactive
	sta arg16b1+1
	
	; Location to draw it to
	
	lda #<(VIC_COLOURRAM+.location_quit)
	sta arg16b2
        lda #>(VIC_COLOURRAM+.location_quit)
        sta arg16b2+1
	
	; Length of text
	
	lda #12
	sta arg16b3
	lda #0
	sta arg16b3+1
	
	jsr memcopy
	
	rts


.draw_quit_active_text

	; Text to draw
	
	lda #<.text_quit_active
	sta arg16b1
	lda #>.text_quit_active
	sta arg16b1+1
	
	; Location to draw it to
	
	lda #<(SCREEN+.location_quit)
	sta arg16b2
        lda #>(SCREEN+.location_quit)
        sta arg16b2+1
	
	; Length of text
	
	lda #12
	sta arg16b3
	lda #0
	sta arg16b3+1
	
	; Calling memcopy with the previously set arguments
	
	jsr memcopy
	
	; Now to copy the colour information

	; Colour location
	
	lda #<.colour_active
	sta arg16b1
	lda #>.colour_active
	sta arg16b1+1
	
	; Location to draw it to
	
	lda #<(VIC_COLOURRAM+.location_quit)
	sta arg16b2
        lda #>(VIC_COLOURRAM+.location_quit)
        sta arg16b2+1
	
	; Length of text
	
	lda #12
	sta arg16b3
	lda #0
	sta arg16b3+1
	
	jsr memcopy
	
	rts

; Quit }

;
; Variables, labels and data
;

.location_newgame = $23E
.location_info = $28E
.location_quit = $2dE

.joy2_pstate !byte #0 	; The previous state of Joystick #2
			; This is used to determine whether
			; the input is new
			
.status !byte #0
	; menu status, ie which item
	; should be highlighted and activated
	; 0 = new game
	; 1 = info
	; 2 = quit
	
.colour_active   !byte 5,1,1,1,1,1,1,1,1,1,1,5
.colour_inactive !fill 12,15
	
.text_newgame_inactive !scr "  new game  ",0
.text_newgame_active !scr   "Q new game Q",0

.text_info_inactive !scr    "    info    ",0
.text_info_active !scr      "Q   info   Q",0

.text_quit_inactive !scr    "    quit    ",0
.text_quit_active !scr      "Q   quit   Q",0

!zone playing
;======================================================================
;
; playing     - The ingame playing code
;
;======================================================================
playing
	jsr loadscreen_level
	lda #0
	jsr init_level
	
	jsr draw_target_puzzle
-	
	jsr vsync
	jsr .handle_input
	jsr draw_player_puzzle
	
	jmp-
	
;-----------------------------------

.handle_input

	lda JOY2       ; Joystick 2 state
	
	cmp .joy2_pstate ; Is the input new?
	bne+
	rts		; return if it isn't
	
+	sta .joy2_pstate
	
	; check JOY2_UP
	
	lda JOY2
	
	and #JOY_UP ; Up is pressed
	cmp #0
	bne+
	jsr move_cursor_up
	+
	
	; check JOY2_DOWN
	
	lda JOY2
	
	and #JOY_DOWN ; is down pressed
	cmp #0
	bne+ ; if not, jump to +
	jsr move_cursor_down
	+
	
	; check JOY2_LEFT
	
	lda JOY2
	
	and #JOY_LEFT ; is left pressed
	cmp #0
	bne+ ; if not, jump to +
	jsr move_cursor_left
	+
	
	; check JOY2_RIGHT
	
	lda JOY2
	
	and #JOY_RIGHT ; is right pressed?
	cmp #0
	bne+ ; if not, jump to +
	jsr move_cursor_right
	+

	rts

.joy2_pstate !byte #0 	; The previous state of Joystick #2
			; This is used to determine whether
			; the input is new

!zone move_cursor_up
move_cursor_up
;======================================================================
;
; move_cursor_up
;
;======================================================================
;
; moves the cursor up if possible
; TODO add flash on invalid move?
;

	pha	; backup accumulator

	lda cursor_sprite_pos	; load cursor position
	sta arg8b1		; storing as argument for the swap
	clc	; clear carry
	cmp #6  ; compare position with 6
	
	bcc+	; is position < 6? the skip to +
	sec	; set carry
	sbc #6	; position = position - 6
	sta cursor_sprite_pos	; save position
	+
	
	pla	; restore accumulator
	
	lda cursor_sprite_pos	; setting up the other argument
	sta arg8b2		; for the swap
	
	jsr update_cursor ; update the cursor sprite
	
	jsr swap_tiles
	
	rts	; return to sender

!zone move_cursor_down
move_cursor_down
;======================================================================
;
; move_cursor_down
;
;======================================================================
;
; moves the cursor down if possible
; TODO add flash on invalid move?
;

	pha	; backup accumulator

	lda cursor_sprite_pos	; load cursor position
	sta arg8b1		; storing as argument for the swap
	
	clc	; clear carry
	cmp #31 ; compare position with 30
	
	bcs+	; is position >= 30? the skip to +
	clc	; clear carry
	adc #6	; position = position + 6
	sta cursor_sprite_pos	; save position
	+
	
	pla	; restore accumulator
	
	lda cursor_sprite_pos	; setting up the other argument
	sta arg8b2		; for the swap
	
	jsr swap_tiles
	
	jsr update_cursor ; update the cursor sprite

	rts	; return to sender

!zone move_cursor_left
move_cursor_left
;======================================================================
;
; move_cursor_left
;
;======================================================================
;
; moves the cursor left if possible
; TODO add flash on invalid move?
;

	pha	; backup accumulator

	lda cursor_sprite_pos	; load cursor position
	sta arg8b1		; storing as argument for the swap
	
	; first we calculate position % 6
-
	clc	; clear carry
	cmp #6	; compare acc to 6
	bcc+	; if acc < 6, branch to +

	sec	; set carry
	sbc #6	; acc = acc - 6
	jmp-	; next
+
	
	clc	; clear carry
	cmp #0  ; compare position with 0
	
	beq+	; is position == 0? the skip to +
	dec cursor_sprite_pos	; position = position - 1
	+
	
	pla	; restore accumulator
	
	lda cursor_sprite_pos	; setting up the other argument
	sta arg8b2		; for the swap
	
	jsr swap_tiles
	
	jsr update_cursor ; update the cursor sprite
	
	rts	; return to sender

!zone move_cursor_right
move_cursor_right
;======================================================================
;
; move_cursor_right
;
;======================================================================
;
; moves the cursor right if possible
; TODO add flash on invalid move?
;

	pha	; backup accumulator

	lda cursor_sprite_pos	; load cursor position
	sta arg8b1		; storing as argument for the swap
	
	; first we calculate position % 6
-
	clc	; clear carry
	cmp #6	; compare acc to 6
	bcc+	; if acc < 6, branch to +

	sec	; set carry
	sbc #6	; acc = acc - 6
	jmp-	; next
+
	
	clc	; clear carry
	cmp #5  ; compare position with 5
	
	beq+	; position == 5? the skip to +
	inc cursor_sprite_pos	; position = position + 1
	+
	
	pla	; restore accumulator
	
	lda cursor_sprite_pos	; setting up the other argument
	sta arg8b2		; for the swap
	
	jsr swap_tiles
		
	jsr update_cursor ; update the cursor sprite

	rts	; return to sender


!zone update_cursor
update_cursor
;======================================================================
;
; update_cursor
;
;======================================================================
;
; sets the cursor sprite x and y based on the cursor position
;

	+backup_registers
	
	; setting the cursor x and y to 0 first
	
	clc
	lda #0
	sta cursor_sprite_x
	sta cursor_sprite_y
	
	; now updating them it using the cursor_position
	
	lda cursor_sprite_pos
	
.rows
	clc		; clear carry
	cmp #6		; position < 6 ?
	bcc .columns	; then go to .columns
	
	sec		; set carry
	sbc #6		; position = position - 6
	
	tax		; transfer acc to x (buffer)
	lda cursor_sprite_y ; load y coordinate
	clc		; clear carry
	adc #16		; y coordinate = y co-ordinate + 16 (two petscii chars)
	sta cursor_sprite_y ; save y co-ordinate
	txa		; transfer x (buffer) to acc
	
	jmp .rows	; next row
	
.columns

	clc		; clear carry
	cmp #0		; acc == 0?
	beq .end	; if so, go to .end
	
	sec		; set carry
	sbc #1		; x = x - 1
	
	tax			; transfer acc to x ( buffer )
	lda cursor_sprite_x	; load x co-ordinate
	clc			; clear carry
	adc #16			; x co-ordinate = x co-ordinate + 16
	sta cursor_sprite_x	; save x co-ordinate
	txa			; transfer x ( buffer ) to acc
	
	jmp .columns	; next column

.end	
	; adding the offsets
	
	clc			; clear carry
	lda cursor_sprite_y	; load ypos
	adc #.cursor_y_offset	; ypos = ypos + offset
	sta cursor_sprite_y	; save ypos
	
	clc			; clear carry
	lda cursor_sprite_x	; load xpos
	adc #.cursor_x_offset	; xpos = xpos + offset
	sta cursor_sprite_x	; save xpos
	
	bcc+		; if xpos+offset<=255, jump to +
	lda #1		; acc = 1 (flag bit for sprite 0 x pos)
	ora cursor_sprite_xmsb
	jmp++		; jump to ++
	+
	lda cursor_sprite_xmsb	; load current flags bits
	and #%11111110		; turning flag for sprite 0 x pos to 0
	++
	
	sta cursor_sprite_xmsb ; save xsmb flags
	
	+restore_registers

	rts

.cursor_x_offset = $d0 ; offset from the left of the screen
.cursor_y_offset = $72 ; offset from the top of the screen

!zone init_level
;======================================================================
;
; init_level
;
;======================================================================
;
; acc	Holds the level number we need to load
;

init_level
	lda #<level01        ; Setting the current_puzzle
	sta puzzle_current   ; pointer to the right puzzle
	lda #>level01        ; memory
	sta puzzle_current+1 ;
	
	ldx #0		; now copying the level to the player's
                        ; side

-	cpx #144		
	beq+
	lda level01,x		; copying character
	sta player_solution,x
	lda level01+144,x	; copying colour
	sta player_solution+144,x
	inx
	jmp-
+	

	jsr init_cursor_sprite
	
	rts

!zone init_cursor_sprite
;======================================================================
;
; init_cursor_sprite
;
;======================================================================
;
; the cursor sprite is used to hide a piece, creating the "empty"
; square that moves around
;

init_cursor_sprite

	lda #1		; enabling sprite 0
	sta VIC+21	;
	
	lda #32		; the pointer to the sprite data
	sta $7f8	; 32 * 64 = $0800
	
	lda #100	; setting the x position
	sta cursor_sprite_x
	
	lda #100	; and setting the y position
	sta cursor_sprite_y
	
	lda #7		; setting the sprite colour
	sta cursor_sprite_colour
	
	; now to copy the sprite over
	
	ldx #0
	
.loop
	lda cursor_sprite,x	; copying the next byte
	sta $800,x		; storing it
	
	inx			; x++
	cpx #64			; x==64?
	bne .loop		; true: go to .loop
				; false: we're done
				
	jsr update_cursor ; update the cursor sprite

	rts
			
!zone swap_tiles
swap_tiles
;======================================================================
;
; swap_tiles
;
;======================================================================
;
; swaps two tiles in the player's solution effort
;
; arg8b1 - index of first tile (tile a)
; arg8b2 - index of second tile (tile b)
;

	jsr calc_tile_offset	; calculating the offset for tile a
	lda ret8b1
	sta .tile_a_offset
	
	ldx .tile_a_offset	; the x offset needs to be multiplied
	ldy #6			; by 2
	jsr modulus		;
	clc			; so that's what we're doing here
	adc .tile_a_offset	;
	sta .tile_a_offset	;
	
	
	lda arg8b2		; calculating the offset for tile b
	sta arg8b1
	jsr calc_tile_offset
	lda ret8b1
	sta .tile_b_offset
	
	ldx .tile_b_offset	; the x offset needs to be multiplied
	ldy #6			; by 2
	jsr modulus		;
	clc			; so that's what we're doing here
	adc .tile_b_offset	;
	sta .tile_b_offset	;
	
	; each "block" is 4 smaller blocks:
	; 12
	; 34
	;
	; with blocks 3 and 4 being 24 positions later in memory
	; than 1 and 2
	
	ldx .tile_a_offset	; load block 1 offsets
	ldy .tile_b_offset	;
	
	jsr .transfer_blocks	; transferring block 1
	
	inx			; moving on to block 2
	iny			;
	
	jsr .transfer_blocks	; transferring block 2
	
	txa			; moving down a row to
	clc			; load block 3 offsets
	adc #11			;
	tax			;
	
	tya			;
	clc			;
	adc #11			;
	tay			;
	
	jsr .transfer_blocks	; transferring block 3
	
	inx			; moving on to block 4
	iny			;
	
	jsr .transfer_blocks	; transferring block 4
	
	rts

.transfer_blocks

	lda player_solution,x ; transferring character block
	sta .buffer
	lda player_solution,y
	sta player_solution,x
	lda .buffer
	sta player_solution,y
	
	lda player_solution+144,x ; transferring colour block
	sta .buffer
	lda player_solution+144,y
	sta player_solution+144,x
	lda .buffer
	sta player_solution+144,y
	
	rts
	
.tile_a_offset !byte 0
.tile_b_offset !byte 0
.buffer !byte 0,0,0,0,0,0,0,0 ; to hold the characters and colours

!zone calc_tile_offset
calc_tile_offset
;======================================================================
;
; calc_tile_offset
;
;======================================================================
;
; calculates the offset of the tile in memory
;
; args
; 	arg8b1 - tile index
;
; returns
; 	ret8b1 - calculated offset
;

	+backup_registers
	
	lda arg8b1 ; loading the tile index
	ldx #0

.loop:
	clc
	cmp #6	 ; compare acc to 6
	bcc .end ; if acc < 6, go to .end

	sec		; set carry
	sbc #6		; acc = acc - 6 (tile index)
	sta .buffer	; .buffer = acc
	txa		; acc = x
	clc		; clear carry
	adc #24		; acc = acc + 24 (offset)
	tax		; x = acc
	lda .buffer	; acc = .buffer

	jmp .loop	; next
	
.end			; at this point acc < 6
	sta .buffer	; we'll add the .buffer to x
	txa		; and that's the offset
	clc		;
	adc .buffer	;
	sta ret8b1	; storing the result


	+restore_registers

	rts ; return to sender

.buffer !byte 0

!zone draw_target_puzzle
;======================================================================
;
; draw_target_puzzle
;
;======================================================================
;
; sets zpp1 to the target puzzle characters
;      zpp2 to the target puzzle colours
;      zpp3 to the source puzzle characters and colours
;
; then calls draw_puzzle
;
draw_target_puzzle

	; One for the characters

	lda #<(SCREEN+.offset_target)
	sta ZPP1
	lda #>(SCREEN+.offset_target)
	sta ZPP1+1
	
	; One for the colours
	
	lda #<(VIC_COLOURRAM+.offset_target)
	sta ZPP2
	lda #>(VIC_COLOURRAM+.offset_target)
	sta ZPP2+1
	
	; filling the draw cache
	
	ldx #0
-
	cpx #144		; x == 144?
	beq+			; true: jump to +
	
	lda level01,x		; false, copy next character
	sta draw_cache,x
	lda level01+144,x 	; and colour
	sta draw_cache+144,x
	
	inx			; x++
	jmp-			; next
	
+
	; then to draw the puzzle

	jsr draw_puzzle
	
	rts

.offset_target = $0145   ; The memory offset of the displayed level

!zone draw_player_puzzle
;======================================================================
;
; draw_player_puzzle
;
;======================================================================
;
; sets zpp1 to the player puzzle characters
;  and zpp2 to the player puzzle colours
;
; then calls draw_puzzle
;
draw_player_puzzle

	; One for the characters

	lda #<(SCREEN+.offset_player)
	sta ZPP1
	lda #>(SCREEN+.offset_player)
	sta ZPP1+1
	
	; One for the colours
	
	lda #<(VIC_COLOURRAM+.offset_player)
	sta ZPP2
	lda #>(VIC_COLOURRAM+.offset_player)
	sta ZPP2+1

	; filling the draw cache
	
	ldx #0
-
	cpx #144		; x == 144?
	beq+			; true: jump to +
	
	lda player_solution,x	; false, copy next character
	sta draw_cache,x
	lda player_solution+144,x ; and colour
	sta draw_cache+144,x
	
	inx			; x++
	jmp-			; next
	
+
	
	; now to draw the puzzle
	
	jsr draw_puzzle
	
	rts

.offset_player = $0157   ; The memory offset of the displayed level

!zone draw_puzzle
;======================================================================
;
; draw_puzzle
;
;======================================================================
;
; Draws the current level on the screen
;

draw_puzzle
	; 12 rows of 12 characters
	
	ldx #0
	ldy #0

.loop
	cpy #12		; y == 12?
	bne++
	cpx #144	; and x == 144?
	bne+
	jmp .end	; then go to .end, we're done
	+
	ldy #0		; Setting y back to zero and increasing
			; the target pointer to go to the next
			; line
	
	; first increasing the character pointer
	;
	clc
	
	lda ZPP1
	adc #40			
	sta ZPP1
	lda ZPP1+1
	adc #0
	sta ZPP1+1
	
	; now increasing the colour pointer
	;
	clc
	
	lda ZPP2
	adc #40
	sta ZPP2
	lda ZPP2+1
	adc #0
	sta ZPP2+1
	
++	lda draw_cache,x	; else copy another character
	sta (ZPP1),y		; to the screen
	
	lda draw_cache+144,x
	sta (ZPP2),y

	iny		; y++
      	inx		; x++
	jmp .loop	; go back to loop start
	
.end
	rts

!zone init_sidrng
;======================================================================
;
; init_sidrng
;
;======================================================================
;
; initializes the sid to be used for random number generating
;
init_sidrng

	lda #$FF  ; maximum frequency value
	sta $D40E ; voice 3 frequency low byte
	sta $D40F ; voice 3 frequency high byte
	lda #$80  ; noise waveform, gate bit off
	sta $D412 ; voice 3 control register
	
	rts

!zone vsync
;======================================================================
;
; vsync
;
;======================================================================
;
; Waits for scanline 254, then scanline 255, to prevent
; having this run twice in a single frame

vsync

	pha 		; Backup a to the stack
	
-	lda #254	; Waiting for line 254
	cmp RASTER_LINE
	bne -
	
-	lda #255	; Now waiting for line 255
	cmp RASTER_LINE
	bne -
	
	pla		; Restoring the accumulator
	
	rts		; Return to sender

!zone loadscreen_level
;======================================================================
;
; loadscreen_level
;
;======================================================================
;
; Loads the level SCREEN

loadscreen_level

	;
	; Setting the border and background colour to black
	;
	
	lda #0
	sta BORDER_COLOUR
	sta BACKGROUND_COLOUR

	;
	; Copying the petscii into the SCREEN memory
	;
	
	lda #<screen_level ; Source location
	sta arg16b1
	lda #>screen_level
	sta arg16b1+1
	
	lda #<SCREEN ; Target location
	sta arg16b2
	lda #>SCREEN
	sta arg16b2+1
	
	lda #<1000 ; Length
	sta arg16b3
	lda #>1000
	sta arg16b3+1
	
	jsr memcopy
	
	;
	; Now copying the colour info
	;
	
	lda #<(screen_level+1000) ; Source location
	sta arg16b1
	lda #>(screen_level+1000)
	sta arg16b1+1
	
	lda #<VIC_COLOURRAM ; Target location
	sta arg16b2
	lda #>VIC_COLOURRAM
	sta arg16b2+1
	
	lda #<1000 ; Length
	sta arg16b3
	lda #>1000
	sta arg16b3+1
	
	jsr memcopy	
	
	rts


!zone loadscreen_mainmenu
;======================================================================
;
; loadscreen_mainmenu
;
;======================================================================
;
; Loads the mainmenu SCREEN

loadscreen_mainmenu

	;
	; Setting the border and background colour to black
	;
	
	lda #0
	sta BORDER_COLOUR
	sta BACKGROUND_COLOUR

	;
	; Copying the petscii into the SCREEN memory
	;
	
	lda #<screen_mainmenu ; Source location
	sta arg16b1
	lda #>screen_mainmenu
	sta arg16b1+1
	
	lda #<SCREEN ; Target location
	sta arg16b2
	lda #>SCREEN
	sta arg16b2+1
	
	lda #<1000 ; Length
	sta arg16b3
	lda #>1000
	sta arg16b3+1
	
	jsr memcopy
	
	;
	; Now copying the colour info
	;
	
	lda #<(screen_mainmenu+1000) ; Source location
	sta arg16b1
	lda #>(screen_mainmenu+1000)
	sta arg16b1+1
	
	lda #<VIC_COLOURRAM ; Target location
	sta arg16b2
	lda #>VIC_COLOURRAM
	sta arg16b2+1
	
	lda #<1000 ; Length
	sta arg16b3
	lda #>1000
	sta arg16b3+1
	
	jsr memcopy	
	rts

!zone memcopy
;======================================================================
;
; memcopy
;
;======================================================================
;
; Copies memory from one location to another
;
; arg16b1 source address
; arg16b2 target address
; arg16b3 length
;----------------------------------------------------------------------
memcopy

	; Adding the length to the source
	; address so we know when to stop
	
	clc
	
	lda arg16b1
	adc arg16b3
	sta .source_end
	
	lda arg16b1+1
	adc arg16b3+1
	sta .source_end+1
	
	; Setting up the zero page pointers we'll be using
	
	lda arg16b1
	sta .zpp_source
	
	lda arg16b1+1
	sta .zpp_source+1
	
	lda arg16b2
	sta .zpp_target
	
	lda arg16b2+1
	sta .zpp_target+1
	
.mainloop

	clc

	; Check to see if we're done yet
	
	lda .zpp_source
	cmp .source_end
	bne +
	
	lda .zpp_source+1
	cmp .source_end+1
	beq .end
	
+	; Copying over a single byte

	ldy #0
	lda (.zpp_source),y
	sta (.zpp_target),y
	
	; Increasing our pointers
	
	clc
	
	lda .zpp_source
	adc #1
	sta .zpp_source
	
	lda .zpp_source+1
	adc #0
	sta .zpp_source+1
	
	clc
	
	lda .zpp_target
	adc #1
	sta .zpp_target
	
	lda .zpp_target+1
	adc #0
	sta .zpp_target+1
	
	; And back to the start
	
	jmp .mainloop
	
.end

	rts ; Return to sender
	
.zpp_source = $40
.zpp_target = $42

.source_end !byte #0,0

!zone modulus
modulus
;======================================================================
;
; modulus
;
;======================================================================
; x int A
; y int B
;
; acc A%B

	sty .buffer	; store y in .buffer
	txa		; acc = x
	
.loop
	clc		; clear carry
	cmp .buffer	; compare acc to buffer
	bcc .end	; if acc < buffer, then jump to .end
	sec		; set carry
	sbc .buffer	; acc = acc - .buffer
	jmp .loop	; next
	
.end
	rts	; return to sender
	
.buffer !byte 0
	
!zone data
;----------------------------------------------------------------------
;
; data sources

;   screens

screen_mainmenu !media "mainmenu.charscreen",charcolor
screen_level !media "level.charscreen",charcolor

puzzle_current   !byte 0, 0  ; pointer to the current puzzle
player_solution  !fill 144,0 	; player's solving attempt
player_solution_colours !fill 144,0	; 144 characters, 144 colours
				
draw_cache !fill 288, 0 ; cache used for drawing to the screen
			; to keep the code logic simpler

level01 !media "level01.charscreen",charcolor
level02 !media "level02.charscreen",charcolor
level03 !media "level03.charscreen",charcolor

; current level

current_level !byte #0

; cursor sprite
;
; this sprite goes on top of the "empty" position in the puzzle
; and effectively hides the missing piece

cursor_sprite_pos !byte 7 ; 0-143

cursor_sprite !media "cursor_sprite.spriteproject",sprite,0,1

cursor_sprite_colour = VIC + $27

cursor_sprite_x = VIC
cursor_sprite_y = VIC+$1
cursor_sprite_xmsb = VIC+$10

; Arguments used for passing information
; to subroutines

arg16b1
arg8b1 !byte #0
arg8b2 !byte #0

arg16b2
arg8b3 !byte #0
arg8b4 !byte #0

arg16b3
arg8b5 !byte #0
arg8b6 !byte #0

; and the return values

ret16b1
ret8b1 !byte #0
ret8b2 !byte #0

; sid random number location

rand8 = $D41B
