
  +------------------------------------------------------------------------
  |
  |      VIDEO INTERFACE CHIP (VIC) 6566/6567
  |
  +------------------------------------------------------------------------
  |
  |  VIC related topics:
  |
  |   Bit Interpretations
  |   CBMSCII Charset
  |   Colors
  |   PAL/NTSC Differences
  |   PAL-Timing-Schemes
  |   Screen Dimensions
  |
  |  Register description:
  |
  |   $D000/53248/VIC+0        Sprite 0 X Pos
  |   $D001/53249/VIC+1        Sprite 0 Y Pos
  |   $D002/53250/VIC+2        Sprite 1 X Pos
  |   $D003/53251/VIC+3        Sprite 1 Y Pos
  |   $D004/53252/VIC+4        Sprite 2 X Pos
  |   $D005/53253/VIC+5        Sprite 2 Y Pos
  |   $D006/53254/VIC+6        Sprite 3 X Pos
  |   $D007/53255/VIC+7        Sprite 3 Y Pos
  |   $D008/53256/VIC+8        Sprite 4 X Pos
  |   $D009/53257/VIC+9        Sprite 4 Y Pos
  |   $D00A/53258/VIC+10       Sprite 5 X Pos
  |   $D00B/53259/VIC+11       Sprite 5 Y Pos
  |   $D00C/53260/VIC+12       Sprite 6 X Pos
  |   $D00D/53261/VIC+13       Sprite 6 Y Pos
  |   $D00E/53262/VIC+14       Sprite 7 X Pos
  |   $D00F/53263/VIC+15       Sprite 7 Y Pos
  |   $D010/53264/VIC+16       Sprites 0-7 MSB of X coordinate
  |   $D011/53265/VIC+17       Control Register 1
  |   $D012/53266/VIC+18       Raster Position
  |   $D013/53267/VIC+19       Latch X Pos
  |   $D014/53268/VIC+20       Latch Y Pos
  |   $D015/53269/VIC+21       Sprite display Enable
  |   $D016/53270/VIC+22       Control Register 2
  |   $D017/53271/VIC+23       Sprites Expand 2x Vertical (Y)
  |   $D018/53272/VIC+24       Memory Control Register
  |   $D019/53273/VIC+25       Interrupt Request Register (IRR)
  |   $D01A/53274/VIC+26       Interrupt Mask Register (IMR)
  |   $D01B/53275/VIC+27       Sprite to Background Display Priority
  |   $D01C/53276/VIC+28       Sprites Multi-Color Mode Select
  |   $D01D/53277/VIC+29       Sprites Expand 2x Horizontal (X)
  |   $D01E/53278/VIC+30       Sprite to Sprite Collision Detect
  |   $D01F/53279/VIC+31       Sprite to Background Collision Detect
  |   $D020/53280/VIC+32       Border Color
  |   $D021/53281/VIC+33       Background Color 0
  |   $D022/53282/VIC+34       Background Color 1, Multi-Color Register 0
  |   $D023/53283/VIC+35       Background Color 2, Multi-Color Register 1
  |   $D024/53284/VIC+36       Background Color 3
  |   $D025/53285/VIC+37       Sprite Multi-Color Register 0
  |   $D026/53286/VIC+38       Sprite Multi-Color Register 1
  |   $D027/53287/VIC+39       Sprite 0 Color
  |   $D028/53288/VIC+40       Sprite 1 Color
  |   $D029/53289/VIC+41       Sprite 2 Color
  |   $D02A/53290/VIC+42       Sprite 3 Color
  |   $D02B/53291/VIC+43       Sprite 4 Color
  |   $D02C/53292/VIC+44       Sprite 5 Color
  |   $D02D/53293/VIC+45       Sprite 6 Color
  |   $D02E/53294/VIC+46       Sprite 7 Color
  |
  | C128 only:
  |
  |   $D02F/53295/VIC+47       Port A* for Extended Keyboard
  |   $D030/53296/VIC+48       Switch to FAST-Mode
  |
  +------------------------------------------------------------------------


  +------------------------------------------------------------------------
  |
  |      SOUND INTERFACE DEVICE (SID) 6581
  |
  +------------------------------------------------------------------------
  |
  |  SID related topics:
  |
  |    ADR-Table
  |    SID-Mathmatics
  |
  |  Register description:
  |
  |   $D400/54272/SID+0       Voice 1: Frequency Control - Low-Byte
  |   $D401/54273/SID+1       Voice 1: Frequency Control - High-Byte
  |   $D402/54274/SID+2       Voice 1: Pulse Waveform Width - Low-Byte
  |   $D403/54275/SID+3       Voice 1: Pulse Waveform Width - High-Nybble
  |   $D404/54276/SID+4       Voice 1: Control Register
  |   $D405/54277/SID+5       Voice 1: Attack / Decay Cycle Control
  |   $D406/54278/SID+6       Voice 1: Sustain / Release Cycle Control
  |   $D407/54279/SID+7       Voice 2: Frequency Control - Low-Byte
  |   $D408/54280/SID+8       Voice 2: Frequency Control - High-Byte
  |   $D409/54281/SID+9       Voice 2: Pulse Waveform Width - Low-Byte
  |   $D40A/54282/SID+10      Voice 2: Pulse Waveform Width - High-Nybble
  |   $D40B/54283/SID+11      Voice 2: Control Register
  |   $D40C/54284/SID+12      Voice 2: Attack / Decay Cycle Control
  |   $D40D/54285/SID+13      Voice 2: Sustain / Release Cycle Control
  |   $D40E/54286/SID+14      Voice 3: Frequency Control - Low-Byte
  |   $D40F/54287/SID+15      Voice 3: Frequency Control - High-Byte
  |   $D410/54288/SID+16      Voice 3: Pulse Waveform Width - Low-Byte
  |   $D411/54289/SID+17      Voice 3: Pulse Waveform Width - High-Nybble
  |   $D412/54290/SID+18      Voice 3: Control Register
  |   $D413/54291/SID+19      Voice 3: Attack / Decay Cycle Control
  |   $D414/54292/SID+20      Voice 3: Sustain / Release Cycle Control
  |   $D415/54293/SID+21      Filter Cutoff Frequency: Low-Nybble
  |   $D416/54294/SID+22      Filter Cutoff Frequency: High-Byte
  |   $D417/54295/SID+23      Filter Resonance Control / Voice Input Control
  |   $D418/54296/SID+24      Select Filter Mode and Volume
  |   $D419/54297/SID+25      Analog/Digital Converter: Game Paddle 1
  |   $D41A/54298/SID+26      Analog/Digital Converter: Game Paddle 2
  |   $D41B/54299/SID+27      Oscillator 3 Output
  |   $D41C/54300/SID+28      Envelope Generator 3 Output
  |
  +------------------------------------------------------------------------

  +------------------------------------------------------------------------
  |
  |      COMPLEX INTERFACE ADAPTER (CIA) 6526
  |
  +------------------------------------------------------------------------
  |
  |  CIA related topics:
  |
  |   Keyboard Matrix
  |
  |  Register description:
  |
  |  CIA 1:
  |
  |   $DC00/56320/CIA1+0       Data Port A (Keyboard, Joystick, Paddles)
  |   $DC01/56321/CIA1+1       Data Port B (Keyboard, Joystick, Paddles)
  |   $DC02/56322/CIA1+2       Data Direction Register A
  |   $DC03/56323/CIA1+3       Data Direction Register B
  |   $DC04/56324/CIA1+4       Timer A Low-Byte  (Kernal-IRQ, Tape)
  |   $DC05/56325/CIA1+5       Timer A High-Byte (Kernal-IRQ, Tape)
  |   $DC06/56326/CIA1+6       Timer B Low-Byte  (Tape, Serial Port)
  |   $DC07/56327/CIA1+7       Timer B High-Byte (Tape, Serial Port)
  |   $DC08/56328/CIA1+8       Time-of-Day Clock: 1/10 Seconds
  |   $DC09/56329/CIA1+9       Time-of-Day Clock: Seconds
  |   $DC0A/56330/CIA1+10      Time-of-Day Clock: Minutes
  |   $DC0B/56331/CIA1+11      Time-of-Day Clock: Hours + AM/PM Flag
  |   $DC0C/56332/CIA1+12      Synchronous Serial I/O Data Buffer
  |   $DC0D/56333/CIA1+13      Interrupt (IRQ) Control Register
  |   $DC0E/56334/CIA1+14      Control Register A
  |   $DC0F/56335/CIA1+15      Control Register B
  |
  |  CIA 2:
  |
  |   $DD00/56576/CIA2+0       Data Port A (Serial Bus, RS232, VIC Base Mem.)
  |   $DD01/56577/CIA2+1       Data Port B (User Port, RS232)
  |   $DD02/56578/CIA2+2       Data Direction Register A
  |   $DD03/56579/CIA2+3       Data Direction Register B
  |   $DD04/56580/CIA2+4       Timer A Low-Byte  (RS232)
  |   $DD05/56581/CIA2+5       Timer A High-Byte (RS232)
  |   $DD06/56582/CIA2+6       Timer B Low-Byte  (RS232)
  |   $DD07/56583/CIA2+7       Timer B High-Byte (RS232)
  |   $DD08/56584/CIA2+8       Time-of-Day Clock: 1/10 Seconds
  |   $DD09/56585/CIA2+9       Time-of-Day Clock: Seconds
  |   $DD0A/56586/CIA2+10      Time-of-Day Clock: Minutes
  |   $DD0B/56587/CIA2+11      Time-of-Day Clock: Hours + AM/PM Flag
  |   $DD0C/56588/CIA2+12      Synchronous Serial I/O Data Buffer
  |   $DD0D/56589/CIA2+13      Interrupt (NMI) Control Register
  |   $DD0E/56590/CIA2+14      Control Register A
  |   $DD0F/56591/CIA2+15      Control Register B
  |
  +------------------------------------------------------------------------

