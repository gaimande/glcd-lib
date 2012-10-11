
_GLCD_INIT:

;glcd_pic.h,158 :: 		void GLCD_INIT()
;glcd_pic.h,160 :: 		GLCD_DataDir = 0x00;
	CLRF        TRISB+0 
;glcd_pic.h,161 :: 		GLCD_CS1_Direction = 0;
	BCF         TRISE2_bit+0, 2 
;glcd_pic.h,162 :: 		GLCD_CS2_Direction = 0;
	BCF         TRISE1_bit+0, 1 
;glcd_pic.h,163 :: 		GLCD_RS_Direction = 0;
	BCF         TRISD5_bit+0, 5 
;glcd_pic.h,164 :: 		GLCD_RW_Direction = 0;
	BCF         TRISD6_bit+0, 6 
;glcd_pic.h,165 :: 		GLCD_EN_Direction = 0;
	BCF         TRISD7_bit+0, 7 
;glcd_pic.h,166 :: 		GLCD_RST_Direction = 0;
	BCF         TRISE0_bit+0, 0 
;glcd_pic.h,169 :: 		GLCD_RST = 1;
	BSF         RE0_bit+0, 0 
;glcd_pic.h,170 :: 		GLCD_CS1 = 1;
	BSF         RE2_bit+0, 2 
;glcd_pic.h,171 :: 		GLCD_CS2 = 1;
	BSF         RE1_bit+0, 1 
;glcd_pic.h,173 :: 		GLCD_RW = 0;        //Clear RW  /  Command mode
	BCF         RD6_bit+0, 6 
;glcd_pic.h,175 :: 		delayTime(10000);
	MOVLW       16
	MOVWF       FARG_delayTime_counter+0 
	MOVLW       39
	MOVWF       FARG_delayTime_counter+1 
	MOVLW       0
	MOVWF       FARG_delayTime_counter+2 
	MOVWF       FARG_delayTime_counter+3 
	CALL        _delayTime+0, 0
;glcd_pic.h,176 :: 		GLCD_OUT_CMD(0b11000000);
	MOVLW       192
	MOVWF       FARG_GLCD_OUT_CMD_glcd_cmd+0 
	CALL        _GLCD_OUT_CMD+0, 0
;glcd_pic.h,179 :: 		delayTime(10000);
	MOVLW       16
	MOVWF       FARG_delayTime_counter+0 
	MOVLW       39
	MOVWF       FARG_delayTime_counter+1 
	MOVLW       0
	MOVWF       FARG_delayTime_counter+2 
	MOVWF       FARG_delayTime_counter+3 
	CALL        _delayTime+0, 0
;glcd_pic.h,180 :: 		GLCD_OUT_CMD(0b01000000);
	MOVLW       64
	MOVWF       FARG_GLCD_OUT_CMD_glcd_cmd+0 
	CALL        _GLCD_OUT_CMD+0, 0
;glcd_pic.h,182 :: 		delayTime(10000);
	MOVLW       16
	MOVWF       FARG_delayTime_counter+0 
	MOVLW       39
	MOVWF       FARG_delayTime_counter+1 
	MOVLW       0
	MOVWF       FARG_delayTime_counter+2 
	MOVWF       FARG_delayTime_counter+3 
	CALL        _delayTime+0, 0
;glcd_pic.h,183 :: 		GLCD_OUT_CMD(0b10111000);
	MOVLW       184
	MOVWF       FARG_GLCD_OUT_CMD_glcd_cmd+0 
	CALL        _GLCD_OUT_CMD+0, 0
;glcd_pic.h,185 :: 		delayTime(10000);
	MOVLW       16
	MOVWF       FARG_delayTime_counter+0 
	MOVLW       39
	MOVWF       FARG_delayTime_counter+1 
	MOVLW       0
	MOVWF       FARG_delayTime_counter+2 
	MOVWF       FARG_delayTime_counter+3 
	CALL        _delayTime+0, 0
;glcd_pic.h,186 :: 		GLCD_OUT_CMD(0b00111111);
	MOVLW       63
	MOVWF       FARG_GLCD_OUT_CMD_glcd_cmd+0 
	CALL        _GLCD_OUT_CMD+0, 0
;glcd_pic.h,188 :: 		GLCD_CS1 = 0;        //Disable the CS1 of display
	BCF         RE2_bit+0, 2 
;glcd_pic.h,189 :: 		GLCD_CS2 = 0;        //Disable the CS2 of display
	BCF         RE1_bit+0, 1 
;glcd_pic.h,190 :: 		}
	RETURN      0
; end of _GLCD_INIT

_GLCD_DISPLAY:

;glcd_pic.h,192 :: 		void GLCD_DISPLAY()
;glcd_pic.h,194 :: 		for(glcd_address = 0; glcd_address < 1024; glcd_address++)
	CLRF        _glcd_address+0 
	CLRF        _glcd_address+1 
L_GLCD_DISPLAY0:
	MOVLW       4
	SUBWF       _glcd_address+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DISPLAY158
	MOVLW       0
	SUBWF       _glcd_address+0, 0 
L__GLCD_DISPLAY158:
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DISPLAY1
;glcd_pic.h,196 :: 		if(glcd_column == 128)
	MOVF        _glcd_column+0, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_GLCD_DISPLAY3
;glcd_pic.h,198 :: 		glcd_column = 0;
	CLRF        _glcd_column+0 
;glcd_pic.h,199 :: 		glcd_line++;
	INCF        _glcd_line+0, 1 
;glcd_pic.h,203 :: 		GLCD_CS1 = 1;        //Enable the CS1 of the display
	BSF         RE2_bit+0, 2 
;glcd_pic.h,204 :: 		GLCD_CS2 = 1; //Enable the CS2 of the display
	BSF         RE1_bit+0, 1 
;glcd_pic.h,206 :: 		glcd_line &= 0x07;
	MOVLW       7
	ANDWF       _glcd_line+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _glcd_line+0 
;glcd_pic.h,207 :: 		glcd_line |= 0xB8;
	MOVLW       184
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _glcd_line+0 
;glcd_pic.h,209 :: 		GLCD_OUT_CMD(glcd_line);
	MOVF        R0, 0 
	MOVWF       FARG_GLCD_OUT_CMD_glcd_cmd+0 
	CALL        _GLCD_OUT_CMD+0, 0
;glcd_pic.h,211 :: 		GLCD_OUT_CMD(0b01000000);
	MOVLW       64
	MOVWF       FARG_GLCD_OUT_CMD_glcd_cmd+0 
	CALL        _GLCD_OUT_CMD+0, 0
;glcd_pic.h,212 :: 		}
L_GLCD_DISPLAY3:
;glcd_pic.h,214 :: 		if(glcd_column <= 63)
	MOVF        _glcd_column+0, 0 
	SUBLW       63
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DISPLAY4
;glcd_pic.h,215 :: 		GLCD_CS1_ENABLE();
	CALL        _GLCD_CS1_ENABLE+0, 0
L_GLCD_DISPLAY4:
;glcd_pic.h,217 :: 		if(glcd_column >= 64)
	MOVLW       64
	SUBWF       _glcd_column+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DISPLAY5
;glcd_pic.h,218 :: 		GLCD_CS2_ENABLE();
	CALL        _GLCD_CS2_ENABLE+0, 0
L_GLCD_DISPLAY5:
;glcd_pic.h,220 :: 		GLCD_OUT_DATA(glcd_buff[glcd_address]);
	MOVLW       _glcd_buff+0
	ADDWF       _glcd_address+0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_glcd_buff+0)
	ADDWFC      _glcd_address+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_GLCD_OUT_DATA_glcd_data+0 
	CALL        _GLCD_OUT_DATA+0, 0
;glcd_pic.h,222 :: 		glcd_column++;
	INCF        _glcd_column+0, 1 
;glcd_pic.h,194 :: 		for(glcd_address = 0; glcd_address < 1024; glcd_address++)
	INFSNZ      _glcd_address+0, 1 
	INCF        _glcd_address+1, 1 
;glcd_pic.h,223 :: 		}
	GOTO        L_GLCD_DISPLAY0
L_GLCD_DISPLAY1:
;glcd_pic.h,224 :: 		}
	RETURN      0
; end of _GLCD_DISPLAY

_GLCD_CS1_ENABLE:

;glcd_pic.h,226 :: 		void GLCD_CS1_ENABLE()
;glcd_pic.h,228 :: 		GLCD_CS1 = 1; //Enable the CS1 of the display
	BSF         RE2_bit+0, 2 
;glcd_pic.h,229 :: 		GLCD_CS2 = 0; //Disable the CS2 of the display
	BCF         RE1_bit+0, 1 
;glcd_pic.h,230 :: 		}
	RETURN      0
; end of _GLCD_CS1_ENABLE

_GLCD_CS2_ENABLE:

;glcd_pic.h,232 :: 		void GLCD_CS2_ENABLE()
;glcd_pic.h,234 :: 		GLCD_CS1 = 0; //Enable the CS2 of the display
	BCF         RE2_bit+0, 2 
;glcd_pic.h,235 :: 		GLCD_CS2 = 1; //Disable the CS1 of the display
	BSF         RE1_bit+0, 1 
;glcd_pic.h,236 :: 		}
	RETURN      0
; end of _GLCD_CS2_ENABLE

_GLCD_WAIT:

;glcd_pic.h,238 :: 		void GLCD_WAIT()
;glcd_pic.h,242 :: 		GLCD_DataDir = 0xFF;                        //Make portB all inputs
	MOVLW       255
	MOVWF       TRISB+0 
;glcd_pic.h,244 :: 		GLCD_RW = 1;        //Set r/w pin to read
	BSF         RD6_bit+0, 6 
;glcd_pic.h,245 :: 		GLCD_RS = 0;        //Set register select to command
	BCF         RD5_bit+0, 5 
;glcd_pic.h,247 :: 		do
L_GLCD_WAIT6:
;glcd_pic.h,249 :: 		GLCD_EN =1;                 //lcd 'E' pin high
	BSF         RD7_bit+0, 7 
;glcd_pic.h,250 :: 		GLCD_EN =1;                 //lcd 'E' pin high
	BSF         RD7_bit+0, 7 
;glcd_pic.h,251 :: 		GLCD_EN =1;                 //lcd 'E' pin high
	BSF         RD7_bit+0, 7 
;glcd_pic.h,252 :: 		GLCD_EN =1;                 //lcd 'E' pin high
	BSF         RD7_bit+0, 7 
;glcd_pic.h,253 :: 		GLCD_EN =0;                 //lcd 'E' pin low
	BCF         RD7_bit+0, 7 
;glcd_pic.h,256 :: 		while (dataIn);        // loop until bit7 of 'dataIn' will be cleared.
	MOVF        PORTB+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_GLCD_WAIT6
;glcd_pic.h,258 :: 		GLCD_DataDir = 0x00;                //Make portB all outputs
	CLRF        TRISB+0 
;glcd_pic.h,260 :: 		GLCD_RW = 0;        //Set r/w pin to write
	BCF         RD6_bit+0, 6 
;glcd_pic.h,261 :: 		}
	RETURN      0
; end of _GLCD_WAIT

_delayTime:

;glcd_pic.h,263 :: 		void delayTime (unsigned long counter)
;glcd_pic.h,265 :: 		while (counter--);
L_delayTime9:
	MOVF        FARG_delayTime_counter+0, 0 
	MOVWF       R0 
	MOVF        FARG_delayTime_counter+1, 0 
	MOVWF       R1 
	MOVF        FARG_delayTime_counter+2, 0 
	MOVWF       R2 
	MOVF        FARG_delayTime_counter+3, 0 
	MOVWF       R3 
	MOVLW       1
	SUBWF       FARG_delayTime_counter+0, 1 
	MOVLW       0
	SUBWFB      FARG_delayTime_counter+1, 1 
	SUBWFB      FARG_delayTime_counter+2, 1 
	SUBWFB      FARG_delayTime_counter+3, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_delayTime10
	GOTO        L_delayTime9
L_delayTime10:
;glcd_pic.h,266 :: 		}
	RETURN      0
; end of _delayTime

_GLCD_OUT_CMD:

;glcd_pic.h,268 :: 		void GLCD_OUT_CMD(unsigned char glcd_cmd)
;glcd_pic.h,270 :: 		GLCD_RS = 0;        //Clear RS. Command mode
	BCF         RD5_bit+0, 5 
;glcd_pic.h,271 :: 		GLCD_EN = 1;        //lcd 'E' pin high
	BSF         RD7_bit+0, 7 
;glcd_pic.h,272 :: 		GLCD_DataPort = glcd_cmd;
	MOVF        FARG_GLCD_OUT_CMD_glcd_cmd+0, 0 
	MOVWF       PORTB+0 
;glcd_pic.h,273 :: 		GLCD_DataPort = glcd_cmd;
	MOVF        FARG_GLCD_OUT_CMD_glcd_cmd+0, 0 
	MOVWF       PORTB+0 
;glcd_pic.h,274 :: 		GLCD_DataPort = glcd_cmd;
	MOVF        FARG_GLCD_OUT_CMD_glcd_cmd+0, 0 
	MOVWF       PORTB+0 
;glcd_pic.h,275 :: 		GLCD_DataPort = glcd_cmd;
	MOVF        FARG_GLCD_OUT_CMD_glcd_cmd+0, 0 
	MOVWF       PORTB+0 
;glcd_pic.h,276 :: 		GLCD_DataPort = glcd_cmd;
	MOVF        FARG_GLCD_OUT_CMD_glcd_cmd+0, 0 
	MOVWF       PORTB+0 
;glcd_pic.h,277 :: 		GLCD_EN = 0;         //lcd 'E' pin low
	BCF         RD7_bit+0, 7 
;glcd_pic.h,278 :: 		}
	RETURN      0
; end of _GLCD_OUT_CMD

_GLCD_OUT_DATA:

;glcd_pic.h,280 :: 		void GLCD_OUT_DATA(unsigned char glcd_data)
;glcd_pic.h,282 :: 		GLCD_RS = 1;
	BSF         RD5_bit+0, 5 
;glcd_pic.h,283 :: 		GLCD_EN = 1;                 //lcd 'E' pin high
	BSF         RD7_bit+0, 7 
;glcd_pic.h,284 :: 		GLCD_DataPort = glcd_data;
	MOVF        FARG_GLCD_OUT_DATA_glcd_data+0, 0 
	MOVWF       PORTB+0 
;glcd_pic.h,285 :: 		GLCD_DataPort = glcd_data;
	MOVF        FARG_GLCD_OUT_DATA_glcd_data+0, 0 
	MOVWF       PORTB+0 
;glcd_pic.h,286 :: 		GLCD_DataPort = glcd_data;
	MOVF        FARG_GLCD_OUT_DATA_glcd_data+0, 0 
	MOVWF       PORTB+0 
;glcd_pic.h,287 :: 		GLCD_DataPort = glcd_data;
	MOVF        FARG_GLCD_OUT_DATA_glcd_data+0, 0 
	MOVWF       PORTB+0 
;glcd_pic.h,288 :: 		GLCD_DataPort = glcd_data;
	MOVF        FARG_GLCD_OUT_DATA_glcd_data+0, 0 
	MOVWF       PORTB+0 
;glcd_pic.h,289 :: 		GLCD_EN = 0;         //lcd 'E' pin low
	BCF         RD7_bit+0, 7 
;glcd_pic.h,290 :: 		}
	RETURN      0
; end of _GLCD_OUT_DATA

_GLCD_POINT_DRW:

;glcd_pic.h,294 :: 		void GLCD_POINT_DRW(unsigned char x, unsigned char y)
;glcd_pic.h,298 :: 		temp = x + ((y >> 3) << 7);
	MOVF        FARG_GLCD_POINT_DRW_y+0, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	BCF         R3, 7 
	MOVLW       7
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__GLCD_POINT_DRW159:
	BZ          L__GLCD_POINT_DRW160
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__GLCD_POINT_DRW159
L__GLCD_POINT_DRW160:
	MOVF        FARG_GLCD_POINT_DRW_x+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
;glcd_pic.h,299 :: 		h_line = (unsigned char)(y & 0x07);
	MOVLW       7
	ANDWF       FARG_GLCD_POINT_DRW_y+0, 0 
	MOVWF       R0 
;glcd_pic.h,300 :: 		glcd_buff[temp] |= (1<<h_line);
	MOVLW       _glcd_buff+0
	ADDWF       R2, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_glcd_buff+0)
	ADDWFC      R3, 0 
	MOVWF       R5 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__GLCD_POINT_DRW161:
	BZ          L__GLCD_POINT_DRW162
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__GLCD_POINT_DRW161
L__GLCD_POINT_DRW162:
	MOVFF       R4, FSR0L
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	IORWF       R0, 1 
	MOVFF       R4, FSR1L
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;glcd_pic.h,301 :: 		}
	RETURN      0
; end of _GLCD_POINT_DRW

_GLCD_POINT_CLR:

;glcd_pic.h,303 :: 		void GLCD_POINT_CLR(unsigned char x, unsigned char y)
;glcd_pic.h,307 :: 		temp = x + ((y >> 3) << 7);
	MOVF        FARG_GLCD_POINT_CLR_y+0, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	BCF         R3, 7 
	MOVLW       7
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__GLCD_POINT_CLR163:
	BZ          L__GLCD_POINT_CLR164
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__GLCD_POINT_CLR163
L__GLCD_POINT_CLR164:
	MOVF        FARG_GLCD_POINT_CLR_x+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
;glcd_pic.h,308 :: 		h_line = (unsigned char)(y & 0x07);
	MOVLW       7
	ANDWF       FARG_GLCD_POINT_CLR_y+0, 0 
	MOVWF       R0 
;glcd_pic.h,309 :: 		glcd_buff[temp] &= ~(1<<h_line);
	MOVLW       _glcd_buff+0
	ADDWF       R2, 0 
	MOVWF       R4 
	MOVLW       hi_addr(_glcd_buff+0)
	ADDWFC      R3, 0 
	MOVWF       R5 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__GLCD_POINT_CLR165:
	BZ          L__GLCD_POINT_CLR166
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__GLCD_POINT_CLR165
L__GLCD_POINT_CLR166:
	COMF        R0, 1 
	MOVFF       R4, FSR0L
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	ANDWF       R0, 1 
	MOVFF       R4, FSR1L
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;glcd_pic.h,310 :: 		}
	RETURN      0
; end of _GLCD_POINT_CLR

_GLCD_DRW_REC_EMPTY:

;glcd_pic.h,312 :: 		void GLCD_DRW_REC_EMPTY(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char black_white)
;glcd_pic.h,315 :: 		if(x1 > x2)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x1+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_EMPTY_x2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_EMPTY11
;glcd_pic.h,317 :: 		glcd_temp = x1;
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x1+0, 0 
	MOVWF       GLCD_DRW_REC_EMPTY_glcd_temp_L0+0 
;glcd_pic.h,318 :: 		x1 = x2;
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x2+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_EMPTY_x1+0 
;glcd_pic.h,319 :: 		x2 = glcd_temp;
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_EMPTY_x2+0 
;glcd_pic.h,320 :: 		}
L_GLCD_DRW_REC_EMPTY11:
;glcd_pic.h,321 :: 		if(y1 > y2)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y1+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_EMPTY_y2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_EMPTY12
;glcd_pic.h,323 :: 		glcd_temp = y1;
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y1+0, 0 
	MOVWF       GLCD_DRW_REC_EMPTY_glcd_temp_L0+0 
;glcd_pic.h,324 :: 		y1 = y2;
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y2+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_EMPTY_y1+0 
;glcd_pic.h,325 :: 		y2 = glcd_temp;
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_EMPTY_y2+0 
;glcd_pic.h,326 :: 		}
L_GLCD_DRW_REC_EMPTY12:
;glcd_pic.h,327 :: 		if(black_white)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_REC_EMPTY13
;glcd_pic.h,329 :: 		for(glcd_temp=x1;glcd_temp<=x2;glcd_temp++)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x1+0, 0 
	MOVWF       GLCD_DRW_REC_EMPTY_glcd_temp_L0+0 
L_GLCD_DRW_REC_EMPTY14:
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_EMPTY_x2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_EMPTY15
;glcd_pic.h,331 :: 		GLCD_POINT_DRW(glcd_temp,y1);
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y1+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_pic.h,332 :: 		GLCD_POINT_DRW(glcd_temp,y2);
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y2+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_pic.h,329 :: 		for(glcd_temp=x1;glcd_temp<=x2;glcd_temp++)
	INCF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 1 
;glcd_pic.h,333 :: 		}
	GOTO        L_GLCD_DRW_REC_EMPTY14
L_GLCD_DRW_REC_EMPTY15:
;glcd_pic.h,334 :: 		for(glcd_temp=y1;glcd_temp<=y2;glcd_temp++)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y1+0, 0 
	MOVWF       GLCD_DRW_REC_EMPTY_glcd_temp_L0+0 
L_GLCD_DRW_REC_EMPTY17:
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_EMPTY_y2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_EMPTY18
;glcd_pic.h,336 :: 		GLCD_POINT_DRW(x1,glcd_temp);
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x1+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_pic.h,337 :: 		GLCD_POINT_DRW(x2,glcd_temp);
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x2+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_pic.h,334 :: 		for(glcd_temp=y1;glcd_temp<=y2;glcd_temp++)
	INCF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 1 
;glcd_pic.h,338 :: 		}
	GOTO        L_GLCD_DRW_REC_EMPTY17
L_GLCD_DRW_REC_EMPTY18:
;glcd_pic.h,339 :: 		}
	GOTO        L_GLCD_DRW_REC_EMPTY20
L_GLCD_DRW_REC_EMPTY13:
;glcd_pic.h,342 :: 		for(glcd_temp=x1;glcd_temp<=x2;glcd_temp++)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x1+0, 0 
	MOVWF       GLCD_DRW_REC_EMPTY_glcd_temp_L0+0 
L_GLCD_DRW_REC_EMPTY21:
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_EMPTY_x2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_EMPTY22
;glcd_pic.h,344 :: 		GLCD_POINT_CLR(glcd_temp,y1);
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y1+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_pic.h,345 :: 		GLCD_POINT_CLR(glcd_temp,y2);
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y2+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_pic.h,342 :: 		for(glcd_temp=x1;glcd_temp<=x2;glcd_temp++)
	INCF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 1 
;glcd_pic.h,346 :: 		}
	GOTO        L_GLCD_DRW_REC_EMPTY21
L_GLCD_DRW_REC_EMPTY22:
;glcd_pic.h,347 :: 		for(glcd_temp=y1;glcd_temp<=y2;glcd_temp++)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y1+0, 0 
	MOVWF       GLCD_DRW_REC_EMPTY_glcd_temp_L0+0 
L_GLCD_DRW_REC_EMPTY24:
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_EMPTY_y2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_EMPTY25
;glcd_pic.h,349 :: 		GLCD_POINT_CLR(x1,glcd_temp);
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x1+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_pic.h,350 :: 		GLCD_POINT_CLR(x2,glcd_temp);
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x2+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_pic.h,347 :: 		for(glcd_temp=y1;glcd_temp<=y2;glcd_temp++)
	INCF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 1 
;glcd_pic.h,351 :: 		}
	GOTO        L_GLCD_DRW_REC_EMPTY24
L_GLCD_DRW_REC_EMPTY25:
;glcd_pic.h,352 :: 		}
L_GLCD_DRW_REC_EMPTY20:
;glcd_pic.h,353 :: 		}
	RETURN      0
; end of _GLCD_DRW_REC_EMPTY

_GLCD_DRW_REC_SOLID:

;glcd_pic.h,355 :: 		void GLCD_DRW_REC_SOLID(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char black_white)
;glcd_pic.h,359 :: 		if(x1 > x2)
	MOVF        FARG_GLCD_DRW_REC_SOLID_x1+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_SOLID_x2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_SOLID27
;glcd_pic.h,361 :: 		glcd_temp = x1;
	MOVF        FARG_GLCD_DRW_REC_SOLID_x1+0, 0 
	MOVWF       GLCD_DRW_REC_SOLID_glcd_temp_L0+0 
;glcd_pic.h,362 :: 		x1 = x2;
	MOVF        FARG_GLCD_DRW_REC_SOLID_x2+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_SOLID_x1+0 
;glcd_pic.h,363 :: 		x2 = glcd_temp;
	MOVF        GLCD_DRW_REC_SOLID_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_SOLID_x2+0 
;glcd_pic.h,364 :: 		}
L_GLCD_DRW_REC_SOLID27:
;glcd_pic.h,365 :: 		if(y1 > y2)
	MOVF        FARG_GLCD_DRW_REC_SOLID_y1+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_SOLID_y2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_SOLID28
;glcd_pic.h,367 :: 		glcd_temp = y1;
	MOVF        FARG_GLCD_DRW_REC_SOLID_y1+0, 0 
	MOVWF       GLCD_DRW_REC_SOLID_glcd_temp_L0+0 
;glcd_pic.h,368 :: 		y1 = y2;
	MOVF        FARG_GLCD_DRW_REC_SOLID_y2+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_SOLID_y1+0 
;glcd_pic.h,369 :: 		y2 = glcd_temp;
	MOVF        GLCD_DRW_REC_SOLID_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_SOLID_y2+0 
;glcd_pic.h,370 :: 		}
L_GLCD_DRW_REC_SOLID28:
;glcd_pic.h,371 :: 		for(i=x1;i<=x2;i++)
	MOVF        FARG_GLCD_DRW_REC_SOLID_x1+0, 0 
	MOVWF       GLCD_DRW_REC_SOLID_i_L0+0 
L_GLCD_DRW_REC_SOLID29:
	MOVF        GLCD_DRW_REC_SOLID_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_SOLID_x2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_SOLID30
;glcd_pic.h,372 :: 		for(j=y1;j<=y2;j++)
	MOVF        FARG_GLCD_DRW_REC_SOLID_y1+0, 0 
	MOVWF       GLCD_DRW_REC_SOLID_j_L0+0 
L_GLCD_DRW_REC_SOLID32:
	MOVF        GLCD_DRW_REC_SOLID_j_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_SOLID_y2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_SOLID33
;glcd_pic.h,374 :: 		if(black_white)
	MOVF        FARG_GLCD_DRW_REC_SOLID_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_REC_SOLID35
;glcd_pic.h,375 :: 		GLCD_POINT_DRW(i,j);
	MOVF        GLCD_DRW_REC_SOLID_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_REC_SOLID_j_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
	GOTO        L_GLCD_DRW_REC_SOLID36
L_GLCD_DRW_REC_SOLID35:
;glcd_pic.h,377 :: 		GLCD_POINT_CLR(i,j);
	MOVF        GLCD_DRW_REC_SOLID_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_REC_SOLID_j_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
L_GLCD_DRW_REC_SOLID36:
;glcd_pic.h,372 :: 		for(j=y1;j<=y2;j++)
	INCF        GLCD_DRW_REC_SOLID_j_L0+0, 1 
;glcd_pic.h,378 :: 		}
	GOTO        L_GLCD_DRW_REC_SOLID32
L_GLCD_DRW_REC_SOLID33:
;glcd_pic.h,371 :: 		for(i=x1;i<=x2;i++)
	INCF        GLCD_DRW_REC_SOLID_i_L0+0, 1 
;glcd_pic.h,378 :: 		}
	GOTO        L_GLCD_DRW_REC_SOLID29
L_GLCD_DRW_REC_SOLID30:
;glcd_pic.h,379 :: 		}
	RETURN      0
; end of _GLCD_DRW_REC_SOLID

_GLCD_DRW_LINE:

;glcd_pic.h,381 :: 		void GLCD_DRW_LINE(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char black_white)
;glcd_pic.h,386 :: 		if(x2 == x1)
	MOVF        FARG_GLCD_DRW_LINE_x2+0, 0 
	XORWF       FARG_GLCD_DRW_LINE_x1+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_GLCD_DRW_LINE37
;glcd_pic.h,388 :: 		if(y2 >= y1)
	MOVF        FARG_GLCD_DRW_LINE_y1+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_y2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_LINE38
;glcd_pic.h,389 :: 		for(i=y1;i<=y2;i++)
	MOVF        FARG_GLCD_DRW_LINE_y1+0, 0 
	MOVWF       GLCD_DRW_LINE_i_L0+0 
L_GLCD_DRW_LINE39:
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_y2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_LINE40
;glcd_pic.h,390 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_LINE_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_LINE42
;glcd_pic.h,391 :: 		GLCD_POINT_DRW(x1,i);
	MOVF        FARG_GLCD_DRW_LINE_x1+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
	GOTO        L_GLCD_DRW_LINE43
L_GLCD_DRW_LINE42:
;glcd_pic.h,393 :: 		GLCD_POINT_CLR(x1,i);
	MOVF        FARG_GLCD_DRW_LINE_x1+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
L_GLCD_DRW_LINE43:
;glcd_pic.h,389 :: 		for(i=y1;i<=y2;i++)
	INCF        GLCD_DRW_LINE_i_L0+0, 1 
;glcd_pic.h,393 :: 		GLCD_POINT_CLR(x1,i);
	GOTO        L_GLCD_DRW_LINE39
L_GLCD_DRW_LINE40:
	GOTO        L_GLCD_DRW_LINE44
L_GLCD_DRW_LINE38:
;glcd_pic.h,395 :: 		for(i=y2;i<=y1;i++)
	MOVF        FARG_GLCD_DRW_LINE_y2+0, 0 
	MOVWF       GLCD_DRW_LINE_i_L0+0 
L_GLCD_DRW_LINE45:
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_y1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_LINE46
;glcd_pic.h,396 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_LINE_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_LINE48
;glcd_pic.h,397 :: 		GLCD_POINT_DRW(x1,i);
	MOVF        FARG_GLCD_DRW_LINE_x1+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
	GOTO        L_GLCD_DRW_LINE49
L_GLCD_DRW_LINE48:
;glcd_pic.h,399 :: 		GLCD_POINT_CLR(x1,i);
	MOVF        FARG_GLCD_DRW_LINE_x1+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
L_GLCD_DRW_LINE49:
;glcd_pic.h,395 :: 		for(i=y2;i<=y1;i++)
	INCF        GLCD_DRW_LINE_i_L0+0, 1 
;glcd_pic.h,399 :: 		GLCD_POINT_CLR(x1,i);
	GOTO        L_GLCD_DRW_LINE45
L_GLCD_DRW_LINE46:
L_GLCD_DRW_LINE44:
;glcd_pic.h,400 :: 		}
	GOTO        L_GLCD_DRW_LINE50
L_GLCD_DRW_LINE37:
;glcd_pic.h,403 :: 		a = (float)(y2 - y1) / (float)(x2 - x1);
	MOVF        FARG_GLCD_DRW_LINE_y1+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_y2+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__GLCD_DRW_LINE+0 
	MOVF        R1, 0 
	MOVWF       FLOC__GLCD_DRW_LINE+1 
	MOVF        R2, 0 
	MOVWF       FLOC__GLCD_DRW_LINE+2 
	MOVF        R3, 0 
	MOVWF       FLOC__GLCD_DRW_LINE+3 
	MOVF        FARG_GLCD_DRW_LINE_x1+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_x2+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	CALL        _Int2Double+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVF        FLOC__GLCD_DRW_LINE+0, 0 
	MOVWF       R0 
	MOVF        FLOC__GLCD_DRW_LINE+1, 0 
	MOVWF       R1 
	MOVF        FLOC__GLCD_DRW_LINE+2, 0 
	MOVWF       R2 
	MOVF        FLOC__GLCD_DRW_LINE+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__GLCD_DRW_LINE+0 
	MOVF        R1, 0 
	MOVWF       FLOC__GLCD_DRW_LINE+1 
	MOVF        R2, 0 
	MOVWF       FLOC__GLCD_DRW_LINE+2 
	MOVF        R3, 0 
	MOVWF       FLOC__GLCD_DRW_LINE+3 
	MOVF        FLOC__GLCD_DRW_LINE+0, 0 
	MOVWF       GLCD_DRW_LINE_a_L0+0 
	MOVF        FLOC__GLCD_DRW_LINE+1, 0 
	MOVWF       GLCD_DRW_LINE_a_L0+1 
	MOVF        FLOC__GLCD_DRW_LINE+2, 0 
	MOVWF       GLCD_DRW_LINE_a_L0+2 
	MOVF        FLOC__GLCD_DRW_LINE+3, 0 
	MOVWF       GLCD_DRW_LINE_a_L0+3 
;glcd_pic.h,404 :: 		b = (float)(y2 - a*x2);
	MOVF        FARG_GLCD_DRW_LINE_x2+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        FLOC__GLCD_DRW_LINE+0, 0 
	MOVWF       R4 
	MOVF        FLOC__GLCD_DRW_LINE+1, 0 
	MOVWF       R5 
	MOVF        FLOC__GLCD_DRW_LINE+2, 0 
	MOVWF       R6 
	MOVF        FLOC__GLCD_DRW_LINE+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__GLCD_DRW_LINE+0 
	MOVF        R1, 0 
	MOVWF       FLOC__GLCD_DRW_LINE+1 
	MOVF        R2, 0 
	MOVWF       FLOC__GLCD_DRW_LINE+2 
	MOVF        R3, 0 
	MOVWF       FLOC__GLCD_DRW_LINE+3 
	MOVF        FARG_GLCD_DRW_LINE_y2+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        FLOC__GLCD_DRW_LINE+0, 0 
	MOVWF       R4 
	MOVF        FLOC__GLCD_DRW_LINE+1, 0 
	MOVWF       R5 
	MOVF        FLOC__GLCD_DRW_LINE+2, 0 
	MOVWF       R6 
	MOVF        FLOC__GLCD_DRW_LINE+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       GLCD_DRW_LINE_b_L0+0 
	MOVF        R1, 0 
	MOVWF       GLCD_DRW_LINE_b_L0+1 
	MOVF        R2, 0 
	MOVWF       GLCD_DRW_LINE_b_L0+2 
	MOVF        R3, 0 
	MOVWF       GLCD_DRW_LINE_b_L0+3 
;glcd_pic.h,406 :: 		if(x2 > x1)
	MOVF        FARG_GLCD_DRW_LINE_x2+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_x1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_LINE51
;glcd_pic.h,408 :: 		for(i=x1;i<=x2;i++)
	MOVF        FARG_GLCD_DRW_LINE_x1+0, 0 
	MOVWF       GLCD_DRW_LINE_i_L0+0 
L_GLCD_DRW_LINE52:
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_x2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_LINE53
;glcd_pic.h,409 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_LINE_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_LINE55
;glcd_pic.h,410 :: 		GLCD_POINT_DRW(i,(a*i + b));
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        GLCD_DRW_LINE_a_L0+0, 0 
	MOVWF       R4 
	MOVF        GLCD_DRW_LINE_a_L0+1, 0 
	MOVWF       R5 
	MOVF        GLCD_DRW_LINE_a_L0+2, 0 
	MOVWF       R6 
	MOVF        GLCD_DRW_LINE_a_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        GLCD_DRW_LINE_b_L0+0, 0 
	MOVWF       R4 
	MOVF        GLCD_DRW_LINE_b_L0+1, 0 
	MOVWF       R5 
	MOVF        GLCD_DRW_LINE_b_L0+2, 0 
	MOVWF       R6 
	MOVF        GLCD_DRW_LINE_b_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Byte+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
	GOTO        L_GLCD_DRW_LINE56
L_GLCD_DRW_LINE55:
;glcd_pic.h,412 :: 		GLCD_POINT_CLR(i,(a*i + b));
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        GLCD_DRW_LINE_a_L0+0, 0 
	MOVWF       R4 
	MOVF        GLCD_DRW_LINE_a_L0+1, 0 
	MOVWF       R5 
	MOVF        GLCD_DRW_LINE_a_L0+2, 0 
	MOVWF       R6 
	MOVF        GLCD_DRW_LINE_a_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        GLCD_DRW_LINE_b_L0+0, 0 
	MOVWF       R4 
	MOVF        GLCD_DRW_LINE_b_L0+1, 0 
	MOVWF       R5 
	MOVF        GLCD_DRW_LINE_b_L0+2, 0 
	MOVWF       R6 
	MOVF        GLCD_DRW_LINE_b_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Byte+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
L_GLCD_DRW_LINE56:
;glcd_pic.h,408 :: 		for(i=x1;i<=x2;i++)
	INCF        GLCD_DRW_LINE_i_L0+0, 1 
;glcd_pic.h,412 :: 		GLCD_POINT_CLR(i,(a*i + b));
	GOTO        L_GLCD_DRW_LINE52
L_GLCD_DRW_LINE53:
;glcd_pic.h,413 :: 		}
	GOTO        L_GLCD_DRW_LINE57
L_GLCD_DRW_LINE51:
;glcd_pic.h,416 :: 		for(i=x2;i<=x1;i++)
	MOVF        FARG_GLCD_DRW_LINE_x2+0, 0 
	MOVWF       GLCD_DRW_LINE_i_L0+0 
L_GLCD_DRW_LINE58:
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_x1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_LINE59
;glcd_pic.h,417 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_LINE_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_LINE61
;glcd_pic.h,418 :: 		GLCD_POINT_DRW(i,(a*i + b));
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        GLCD_DRW_LINE_a_L0+0, 0 
	MOVWF       R4 
	MOVF        GLCD_DRW_LINE_a_L0+1, 0 
	MOVWF       R5 
	MOVF        GLCD_DRW_LINE_a_L0+2, 0 
	MOVWF       R6 
	MOVF        GLCD_DRW_LINE_a_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        GLCD_DRW_LINE_b_L0+0, 0 
	MOVWF       R4 
	MOVF        GLCD_DRW_LINE_b_L0+1, 0 
	MOVWF       R5 
	MOVF        GLCD_DRW_LINE_b_L0+2, 0 
	MOVWF       R6 
	MOVF        GLCD_DRW_LINE_b_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Byte+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
	GOTO        L_GLCD_DRW_LINE62
L_GLCD_DRW_LINE61:
;glcd_pic.h,420 :: 		GLCD_POINT_CLR(i,(a*i + b));
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        GLCD_DRW_LINE_a_L0+0, 0 
	MOVWF       R4 
	MOVF        GLCD_DRW_LINE_a_L0+1, 0 
	MOVWF       R5 
	MOVF        GLCD_DRW_LINE_a_L0+2, 0 
	MOVWF       R6 
	MOVF        GLCD_DRW_LINE_a_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        GLCD_DRW_LINE_b_L0+0, 0 
	MOVWF       R4 
	MOVF        GLCD_DRW_LINE_b_L0+1, 0 
	MOVWF       R5 
	MOVF        GLCD_DRW_LINE_b_L0+2, 0 
	MOVWF       R6 
	MOVF        GLCD_DRW_LINE_b_L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Byte+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
L_GLCD_DRW_LINE62:
;glcd_pic.h,416 :: 		for(i=x2;i<=x1;i++)
	INCF        GLCD_DRW_LINE_i_L0+0, 1 
;glcd_pic.h,420 :: 		GLCD_POINT_CLR(i,(a*i + b));
	GOTO        L_GLCD_DRW_LINE58
L_GLCD_DRW_LINE59:
;glcd_pic.h,421 :: 		}
L_GLCD_DRW_LINE57:
;glcd_pic.h,422 :: 		}
L_GLCD_DRW_LINE50:
;glcd_pic.h,423 :: 		}
	RETURN      0
; end of _GLCD_DRW_LINE

_GLCD_DRW_VECTOR:

;glcd_pic.h,425 :: 		void GLCD_DRW_VECTOR(unsigned char x1, unsigned char y1, unsigned int angle, unsigned char length, unsigned char black_white)
;glcd_pic.h,431 :: 		if(angle == 0)
	MOVLW       0
	XORWF       FARG_GLCD_DRW_VECTOR_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR167
	MOVLW       0
	XORWF       FARG_GLCD_DRW_VECTOR_angle+0, 0 
L__GLCD_DRW_VECTOR167:
	BTFSS       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR63
;glcd_pic.h,433 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_VECTOR_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR64
;glcd_pic.h,434 :: 		GLCD_DRW_LINE(x1,y1,x1,y1-length,1);
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x2+0 
	MOVF        FARG_GLCD_DRW_VECTOR_length+0, 0 
	SUBWF       FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y2+0 
	MOVLW       1
	MOVWF       FARG_GLCD_DRW_LINE_black_white+0 
	CALL        _GLCD_DRW_LINE+0, 0
	GOTO        L_GLCD_DRW_VECTOR65
L_GLCD_DRW_VECTOR64:
;glcd_pic.h,436 :: 		GLCD_DRW_LINE(x1,y1,x1,y1-length,0);
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x2+0 
	MOVF        FARG_GLCD_DRW_VECTOR_length+0, 0 
	SUBWF       FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y2+0 
	CLRF        FARG_GLCD_DRW_LINE_black_white+0 
	CALL        _GLCD_DRW_LINE+0, 0
L_GLCD_DRW_VECTOR65:
;glcd_pic.h,437 :: 		}
	GOTO        L_GLCD_DRW_VECTOR66
L_GLCD_DRW_VECTOR63:
;glcd_pic.h,438 :: 		else if(angle == 90)
	MOVLW       0
	XORWF       FARG_GLCD_DRW_VECTOR_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR168
	MOVLW       90
	XORWF       FARG_GLCD_DRW_VECTOR_angle+0, 0 
L__GLCD_DRW_VECTOR168:
	BTFSS       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR67
;glcd_pic.h,440 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_VECTOR_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR68
;glcd_pic.h,441 :: 		GLCD_DRW_LINE(x1,y1,x1+length,y1,1);
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_length+0, 0 
	ADDWF       FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x2+0 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y2+0 
	MOVLW       1
	MOVWF       FARG_GLCD_DRW_LINE_black_white+0 
	CALL        _GLCD_DRW_LINE+0, 0
	GOTO        L_GLCD_DRW_VECTOR69
L_GLCD_DRW_VECTOR68:
;glcd_pic.h,443 :: 		GLCD_DRW_LINE(x1,y1,x1+length,y1,0);
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_length+0, 0 
	ADDWF       FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x2+0 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y2+0 
	CLRF        FARG_GLCD_DRW_LINE_black_white+0 
	CALL        _GLCD_DRW_LINE+0, 0
L_GLCD_DRW_VECTOR69:
;glcd_pic.h,444 :: 		}
	GOTO        L_GLCD_DRW_VECTOR70
L_GLCD_DRW_VECTOR67:
;glcd_pic.h,445 :: 		else if(angle == 180)
	MOVLW       0
	XORWF       FARG_GLCD_DRW_VECTOR_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR169
	MOVLW       180
	XORWF       FARG_GLCD_DRW_VECTOR_angle+0, 0 
L__GLCD_DRW_VECTOR169:
	BTFSS       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR71
;glcd_pic.h,447 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_VECTOR_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR72
;glcd_pic.h,448 :: 		GLCD_DRW_LINE(x1,y1,x1,y1+length,1);
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x2+0 
	MOVF        FARG_GLCD_DRW_VECTOR_length+0, 0 
	ADDWF       FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y2+0 
	MOVLW       1
	MOVWF       FARG_GLCD_DRW_LINE_black_white+0 
	CALL        _GLCD_DRW_LINE+0, 0
	GOTO        L_GLCD_DRW_VECTOR73
L_GLCD_DRW_VECTOR72:
;glcd_pic.h,450 :: 		GLCD_DRW_LINE(x1,y1,x1,y1+length,0);
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x2+0 
	MOVF        FARG_GLCD_DRW_VECTOR_length+0, 0 
	ADDWF       FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y2+0 
	CLRF        FARG_GLCD_DRW_LINE_black_white+0 
	CALL        _GLCD_DRW_LINE+0, 0
L_GLCD_DRW_VECTOR73:
;glcd_pic.h,451 :: 		}
	GOTO        L_GLCD_DRW_VECTOR74
L_GLCD_DRW_VECTOR71:
;glcd_pic.h,452 :: 		else if(angle == 270)
	MOVF        FARG_GLCD_DRW_VECTOR_angle+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR170
	MOVLW       14
	XORWF       FARG_GLCD_DRW_VECTOR_angle+0, 0 
L__GLCD_DRW_VECTOR170:
	BTFSS       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR75
;glcd_pic.h,454 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_VECTOR_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR76
;glcd_pic.h,455 :: 		GLCD_DRW_LINE(x1,y1,x1-length,y1,1);
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_length+0, 0 
	SUBWF       FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x2+0 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y2+0 
	MOVLW       1
	MOVWF       FARG_GLCD_DRW_LINE_black_white+0 
	CALL        _GLCD_DRW_LINE+0, 0
	GOTO        L_GLCD_DRW_VECTOR77
L_GLCD_DRW_VECTOR76:
;glcd_pic.h,457 :: 		GLCD_DRW_LINE(x1,y1,x1-length,y1,0);
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y1+0 
	MOVF        FARG_GLCD_DRW_VECTOR_length+0, 0 
	SUBWF       FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_x2+0 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       FARG_GLCD_DRW_LINE_y2+0 
	CLRF        FARG_GLCD_DRW_LINE_black_white+0 
	CALL        _GLCD_DRW_LINE+0, 0
L_GLCD_DRW_VECTOR77:
;glcd_pic.h,458 :: 		}
	GOTO        L_GLCD_DRW_VECTOR78
L_GLCD_DRW_VECTOR75:
;glcd_pic.h,461 :: 		if(angle < 180)
	MOVLW       0
	SUBWF       FARG_GLCD_DRW_VECTOR_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR171
	MOVLW       180
	SUBWF       FARG_GLCD_DRW_VECTOR_angle+0, 0 
L__GLCD_DRW_VECTOR171:
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_VECTOR79
;glcd_pic.h,462 :: 		goc = ((double)(angle*M_PI)/180);
	MOVF        FARG_GLCD_DRW_VECTOR_angle+0, 0 
	MOVWF       R0 
	MOVF        FARG_GLCD_DRW_VECTOR_angle+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVLW       195
	MOVWF       R4 
	MOVLW       245
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       52
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       GLCD_DRW_VECTOR_goc_L0+0 
	MOVF        R1, 0 
	MOVWF       GLCD_DRW_VECTOR_goc_L0+1 
	MOVF        R2, 0 
	MOVWF       GLCD_DRW_VECTOR_goc_L0+2 
	MOVF        R3, 0 
	MOVWF       GLCD_DRW_VECTOR_goc_L0+3 
	GOTO        L_GLCD_DRW_VECTOR80
L_GLCD_DRW_VECTOR79:
;glcd_pic.h,464 :: 		goc = ((double)((360 - angle)*M_PI)/180);
	MOVF        FARG_GLCD_DRW_VECTOR_angle+0, 0 
	SUBLW       104
	MOVWF       R0 
	MOVF        FARG_GLCD_DRW_VECTOR_angle+1, 0 
	MOVWF       R1 
	MOVLW       1
	SUBFWB      R1, 1 
	CALL        _Word2Double+0, 0
	MOVLW       195
	MOVWF       R4 
	MOVLW       245
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       52
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       GLCD_DRW_VECTOR_goc_L0+0 
	MOVF        R1, 0 
	MOVWF       GLCD_DRW_VECTOR_goc_L0+1 
	MOVF        R2, 0 
	MOVWF       GLCD_DRW_VECTOR_goc_L0+2 
	MOVF        R3, 0 
	MOVWF       GLCD_DRW_VECTOR_goc_L0+3 
L_GLCD_DRW_VECTOR80:
;glcd_pic.h,466 :: 		x_max = (char)(length*sin(goc));
	MOVF        GLCD_DRW_VECTOR_goc_L0+0, 0 
	MOVWF       FARG_sin_f+0 
	MOVF        GLCD_DRW_VECTOR_goc_L0+1, 0 
	MOVWF       FARG_sin_f+1 
	MOVF        GLCD_DRW_VECTOR_goc_L0+2, 0 
	MOVWF       FARG_sin_f+2 
	MOVF        GLCD_DRW_VECTOR_goc_L0+3, 0 
	MOVWF       FARG_sin_f+3 
	CALL        _sin+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+0 
	MOVF        R1, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+1 
	MOVF        R2, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+2 
	MOVF        R3, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+3 
	MOVF        FARG_GLCD_DRW_VECTOR_length+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        FLOC__GLCD_DRW_VECTOR+0, 0 
	MOVWF       R4 
	MOVF        FLOC__GLCD_DRW_VECTOR+1, 0 
	MOVWF       R5 
	MOVF        FLOC__GLCD_DRW_VECTOR+2, 0 
	MOVWF       R6 
	MOVF        FLOC__GLCD_DRW_VECTOR+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Byte+0, 0
	MOVF        R0, 0 
	MOVWF       GLCD_DRW_VECTOR_x_max_L0+0 
;glcd_pic.h,468 :: 		a = 1/tan(goc);
	MOVF        GLCD_DRW_VECTOR_goc_L0+0, 0 
	MOVWF       FARG_tan_x+0 
	MOVF        GLCD_DRW_VECTOR_goc_L0+1, 0 
	MOVWF       FARG_tan_x+1 
	MOVF        GLCD_DRW_VECTOR_goc_L0+2, 0 
	MOVWF       FARG_tan_x+2 
	MOVF        GLCD_DRW_VECTOR_goc_L0+3, 0 
	MOVWF       FARG_tan_x+3 
	CALL        _tan+0, 0
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       GLCD_DRW_VECTOR_a_L0+0 
	MOVF        R1, 0 
	MOVWF       GLCD_DRW_VECTOR_a_L0+1 
	MOVF        R2, 0 
	MOVWF       GLCD_DRW_VECTOR_a_L0+2 
	MOVF        R3, 0 
	MOVWF       GLCD_DRW_VECTOR_a_L0+3 
;glcd_pic.h,469 :: 		if(angle < 180)
	MOVLW       0
	SUBWF       FARG_GLCD_DRW_VECTOR_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR172
	MOVLW       180
	SUBWF       FARG_GLCD_DRW_VECTOR_angle+0, 0 
L__GLCD_DRW_VECTOR172:
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_VECTOR81
;glcd_pic.h,470 :: 		for(i=x1;i<=x1+x_max;i++)
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       GLCD_DRW_VECTOR_i_L0+0 
	MOVLW       0
	MOVWF       GLCD_DRW_VECTOR_i_L0+1 
L_GLCD_DRW_VECTOR82:
	MOVF        GLCD_DRW_VECTOR_x_max_L0+0, 0 
	ADDWF       FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVF        GLCD_DRW_VECTOR_i_L0+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR173
	MOVF        GLCD_DRW_VECTOR_i_L0+0, 0 
	SUBWF       R1, 0 
L__GLCD_DRW_VECTOR173:
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_VECTOR83
;glcd_pic.h,472 :: 		if(black_white)
	MOVF        FARG_GLCD_DRW_VECTOR_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR85
;glcd_pic.h,473 :: 		GLCD_POINT_DRW(i,(unsigned char)(y1 - a*(i-x1)));
	MOVF        GLCD_DRW_VECTOR_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	SUBWF       GLCD_DRW_VECTOR_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      GLCD_DRW_VECTOR_i_L0+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        GLCD_DRW_VECTOR_a_L0+0, 0 
	MOVWF       R4 
	MOVF        GLCD_DRW_VECTOR_a_L0+1, 0 
	MOVWF       R5 
	MOVF        GLCD_DRW_VECTOR_a_L0+2, 0 
	MOVWF       R6 
	MOVF        GLCD_DRW_VECTOR_a_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+0 
	MOVF        R1, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+1 
	MOVF        R2, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+2 
	MOVF        R3, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+3 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        FLOC__GLCD_DRW_VECTOR+0, 0 
	MOVWF       R4 
	MOVF        FLOC__GLCD_DRW_VECTOR+1, 0 
	MOVWF       R5 
	MOVF        FLOC__GLCD_DRW_VECTOR+2, 0 
	MOVWF       R6 
	MOVF        FLOC__GLCD_DRW_VECTOR+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _Double2Byte+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
	GOTO        L_GLCD_DRW_VECTOR86
L_GLCD_DRW_VECTOR85:
;glcd_pic.h,475 :: 		GLCD_POINT_CLR(i,(unsigned char)(y1 - a*(i-x1)));
	MOVF        GLCD_DRW_VECTOR_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	SUBWF       GLCD_DRW_VECTOR_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      GLCD_DRW_VECTOR_i_L0+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        GLCD_DRW_VECTOR_a_L0+0, 0 
	MOVWF       R4 
	MOVF        GLCD_DRW_VECTOR_a_L0+1, 0 
	MOVWF       R5 
	MOVF        GLCD_DRW_VECTOR_a_L0+2, 0 
	MOVWF       R6 
	MOVF        GLCD_DRW_VECTOR_a_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+0 
	MOVF        R1, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+1 
	MOVF        R2, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+2 
	MOVF        R3, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+3 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        FLOC__GLCD_DRW_VECTOR+0, 0 
	MOVWF       R4 
	MOVF        FLOC__GLCD_DRW_VECTOR+1, 0 
	MOVWF       R5 
	MOVF        FLOC__GLCD_DRW_VECTOR+2, 0 
	MOVWF       R6 
	MOVF        FLOC__GLCD_DRW_VECTOR+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _Double2Byte+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
L_GLCD_DRW_VECTOR86:
;glcd_pic.h,470 :: 		for(i=x1;i<=x1+x_max;i++)
	INFSNZ      GLCD_DRW_VECTOR_i_L0+0, 1 
	INCF        GLCD_DRW_VECTOR_i_L0+1, 1 
;glcd_pic.h,476 :: 		}
	GOTO        L_GLCD_DRW_VECTOR82
L_GLCD_DRW_VECTOR83:
	GOTO        L_GLCD_DRW_VECTOR87
L_GLCD_DRW_VECTOR81:
;glcd_pic.h,478 :: 		for(i=(x1-x_max);i<=x1;i++)
	MOVF        GLCD_DRW_VECTOR_x_max_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       GLCD_DRW_VECTOR_i_L0+0 
	CLRF        GLCD_DRW_VECTOR_i_L0+1 
	MOVLW       0
	SUBWFB      GLCD_DRW_VECTOR_i_L0+1, 1 
L_GLCD_DRW_VECTOR88:
	MOVLW       0
	MOVWF       R0 
	MOVF        GLCD_DRW_VECTOR_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR174
	MOVF        GLCD_DRW_VECTOR_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_VECTOR_x1+0, 0 
L__GLCD_DRW_VECTOR174:
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_VECTOR89
;glcd_pic.h,480 :: 		if(black_white)
	MOVF        FARG_GLCD_DRW_VECTOR_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR91
;glcd_pic.h,481 :: 		GLCD_POINT_DRW(i,(unsigned char)(y1 - a*(x1-i)));
	MOVF        GLCD_DRW_VECTOR_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_VECTOR_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       R0 
	MOVF        GLCD_DRW_VECTOR_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       0
	SUBFWB      R1, 1 
	CALL        _Word2Double+0, 0
	MOVF        GLCD_DRW_VECTOR_a_L0+0, 0 
	MOVWF       R4 
	MOVF        GLCD_DRW_VECTOR_a_L0+1, 0 
	MOVWF       R5 
	MOVF        GLCD_DRW_VECTOR_a_L0+2, 0 
	MOVWF       R6 
	MOVF        GLCD_DRW_VECTOR_a_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+0 
	MOVF        R1, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+1 
	MOVF        R2, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+2 
	MOVF        R3, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+3 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        FLOC__GLCD_DRW_VECTOR+0, 0 
	MOVWF       R4 
	MOVF        FLOC__GLCD_DRW_VECTOR+1, 0 
	MOVWF       R5 
	MOVF        FLOC__GLCD_DRW_VECTOR+2, 0 
	MOVWF       R6 
	MOVF        FLOC__GLCD_DRW_VECTOR+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _Double2Byte+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
	GOTO        L_GLCD_DRW_VECTOR92
L_GLCD_DRW_VECTOR91:
;glcd_pic.h,483 :: 		GLCD_POINT_CLR(i,(unsigned char)(y1 - a*(x1-i)));
	MOVF        GLCD_DRW_VECTOR_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_VECTOR_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       R0 
	MOVF        GLCD_DRW_VECTOR_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       0
	SUBFWB      R1, 1 
	CALL        _Word2Double+0, 0
	MOVF        GLCD_DRW_VECTOR_a_L0+0, 0 
	MOVWF       R4 
	MOVF        GLCD_DRW_VECTOR_a_L0+1, 0 
	MOVWF       R5 
	MOVF        GLCD_DRW_VECTOR_a_L0+2, 0 
	MOVWF       R6 
	MOVF        GLCD_DRW_VECTOR_a_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+0 
	MOVF        R1, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+1 
	MOVF        R2, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+2 
	MOVF        R3, 0 
	MOVWF       FLOC__GLCD_DRW_VECTOR+3 
	MOVF        FARG_GLCD_DRW_VECTOR_y1+0, 0 
	MOVWF       R0 
	CALL        _Byte2Double+0, 0
	MOVF        FLOC__GLCD_DRW_VECTOR+0, 0 
	MOVWF       R4 
	MOVF        FLOC__GLCD_DRW_VECTOR+1, 0 
	MOVWF       R5 
	MOVF        FLOC__GLCD_DRW_VECTOR+2, 0 
	MOVWF       R6 
	MOVF        FLOC__GLCD_DRW_VECTOR+3, 0 
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	CALL        _Double2Byte+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
L_GLCD_DRW_VECTOR92:
;glcd_pic.h,478 :: 		for(i=(x1-x_max);i<=x1;i++)
	INFSNZ      GLCD_DRW_VECTOR_i_L0+0, 1 
	INCF        GLCD_DRW_VECTOR_i_L0+1, 1 
;glcd_pic.h,484 :: 		}
	GOTO        L_GLCD_DRW_VECTOR88
L_GLCD_DRW_VECTOR89:
L_GLCD_DRW_VECTOR87:
;glcd_pic.h,485 :: 		}
L_GLCD_DRW_VECTOR78:
L_GLCD_DRW_VECTOR74:
L_GLCD_DRW_VECTOR70:
L_GLCD_DRW_VECTOR66:
;glcd_pic.h,486 :: 		}
	RETURN      0
; end of _GLCD_DRW_VECTOR

_GLCD_DRW_CIRCLE_EMPTY:

;glcd_pic.h,488 :: 		void GLCD_DRW_CIRCLE_EMPTY(unsigned char x, unsigned char y, unsigned char r, unsigned char black_white)
;glcd_pic.h,492 :: 		r2 = r*r;
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	MULWF       FARG_GLCD_DRW_CIRCLE_EMPTY_r+0 
	MOVF        PRODL+0, 0 
	MOVWF       GLCD_DRW_CIRCLE_EMPTY_r2_L0+0 
	MOVF        PRODH+0, 0 
	MOVWF       GLCD_DRW_CIRCLE_EMPTY_r2_L0+1 
;glcd_pic.h,493 :: 		for(i=0;i<=r;i++)
	CLRF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0 
L_GLCD_DRW_CIRCLE_EMPTY93:
	MOVF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_CIRCLE_EMPTY94
;glcd_pic.h,495 :: 		j = 0;
	CLRF        GLCD_DRW_CIRCLE_EMPTY_j_L0+0 
;glcd_pic.h,496 :: 		ri2 = (r-i)*(r-i);
	MOVF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       GLCD_DRW_CIRCLE_EMPTY_ri2_L0+0 
	MOVF        R1, 0 
	MOVWF       GLCD_DRW_CIRCLE_EMPTY_ri2_L0+1 
;glcd_pic.h,498 :: 		while((ri2 + (r-j)*(r-j)) > r2)
L_GLCD_DRW_CIRCLE_EMPTY96:
	MOVF        GLCD_DRW_CIRCLE_EMPTY_j_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	ADDWF       GLCD_DRW_CIRCLE_EMPTY_ri2_L0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      GLCD_DRW_CIRCLE_EMPTY_ri2_L0+1, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	SUBWF       GLCD_DRW_CIRCLE_EMPTY_r2_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_CIRCLE_EMPTY175
	MOVF        R2, 0 
	SUBWF       GLCD_DRW_CIRCLE_EMPTY_r2_L0+0, 0 
L__GLCD_DRW_CIRCLE_EMPTY175:
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_CIRCLE_EMPTY97
;glcd_pic.h,500 :: 		j++;
	INCF        GLCD_DRW_CIRCLE_EMPTY_j_L0+0, 1 
;glcd_pic.h,501 :: 		}
	GOTO        L_GLCD_DRW_CIRCLE_EMPTY96
L_GLCD_DRW_CIRCLE_EMPTY97:
;glcd_pic.h,503 :: 		if(black_white)
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_CIRCLE_EMPTY98
;glcd_pic.h,505 :: 		GLCD_POINT_DRW(x-r+i,y-r+j);
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_EMPTY_x+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_DRW_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_EMPTY_y+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_j_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_DRW_y+0, 1 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_pic.h,506 :: 		GLCD_POINT_DRW(x-r+i,y+r-j);
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_EMPTY_x+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_DRW_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_EMPTY_y+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_j_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_DRW_y+0, 1 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_pic.h,507 :: 		GLCD_POINT_DRW(x+r-i,y+r-j);
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_EMPTY_x+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_DRW_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_EMPTY_y+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_j_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_DRW_y+0, 1 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_pic.h,508 :: 		GLCD_POINT_DRW(x+r-i,y-r+j);
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_EMPTY_x+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_DRW_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_EMPTY_y+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_j_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_DRW_y+0, 1 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_pic.h,509 :: 		}
	GOTO        L_GLCD_DRW_CIRCLE_EMPTY99
L_GLCD_DRW_CIRCLE_EMPTY98:
;glcd_pic.h,512 :: 		GLCD_POINT_CLR(x-r+i,y-r+j);
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_EMPTY_x+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_CLR_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_EMPTY_y+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_j_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_CLR_y+0, 1 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_pic.h,513 :: 		GLCD_POINT_CLR(x-r+i,y+r-j);
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_EMPTY_x+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_CLR_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_EMPTY_y+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_j_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_CLR_y+0, 1 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_pic.h,514 :: 		GLCD_POINT_CLR(x+r-i,y+r-j);
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_EMPTY_x+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_CLR_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_EMPTY_y+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_j_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_CLR_y+0, 1 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_pic.h,515 :: 		GLCD_POINT_CLR(x+r-i,y-r+j);
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_EMPTY_x+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_CLR_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_EMPTY_y+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	MOVF        GLCD_DRW_CIRCLE_EMPTY_j_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_CLR_y+0, 1 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_pic.h,516 :: 		}
L_GLCD_DRW_CIRCLE_EMPTY99:
;glcd_pic.h,493 :: 		for(i=0;i<=r;i++)
	INCF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0, 1 
;glcd_pic.h,517 :: 		}
	GOTO        L_GLCD_DRW_CIRCLE_EMPTY93
L_GLCD_DRW_CIRCLE_EMPTY94:
;glcd_pic.h,518 :: 		}
	RETURN      0
; end of _GLCD_DRW_CIRCLE_EMPTY

_GLCD_DRW_CIRCLE_SOLID:

;glcd_pic.h,519 :: 		void GLCD_DRW_CIRCLE_SOLID(unsigned char x, unsigned char y, unsigned char r, unsigned char black_white)
;glcd_pic.h,523 :: 		r2 = r*r;
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	MULWF       FARG_GLCD_DRW_CIRCLE_SOLID_r+0 
	MOVF        PRODL+0, 0 
	MOVWF       GLCD_DRW_CIRCLE_SOLID_r2_L0+0 
	MOVF        PRODH+0, 0 
	MOVWF       GLCD_DRW_CIRCLE_SOLID_r2_L0+1 
;glcd_pic.h,524 :: 		for(i=0;i<=r;i++)
	CLRF        GLCD_DRW_CIRCLE_SOLID_i_L0+0 
L_GLCD_DRW_CIRCLE_SOLID100:
	MOVF        GLCD_DRW_CIRCLE_SOLID_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_CIRCLE_SOLID101
;glcd_pic.h,526 :: 		ri2 = (r-i)*(r-i);
	MOVF        GLCD_DRW_CIRCLE_SOLID_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       GLCD_DRW_CIRCLE_SOLID_ri2_L0+0 
	MOVF        R1, 0 
	MOVWF       GLCD_DRW_CIRCLE_SOLID_ri2_L0+1 
;glcd_pic.h,527 :: 		for(j=0;j<=r;j++)
	CLRF        GLCD_DRW_CIRCLE_SOLID_j_L0+0 
L_GLCD_DRW_CIRCLE_SOLID103:
	MOVF        GLCD_DRW_CIRCLE_SOLID_j_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_CIRCLE_SOLID104
;glcd_pic.h,529 :: 		if((ri2 + (r-j)*(r-j)) <= r2)
	MOVF        GLCD_DRW_CIRCLE_SOLID_j_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	ADDWF       GLCD_DRW_CIRCLE_SOLID_ri2_L0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	ADDWFC      GLCD_DRW_CIRCLE_SOLID_ri2_L0+1, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	SUBWF       GLCD_DRW_CIRCLE_SOLID_r2_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_CIRCLE_SOLID176
	MOVF        R2, 0 
	SUBWF       GLCD_DRW_CIRCLE_SOLID_r2_L0+0, 0 
L__GLCD_DRW_CIRCLE_SOLID176:
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_CIRCLE_SOLID106
;glcd_pic.h,531 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_CIRCLE_SOLID107
;glcd_pic.h,533 :: 		GLCD_POINT_DRW(x-r+i,y-r+j);
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_x+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_i_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_DRW_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_y+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_j_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_DRW_y+0, 1 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_pic.h,534 :: 		GLCD_POINT_DRW(x-r+i,y+r-j);
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_x+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_i_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_DRW_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_SOLID_y+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_j_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_DRW_y+0, 1 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_pic.h,535 :: 		GLCD_POINT_DRW(x+r-i,y+r-j);
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_SOLID_x+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_i_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_DRW_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_SOLID_y+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_j_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_DRW_y+0, 1 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_pic.h,536 :: 		GLCD_POINT_DRW(x+r-i,y-r+j);
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_SOLID_x+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_i_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_DRW_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_y+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_j_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_DRW_y+0, 1 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_pic.h,537 :: 		}
	GOTO        L_GLCD_DRW_CIRCLE_SOLID108
L_GLCD_DRW_CIRCLE_SOLID107:
;glcd_pic.h,540 :: 		GLCD_POINT_CLR(x-r+i,y-r+j);
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_x+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_i_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_CLR_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_y+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_j_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_CLR_y+0, 1 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_pic.h,541 :: 		GLCD_POINT_CLR(x-r+i,y+r-j);
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_x+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_i_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_CLR_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_SOLID_y+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_j_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_CLR_y+0, 1 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_pic.h,542 :: 		GLCD_POINT_CLR(x+r-i,y+r-j);
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_SOLID_x+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_i_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_CLR_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_SOLID_y+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_j_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_CLR_y+0, 1 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_pic.h,543 :: 		GLCD_POINT_CLR(x+r-i,y-r+j);
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	ADDWF       FARG_GLCD_DRW_CIRCLE_SOLID_x+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_i_L0+0, 0 
	SUBWF       FARG_GLCD_POINT_CLR_x+0, 1 
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_y+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	MOVF        GLCD_DRW_CIRCLE_SOLID_j_L0+0, 0 
	ADDWF       FARG_GLCD_POINT_CLR_y+0, 1 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_pic.h,544 :: 		}
L_GLCD_DRW_CIRCLE_SOLID108:
;glcd_pic.h,545 :: 		}
L_GLCD_DRW_CIRCLE_SOLID106:
;glcd_pic.h,527 :: 		for(j=0;j<=r;j++)
	INCF        GLCD_DRW_CIRCLE_SOLID_j_L0+0, 1 
;glcd_pic.h,546 :: 		}
	GOTO        L_GLCD_DRW_CIRCLE_SOLID103
L_GLCD_DRW_CIRCLE_SOLID104:
;glcd_pic.h,524 :: 		for(i=0;i<=r;i++)
	INCF        GLCD_DRW_CIRCLE_SOLID_i_L0+0, 1 
;glcd_pic.h,547 :: 		}
	GOTO        L_GLCD_DRW_CIRCLE_SOLID100
L_GLCD_DRW_CIRCLE_SOLID101:
;glcd_pic.h,548 :: 		}
	RETURN      0
; end of _GLCD_DRW_CIRCLE_SOLID

_GLCD_CHAR_SET:

;glcd_pic.h,554 :: 		unsigned int GLCD_CHAR_SET(unsigned char glcd_x, unsigned char glcd_y, const char * glcd_font, unsigned char num)
;glcd_pic.h,560 :: 		add = (glcd_y / 8)*128 + glcd_x;
	MOVLW       3
	MOVWF       R0 
	MOVF        FARG_GLCD_CHAR_SET_glcd_y+0, 0 
	MOVWF       GLCD_CHAR_SET_add_L0+0 
	MOVLW       0
	MOVWF       GLCD_CHAR_SET_add_L0+1 
	MOVF        R0, 0 
L__GLCD_CHAR_SET177:
	BZ          L__GLCD_CHAR_SET178
	RRCF        GLCD_CHAR_SET_add_L0+0, 1 
	BCF         GLCD_CHAR_SET_add_L0+0, 7 
	ADDLW       255
	GOTO        L__GLCD_CHAR_SET177
L__GLCD_CHAR_SET178:
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       GLCD_CHAR_SET_add_L0+1 
	MOVF        R0, 0 
L__GLCD_CHAR_SET179:
	BZ          L__GLCD_CHAR_SET180
	RLCF        GLCD_CHAR_SET_add_L0+0, 1 
	BCF         GLCD_CHAR_SET_add_L0+0, 0 
	RLCF        GLCD_CHAR_SET_add_L0+1, 1 
	ADDLW       255
	GOTO        L__GLCD_CHAR_SET179
L__GLCD_CHAR_SET180:
	MOVF        FARG_GLCD_CHAR_SET_glcd_x+0, 0 
	ADDWF       GLCD_CHAR_SET_add_L0+0, 1 
	MOVLW       0
	ADDWFC      GLCD_CHAR_SET_add_L0+1, 1 
;glcd_pic.h,561 :: 		glcd_y = glcd_y % 8;
	MOVLW       7
	ANDWF       FARG_GLCD_CHAR_SET_glcd_y+0, 1 
;glcd_pic.h,563 :: 		if((num >= 32)&&(num <= 126))
	MOVLW       32
	SUBWF       FARG_GLCD_CHAR_SET_num+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_CHAR_SET111
	MOVF        FARG_GLCD_CHAR_SET_num+0, 0 
	SUBLW       126
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_CHAR_SET111
L__GLCD_CHAR_SET156:
;glcd_pic.h,565 :: 		glcd_font = glcd_font + (num-32)*5;
	MOVLW       32
	SUBWF       FARG_GLCD_CHAR_SET_num+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_GLCD_CHAR_SET_glcd_font+0, 1 
	MOVF        R1, 0 
	ADDWFC      FARG_GLCD_CHAR_SET_glcd_font+1, 1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      FARG_GLCD_CHAR_SET_glcd_font+2, 1 
;glcd_pic.h,567 :: 		for(i=0;i<5;i++)
	CLRF        GLCD_CHAR_SET_i_L0+0 
L_GLCD_CHAR_SET112:
	MOVLW       5
	SUBWF       GLCD_CHAR_SET_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_CHAR_SET113
;glcd_pic.h,569 :: 		c = *(glcd_font);
	MOVF        FARG_GLCD_CHAR_SET_glcd_font+0, 0 
	MOVWF       TBLPTRL 
	MOVF        FARG_GLCD_CHAR_SET_glcd_font+1, 0 
	MOVWF       TBLPTRH 
	MOVF        FARG_GLCD_CHAR_SET_glcd_font+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	MOVF        R4, 0 
	MOVWF       GLCD_CHAR_SET_c_L0+0 
;glcd_pic.h,570 :: 		glcd_buff[add] |= (c << glcd_y);
	MOVLW       _glcd_buff+0
	ADDWF       GLCD_CHAR_SET_add_L0+0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_glcd_buff+0)
	ADDWFC      GLCD_CHAR_SET_add_L0+1, 0 
	MOVWF       R3 
	MOVF        FARG_GLCD_CHAR_SET_glcd_y+0, 0 
	MOVWF       R1 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__GLCD_CHAR_SET181:
	BZ          L__GLCD_CHAR_SET182
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__GLCD_CHAR_SET181
L__GLCD_CHAR_SET182:
	MOVFF       R2, FSR0L
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	IORWF       R0, 1 
	MOVFF       R2, FSR1L
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;glcd_pic.h,571 :: 		glcd_buff[add + 128] |= (c >> (8 - glcd_y));
	MOVLW       128
	ADDWF       GLCD_CHAR_SET_add_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      GLCD_CHAR_SET_add_L0+1, 0 
	MOVWF       R1 
	MOVLW       _glcd_buff+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_glcd_buff+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVF        FARG_GLCD_CHAR_SET_glcd_y+0, 0 
	SUBLW       8
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        GLCD_CHAR_SET_c_L0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__GLCD_CHAR_SET183:
	BZ          L__GLCD_CHAR_SET184
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__GLCD_CHAR_SET183
L__GLCD_CHAR_SET184:
	MOVFF       R2, FSR0L
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	IORWF       R0, 1 
	MOVFF       R2, FSR1L
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;glcd_pic.h,572 :: 		add++;
	INFSNZ      GLCD_CHAR_SET_add_L0+0, 1 
	INCF        GLCD_CHAR_SET_add_L0+1, 1 
;glcd_pic.h,573 :: 		glcd_font++;
	MOVLW       1
	ADDWF       FARG_GLCD_CHAR_SET_glcd_font+0, 1 
	MOVLW       0
	ADDWFC      FARG_GLCD_CHAR_SET_glcd_font+1, 1 
	ADDWFC      FARG_GLCD_CHAR_SET_glcd_font+2, 1 
;glcd_pic.h,567 :: 		for(i=0;i<5;i++)
	INCF        GLCD_CHAR_SET_i_L0+0, 1 
;glcd_pic.h,574 :: 		}
	GOTO        L_GLCD_CHAR_SET112
L_GLCD_CHAR_SET113:
;glcd_pic.h,575 :: 		}
L_GLCD_CHAR_SET111:
;glcd_pic.h,576 :: 		return (glcd_x + 6);
	MOVLW       6
	ADDWF       FARG_GLCD_CHAR_SET_glcd_x+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
;glcd_pic.h,577 :: 		}
	RETURN      0
; end of _GLCD_CHAR_SET

_GLCD_CHAR_CLR:

;glcd_pic.h,579 :: 		unsigned int GLCD_CHAR_CLR(unsigned char glcd_x, unsigned char glcd_y, const char * glcd_font, unsigned char num)
;glcd_pic.h,585 :: 		add = (glcd_y / 8)*128 + glcd_x;
	MOVLW       3
	MOVWF       R0 
	MOVF        FARG_GLCD_CHAR_CLR_glcd_y+0, 0 
	MOVWF       GLCD_CHAR_CLR_add_L0+0 
	MOVLW       0
	MOVWF       GLCD_CHAR_CLR_add_L0+1 
	MOVF        R0, 0 
L__GLCD_CHAR_CLR185:
	BZ          L__GLCD_CHAR_CLR186
	RRCF        GLCD_CHAR_CLR_add_L0+0, 1 
	BCF         GLCD_CHAR_CLR_add_L0+0, 7 
	ADDLW       255
	GOTO        L__GLCD_CHAR_CLR185
L__GLCD_CHAR_CLR186:
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       GLCD_CHAR_CLR_add_L0+1 
	MOVF        R0, 0 
L__GLCD_CHAR_CLR187:
	BZ          L__GLCD_CHAR_CLR188
	RLCF        GLCD_CHAR_CLR_add_L0+0, 1 
	BCF         GLCD_CHAR_CLR_add_L0+0, 0 
	RLCF        GLCD_CHAR_CLR_add_L0+1, 1 
	ADDLW       255
	GOTO        L__GLCD_CHAR_CLR187
L__GLCD_CHAR_CLR188:
	MOVF        FARG_GLCD_CHAR_CLR_glcd_x+0, 0 
	ADDWF       GLCD_CHAR_CLR_add_L0+0, 1 
	MOVLW       0
	ADDWFC      GLCD_CHAR_CLR_add_L0+1, 1 
;glcd_pic.h,586 :: 		glcd_y = glcd_y % 8;
	MOVLW       7
	ANDWF       FARG_GLCD_CHAR_CLR_glcd_y+0, 1 
;glcd_pic.h,588 :: 		if((num >= 32)&&(num <= 126))
	MOVLW       32
	SUBWF       FARG_GLCD_CHAR_CLR_num+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_CHAR_CLR117
	MOVF        FARG_GLCD_CHAR_CLR_num+0, 0 
	SUBLW       126
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_CHAR_CLR117
L__GLCD_CHAR_CLR157:
;glcd_pic.h,590 :: 		glcd_font = glcd_font + (num-32)*5;
	MOVLW       32
	SUBWF       FARG_GLCD_CHAR_CLR_num+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_GLCD_CHAR_CLR_glcd_font+0, 1 
	MOVF        R1, 0 
	ADDWFC      FARG_GLCD_CHAR_CLR_glcd_font+1, 1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      FARG_GLCD_CHAR_CLR_glcd_font+2, 1 
;glcd_pic.h,592 :: 		for(i=0;i<5;i++)
	CLRF        GLCD_CHAR_CLR_i_L0+0 
L_GLCD_CHAR_CLR118:
	MOVLW       5
	SUBWF       GLCD_CHAR_CLR_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_CHAR_CLR119
;glcd_pic.h,595 :: 		c = (unsigned short int)glcd_font;
	MOVF        FARG_GLCD_CHAR_CLR_glcd_font+0, 0 
	MOVWF       GLCD_CHAR_CLR_c_L0+0 
;glcd_pic.h,596 :: 		glcd_buff[add] &= ((c << glcd_y) ^ 0xFF);
	MOVLW       _glcd_buff+0
	ADDWF       GLCD_CHAR_CLR_add_L0+0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_glcd_buff+0)
	ADDWFC      GLCD_CHAR_CLR_add_L0+1, 0 
	MOVWF       R3 
	MOVF        FARG_GLCD_CHAR_CLR_glcd_y+0, 0 
	MOVWF       R1 
	MOVF        FARG_GLCD_CHAR_CLR_glcd_font+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__GLCD_CHAR_CLR189:
	BZ          L__GLCD_CHAR_CLR190
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__GLCD_CHAR_CLR189
L__GLCD_CHAR_CLR190:
	MOVLW       255
	XORWF       R0, 1 
	MOVFF       R2, FSR0L
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	ANDWF       R0, 1 
	MOVFF       R2, FSR1L
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;glcd_pic.h,597 :: 		glcd_buff[add + 128] &= ((c >> (8 - glcd_y)) ^ 0xFF);
	MOVLW       128
	ADDWF       GLCD_CHAR_CLR_add_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      GLCD_CHAR_CLR_add_L0+1, 0 
	MOVWF       R1 
	MOVLW       _glcd_buff+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_glcd_buff+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVF        FARG_GLCD_CHAR_CLR_glcd_y+0, 0 
	SUBLW       8
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVF        GLCD_CHAR_CLR_c_L0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__GLCD_CHAR_CLR191:
	BZ          L__GLCD_CHAR_CLR192
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__GLCD_CHAR_CLR191
L__GLCD_CHAR_CLR192:
	MOVLW       255
	XORWF       R0, 1 
	MOVFF       R2, FSR0L
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	ANDWF       R0, 1 
	MOVFF       R2, FSR1L
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;glcd_pic.h,598 :: 		add++;
	INFSNZ      GLCD_CHAR_CLR_add_L0+0, 1 
	INCF        GLCD_CHAR_CLR_add_L0+1, 1 
;glcd_pic.h,599 :: 		glcd_font++;
	MOVLW       1
	ADDWF       FARG_GLCD_CHAR_CLR_glcd_font+0, 1 
	MOVLW       0
	ADDWFC      FARG_GLCD_CHAR_CLR_glcd_font+1, 1 
	ADDWFC      FARG_GLCD_CHAR_CLR_glcd_font+2, 1 
;glcd_pic.h,592 :: 		for(i=0;i<5;i++)
	INCF        GLCD_CHAR_CLR_i_L0+0, 1 
;glcd_pic.h,600 :: 		}
	GOTO        L_GLCD_CHAR_CLR118
L_GLCD_CHAR_CLR119:
;glcd_pic.h,601 :: 		}
L_GLCD_CHAR_CLR117:
;glcd_pic.h,602 :: 		return (glcd_x + 6);
	MOVLW       6
	ADDWF       FARG_GLCD_CHAR_CLR_glcd_x+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
;glcd_pic.h,603 :: 		}
	RETURN      0
; end of _GLCD_CHAR_CLR

_GLCD_OUT_STR:

;glcd_pic.h,605 :: 		unsigned int GLCD_OUT_STR(unsigned char glcd_x, unsigned char glcd_y, char *glcd_str, unsigned char black_white)
;glcd_pic.h,607 :: 		while(*glcd_str)
L_GLCD_OUT_STR121:
	MOVFF       FARG_GLCD_OUT_STR_glcd_str+0, FSR0L
	MOVFF       FARG_GLCD_OUT_STR_glcd_str+1, FSR0H
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_OUT_STR122
;glcd_pic.h,609 :: 		if(black_white)
	MOVF        FARG_GLCD_OUT_STR_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_OUT_STR123
;glcd_pic.h,610 :: 		GLCD_CHAR_SET(glcd_x, glcd_y, basic_font, *glcd_str);
	MOVF        FARG_GLCD_OUT_STR_glcd_x+0, 0 
	MOVWF       FARG_GLCD_CHAR_SET_glcd_x+0 
	MOVF        FARG_GLCD_OUT_STR_glcd_y+0, 0 
	MOVWF       FARG_GLCD_CHAR_SET_glcd_y+0 
	MOVLW       _basic_font+0
	MOVWF       FARG_GLCD_CHAR_SET_glcd_font+0 
	MOVLW       hi_addr(_basic_font+0)
	MOVWF       FARG_GLCD_CHAR_SET_glcd_font+1 
	MOVLW       higher_addr(_basic_font+0)
	MOVWF       FARG_GLCD_CHAR_SET_glcd_font+2 
	MOVFF       FARG_GLCD_OUT_STR_glcd_str+0, FSR0L
	MOVFF       FARG_GLCD_OUT_STR_glcd_str+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_GLCD_CHAR_SET_num+0 
	CALL        _GLCD_CHAR_SET+0, 0
	GOTO        L_GLCD_OUT_STR124
L_GLCD_OUT_STR123:
;glcd_pic.h,612 :: 		GLCD_CHAR_CLR(glcd_x, glcd_y, basic_font, *glcd_str);
	MOVF        FARG_GLCD_OUT_STR_glcd_x+0, 0 
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_x+0 
	MOVF        FARG_GLCD_OUT_STR_glcd_y+0, 0 
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_y+0 
	MOVLW       _basic_font+0
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_font+0 
	MOVLW       hi_addr(_basic_font+0)
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_font+1 
	MOVLW       higher_addr(_basic_font+0)
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_font+2 
	MOVFF       FARG_GLCD_OUT_STR_glcd_str+0, FSR0L
	MOVFF       FARG_GLCD_OUT_STR_glcd_str+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_GLCD_CHAR_CLR_num+0 
	CALL        _GLCD_CHAR_CLR+0, 0
L_GLCD_OUT_STR124:
;glcd_pic.h,613 :: 		glcd_x = glcd_x + 6;
	MOVLW       6
	ADDWF       FARG_GLCD_OUT_STR_glcd_x+0, 1 
;glcd_pic.h,614 :: 		glcd_str++;
	INFSNZ      FARG_GLCD_OUT_STR_glcd_str+0, 1 
	INCF        FARG_GLCD_OUT_STR_glcd_str+1, 1 
;glcd_pic.h,615 :: 		}
	GOTO        L_GLCD_OUT_STR121
L_GLCD_OUT_STR122:
;glcd_pic.h,616 :: 		return (glcd_x);
	MOVF        FARG_GLCD_OUT_STR_glcd_x+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
;glcd_pic.h,617 :: 		}
	RETURN      0
; end of _GLCD_OUT_STR

_GLCD_OUT_DEC:

;glcd_pic.h,640 :: 		unsigned int GLCD_OUT_DEC(unsigned char glcd_x, unsigned char glcd_y, unsigned long int glcd_n, unsigned char glcd_length, unsigned char black_white)
;glcd_pic.h,645 :: 		if(black_white)
	MOVF        FARG_GLCD_OUT_DEC_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_OUT_DEC125
;glcd_pic.h,646 :: 		for(i=glcd_length;i>0;i--)
	MOVF        FARG_GLCD_OUT_DEC_glcd_length+0, 0 
	MOVWF       GLCD_OUT_DEC_i_L0+0 
L_GLCD_OUT_DEC126:
	MOVF        GLCD_OUT_DEC_i_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_OUT_DEC127
;glcd_pic.h,648 :: 		glcd_temp = (glcd_n % 10) + 0x30;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+0, 0 
	MOVWF       R0 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+1, 0 
	MOVWF       R1 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+2, 0 
	MOVWF       R2 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       GLCD_OUT_DEC_glcd_temp_L0+0 
;glcd_pic.h,649 :: 		glcd_n = glcd_n / 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+0, 0 
	MOVWF       R0 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+1, 0 
	MOVWF       R1 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+2, 0 
	MOVWF       R2 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_GLCD_OUT_DEC_glcd_n+0 
	MOVF        R1, 0 
	MOVWF       FARG_GLCD_OUT_DEC_glcd_n+1 
	MOVF        R2, 0 
	MOVWF       FARG_GLCD_OUT_DEC_glcd_n+2 
	MOVF        R3, 0 
	MOVWF       FARG_GLCD_OUT_DEC_glcd_n+3 
;glcd_pic.h,650 :: 		GLCD_CHAR_SET((glcd_x + (i-1)*6), glcd_y, basic_font, glcd_temp);
	DECF        GLCD_OUT_DEC_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       6
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_GLCD_OUT_DEC_glcd_x+0, 0 
	MOVWF       FARG_GLCD_CHAR_SET_glcd_x+0 
	MOVF        FARG_GLCD_OUT_DEC_glcd_y+0, 0 
	MOVWF       FARG_GLCD_CHAR_SET_glcd_y+0 
	MOVLW       _basic_font+0
	MOVWF       FARG_GLCD_CHAR_SET_glcd_font+0 
	MOVLW       hi_addr(_basic_font+0)
	MOVWF       FARG_GLCD_CHAR_SET_glcd_font+1 
	MOVLW       higher_addr(_basic_font+0)
	MOVWF       FARG_GLCD_CHAR_SET_glcd_font+2 
	MOVF        GLCD_OUT_DEC_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_CHAR_SET_num+0 
	CALL        _GLCD_CHAR_SET+0, 0
;glcd_pic.h,646 :: 		for(i=glcd_length;i>0;i--)
	DECF        GLCD_OUT_DEC_i_L0+0, 1 
;glcd_pic.h,651 :: 		}
	GOTO        L_GLCD_OUT_DEC126
L_GLCD_OUT_DEC127:
	GOTO        L_GLCD_OUT_DEC129
L_GLCD_OUT_DEC125:
;glcd_pic.h,653 :: 		for(i=glcd_length;i>0;i--)
	MOVF        FARG_GLCD_OUT_DEC_glcd_length+0, 0 
	MOVWF       GLCD_OUT_DEC_i_L0+0 
L_GLCD_OUT_DEC130:
	MOVF        GLCD_OUT_DEC_i_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_OUT_DEC131
;glcd_pic.h,655 :: 		glcd_temp = (glcd_n % 10) + 0x30;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+0, 0 
	MOVWF       R0 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+1, 0 
	MOVWF       R1 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+2, 0 
	MOVWF       R2 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       GLCD_OUT_DEC_glcd_temp_L0+0 
;glcd_pic.h,656 :: 		glcd_n = glcd_n / 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+0, 0 
	MOVWF       R0 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+1, 0 
	MOVWF       R1 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+2, 0 
	MOVWF       R2 
	MOVF        FARG_GLCD_OUT_DEC_glcd_n+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_GLCD_OUT_DEC_glcd_n+0 
	MOVF        R1, 0 
	MOVWF       FARG_GLCD_OUT_DEC_glcd_n+1 
	MOVF        R2, 0 
	MOVWF       FARG_GLCD_OUT_DEC_glcd_n+2 
	MOVF        R3, 0 
	MOVWF       FARG_GLCD_OUT_DEC_glcd_n+3 
;glcd_pic.h,657 :: 		GLCD_CHAR_CLR((glcd_x + (i-1)*6), glcd_y, basic_font, glcd_temp);
	DECF        GLCD_OUT_DEC_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       6
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_GLCD_OUT_DEC_glcd_x+0, 0 
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_x+0 
	MOVF        FARG_GLCD_OUT_DEC_glcd_y+0, 0 
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_y+0 
	MOVLW       _basic_font+0
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_font+0 
	MOVLW       hi_addr(_basic_font+0)
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_font+1 
	MOVLW       higher_addr(_basic_font+0)
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_font+2 
	MOVF        GLCD_OUT_DEC_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_CHAR_CLR_num+0 
	CALL        _GLCD_CHAR_CLR+0, 0
;glcd_pic.h,653 :: 		for(i=glcd_length;i>0;i--)
	DECF        GLCD_OUT_DEC_i_L0+0, 1 
;glcd_pic.h,658 :: 		}
	GOTO        L_GLCD_OUT_DEC130
L_GLCD_OUT_DEC131:
L_GLCD_OUT_DEC129:
;glcd_pic.h,659 :: 		return (glcd_x + glcd_length*6);
	MOVLW       6
	MULWF       FARG_GLCD_OUT_DEC_glcd_length+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        FARG_GLCD_OUT_DEC_glcd_x+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
;glcd_pic.h,660 :: 		}
	RETURN      0
; end of _GLCD_OUT_DEC

_GLCD_IMAGE:

;glcd_pic.h,662 :: 		void GLCD_IMAGE(unsigned char * image)
;glcd_pic.h,665 :: 		for(i=0;i<1024;i++)
	CLRF        R1 
	CLRF        R2 
L_GLCD_IMAGE133:
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       4
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_IMAGE193
	MOVLW       0
	SUBWF       R1, 0 
L__GLCD_IMAGE193:
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_IMAGE134
;glcd_pic.h,666 :: 		glcd_buff[i] = image[i];
	MOVLW       _glcd_buff+0
	ADDWF       R1, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_glcd_buff+0)
	ADDWFC      R2, 0 
	MOVWF       FSR1H 
	MOVF        R1, 0 
	ADDWF       FARG_GLCD_IMAGE_image+0, 0 
	MOVWF       FSR0L 
	MOVF        R2, 0 
	ADDWFC      FARG_GLCD_IMAGE_image+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;glcd_pic.h,665 :: 		for(i=0;i<1024;i++)
	INFSNZ      R1, 1 
	INCF        R2, 1 
;glcd_pic.h,666 :: 		glcd_buff[i] = image[i];
	GOTO        L_GLCD_IMAGE133
L_GLCD_IMAGE134:
;glcd_pic.h,668 :: 		}
	RETURN      0
; end of _GLCD_IMAGE

_GLCD_FILL:

;glcd_pic.h,670 :: 		void GLCD_FILL(unsigned char black_white)
;glcd_pic.h,674 :: 		for(i=0;i<=127;i++)
	CLRF        GLCD_FILL_i_L0+0 
L_GLCD_FILL136:
	MOVF        GLCD_FILL_i_L0+0, 0 
	SUBLW       127
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_FILL137
;glcd_pic.h,675 :: 		for(j=0;j<=63;j++)
	CLRF        GLCD_FILL_j_L0+0 
L_GLCD_FILL139:
	MOVF        GLCD_FILL_j_L0+0, 0 
	SUBLW       63
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_FILL140
;glcd_pic.h,677 :: 		if(black_white)
	MOVF        FARG_GLCD_FILL_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_FILL142
;glcd_pic.h,678 :: 		GLCD_POINT_DRW(i,j);
	MOVF        GLCD_FILL_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_FILL_j_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
	GOTO        L_GLCD_FILL143
L_GLCD_FILL142:
;glcd_pic.h,680 :: 		GLCD_POINT_CLR(i,j);
	MOVF        GLCD_FILL_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_FILL_j_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
L_GLCD_FILL143:
;glcd_pic.h,675 :: 		for(j=0;j<=63;j++)
	INCF        GLCD_FILL_j_L0+0, 1 
;glcd_pic.h,681 :: 		}
	GOTO        L_GLCD_FILL139
L_GLCD_FILL140:
;glcd_pic.h,674 :: 		for(i=0;i<=127;i++)
	INCF        GLCD_FILL_i_L0+0, 1 
;glcd_pic.h,681 :: 		}
	GOTO        L_GLCD_FILL136
L_GLCD_FILL137:
;glcd_pic.h,682 :: 		}
	RETURN      0
; end of _GLCD_FILL

_Shift_data:

;main.c,8 :: 		void Shift_data(unsigned int index)
;main.c,11 :: 		for(i=8;i>=1;i--)
	MOVLW       8
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
L_Shift_data144:
	MOVLW       0
	SUBWF       R6, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Shift_data194
	MOVLW       1
	SUBWF       R5, 0 
L__Shift_data194:
	BTFSS       STATUS+0, 0 
	GOTO        L_Shift_data145
;main.c,13 :: 		data_shift = mode[index];   //   (In & (1<<BitNo)) && 1
	MOVF        FARG_Shift_data_index+0, 0 
	MOVWF       R0 
	MOVF        FARG_Shift_data_index+1, 0 
	MOVWF       R1 
	MOVLW       0
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       _mode+0
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(_mode+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(_mode+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R3
	TBLRD*+
	MOVFF       TABLAT+0, R4
;main.c,14 :: 		DAT = (data_shift & (1 << (i-1))) && 1;        //check bit (i-1) of data_shift
	MOVLW       1
	SUBWF       R5, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      R6, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__Shift_data195:
	BZ          L__Shift_data196
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__Shift_data195
L__Shift_data196:
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R4, 0 
	ANDWF       R1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Shift_data148
	MOVLW       1
	MOVWF       R0 
	GOTO        L_Shift_data147
L_Shift_data148:
	CLRF        R0 
L_Shift_data147:
	BTFSC       R0, 0 
	GOTO        L__Shift_data197
	BCF         RC5_bit+0, 5 
	GOTO        L__Shift_data198
L__Shift_data197:
	BSF         RC5_bit+0, 5 
L__Shift_data198:
;main.c,15 :: 		SH_CP = 1;
	BSF         RD2_bit+0, 2 
;main.c,16 :: 		delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_Shift_data149:
	DECFSZ      R13, 1, 1
	BRA         L_Shift_data149
	DECFSZ      R12, 1, 1
	BRA         L_Shift_data149
	NOP
	NOP
;main.c,17 :: 		SH_CP = 0;
	BCF         RD2_bit+0, 2 
;main.c,18 :: 		delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_Shift_data150:
	DECFSZ      R13, 1, 1
	BRA         L_Shift_data150
	DECFSZ      R12, 1, 1
	BRA         L_Shift_data150
	NOP
	NOP
;main.c,11 :: 		for(i=8;i>=1;i--)
	MOVLW       1
	SUBWF       R5, 1 
	MOVLW       0
	SUBWFB      R6, 1 
;main.c,19 :: 		}
	GOTO        L_Shift_data144
L_Shift_data145:
;main.c,20 :: 		}
	RETURN      0
; end of _Shift_data

_main:

;main.c,21 :: 		void main() {
;main.c,26 :: 		float Vs = 0.0755;
	MOVLW       190
	MOVWF       main_Vs_L0+0 
	MOVLW       159
	MOVWF       main_Vs_L0+1 
	MOVLW       26
	MOVWF       main_Vs_L0+2 
	MOVLW       123
	MOVWF       main_Vs_L0+3 
;main.c,31 :: 		CCP1CON = 0x00;
	CLRF        CCP1CON+0 
;main.c,32 :: 		CCP2CON = 0x00;
	CLRF        CCP2CON+0 
;main.c,33 :: 		ADCON0 = 0x00;
	CLRF        ADCON0+0 
;main.c,34 :: 		ADCON1 = 0b00001110;        // configure RA0 & RA1 pins as analog
	MOVLW       14
	MOVWF       ADCON1+0 
;main.c,35 :: 		TRISA  = 0b00000001;        // configure RAO & RA1 pins as inputs
	MOVLW       1
	MOVWF       TRISA+0 
;main.c,36 :: 		PORTA = 0;
	CLRF        PORTA+0 
;main.c,37 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main151:
	DECFSZ      R13, 1, 1
	BRA         L_main151
	DECFSZ      R12, 1, 1
	BRA         L_main151
	DECFSZ      R11, 1, 1
	BRA         L_main151
	NOP
	NOP
;main.c,38 :: 		TRISE = 0;
	CLRF        TRISE+0 
;main.c,39 :: 		TRISB = 0;
	CLRF        TRISB+0 
;main.c,40 :: 		TRISD = 0;
	CLRF        TRISD+0 
;main.c,41 :: 		TRISC = 0;
	CLRF        TRISC+0 
;main.c,42 :: 		PORTA = 0xFF;
	MOVLW       255
	MOVWF       PORTA+0 
;main.c,44 :: 		GLCD_INIT();
	CALL        _GLCD_INIT+0, 0
;main.c,45 :: 		GLCD_FILL(WHITE);
	CLRF        FARG_GLCD_FILL_black_white+0 
	CALL        _GLCD_FILL+0, 0
;main.c,46 :: 		GLCD_OUT_STR(0,0,"ADC Value",BLACK);
	CLRF        FARG_GLCD_OUT_STR_glcd_x+0 
	CLRF        FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       ?lstr1_main+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(?lstr1_main+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,47 :: 		GLCD_OUT_STR(0,10,"Voltage",BLACK);
	CLRF        FARG_GLCD_OUT_STR_glcd_x+0 
	MOVLW       10
	MOVWF       FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       ?lstr2_main+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(?lstr2_main+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,48 :: 		GLCD_OUT_STR(96,10,"V",BLACK);
	MOVLW       96
	MOVWF       FARG_GLCD_OUT_STR_glcd_x+0 
	MOVLW       10
	MOVWF       FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       ?lstr3_main+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(?lstr3_main+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,49 :: 		GLCD_OUT_STR(0,20,"Conduct.",BLACK);
	CLRF        FARG_GLCD_OUT_STR_glcd_x+0 
	MOVLW       20
	MOVWF       FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       ?lstr4_main+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(?lstr4_main+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,50 :: 		GLCD_OUT_STR(96,20,"uS/cm",BLACK);
	MOVLW       96
	MOVWF       FARG_GLCD_OUT_STR_glcd_x+0 
	MOVLW       20
	MOVWF       FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       ?lstr5_main+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(?lstr5_main+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,51 :: 		GLCD_DISPLAY();
	CALL        _GLCD_DISPLAY+0, 0
;main.c,61 :: 		Shift_data(0);
	CLRF        FARG_Shift_data_index+0 
	CLRF        FARG_Shift_data_index+1 
	CALL        _Shift_data+0, 0
;main.c,62 :: 		ST_CP = 1;
	BSF         RD3_bit+0, 3 
;main.c,63 :: 		delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_main152:
	DECFSZ      R13, 1, 1
	BRA         L_main152
	DECFSZ      R12, 1, 1
	BRA         L_main152
	NOP
	NOP
;main.c,64 :: 		ST_CP = 0;
	BCF         RD3_bit+0, 3 
;main.c,66 :: 		while(1)
L_main153:
;main.c,68 :: 		GLCD_FILL(WHITE);
	CLRF        FARG_GLCD_FILL_black_white+0 
	CALL        _GLCD_FILL+0, 0
;main.c,69 :: 		GLCD_OUT_STR(0,0,"ADC Value",BLACK);
	CLRF        FARG_GLCD_OUT_STR_glcd_x+0 
	CLRF        FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       ?lstr6_main+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(?lstr6_main+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,70 :: 		GLCD_OUT_STR(0,10,"Voltage",BLACK);
	CLRF        FARG_GLCD_OUT_STR_glcd_x+0 
	MOVLW       10
	MOVWF       FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       ?lstr7_main+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(?lstr7_main+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,71 :: 		GLCD_OUT_STR(96,10,"V",BLACK);
	MOVLW       96
	MOVWF       FARG_GLCD_OUT_STR_glcd_x+0 
	MOVLW       10
	MOVWF       FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       ?lstr8_main+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(?lstr8_main+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,72 :: 		GLCD_OUT_STR(0,20,"Conduct.",BLACK);
	CLRF        FARG_GLCD_OUT_STR_glcd_x+0 
	MOVLW       20
	MOVWF       FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       ?lstr9_main+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(?lstr9_main+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,73 :: 		GLCD_OUT_STR(96,20,"uS/cm",BLACK);
	MOVLW       96
	MOVWF       FARG_GLCD_OUT_STR_glcd_x+0 
	MOVLW       20
	MOVWF       FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       ?lstr10_main+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(?lstr10_main+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,74 :: 		temp_res = ADC_Read(0);   // Get results of AD conversion
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_temp_res_L0+0 
	MOVF        R1, 0 
	MOVWF       main_temp_res_L0+1 
;main.c,75 :: 		Vo = (float)5/1023*temp_res;
	CALL        _Word2Double+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       40
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       119
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_Vo_L0+0 
	MOVF        R1, 0 
	MOVWF       main_Vo_L0+1 
	MOVF        R2, 0 
	MOVWF       main_Vo_L0+2 
	MOVF        R3, 0 
	MOVWF       main_Vo_L0+3 
;main.c,76 :: 		V1 = (float)Vo/0.4125;
	MOVLW       51
	MOVWF       R4 
	MOVLW       51
	MOVWF       R5 
	MOVLW       83
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_V1_L0+0 
	MOVF        R1, 0 
	MOVWF       main_V1_L0+1 
	MOVF        R2, 0 
	MOVWF       main_V1_L0+2 
	MOVF        R3, 0 
	MOVWF       main_V1_L0+3 
;main.c,77 :: 		So = Vo / Vs;
	MOVF        main_Vs_L0+0, 0 
	MOVWF       R4 
	MOVF        main_Vs_L0+1, 0 
	MOVWF       R5 
	MOVF        main_Vs_L0+2, 0 
	MOVWF       R6 
	MOVF        main_Vs_L0+3, 0 
	MOVWF       R7 
	MOVF        main_Vo_L0+0, 0 
	MOVWF       R0 
	MOVF        main_Vo_L0+1, 0 
	MOVWF       R1 
	MOVF        main_Vo_L0+2, 0 
	MOVWF       R2 
	MOVF        main_Vo_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_So_L0+0 
	MOVF        R1, 0 
	MOVWF       main_So_L0+1 
	MOVF        R2, 0 
	MOVWF       main_So_L0+2 
	MOVF        R3, 0 
	MOVWF       main_So_L0+3 
;main.c,80 :: 		sprintf(txt_Vo,"%2.4f",Vo);
	MOVLW       main_txt_Vo_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(main_txt_Vo_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_11_main+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_11_main+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_11_main+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        main_Vo_L0+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        main_Vo_L0+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        main_Vo_L0+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        main_Vo_L0+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;main.c,81 :: 		sprintf(txt_V1,"%2.4f",V1);
	MOVLW       main_txt_V1_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(main_txt_V1_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_12_main+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_12_main+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_12_main+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        main_V1_L0+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        main_V1_L0+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        main_V1_L0+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        main_V1_L0+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;main.c,82 :: 		sprintf(txt_So,"%2.4f",So);
	MOVLW       main_txt_So_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(main_txt_So_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_13_main+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_13_main+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_13_main+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        main_So_L0+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        main_So_L0+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        main_So_L0+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        main_So_L0+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;main.c,83 :: 		GLCD_OUT_DEC(60, 0 ,temp_res ,4, BLACK);
	MOVLW       60
	MOVWF       FARG_GLCD_OUT_DEC_glcd_x+0 
	CLRF        FARG_GLCD_OUT_DEC_glcd_y+0 
	MOVF        main_temp_res_L0+0, 0 
	MOVWF       FARG_GLCD_OUT_DEC_glcd_n+0 
	MOVF        main_temp_res_L0+1, 0 
	MOVWF       FARG_GLCD_OUT_DEC_glcd_n+1 
	MOVLW       0
	MOVWF       FARG_GLCD_OUT_DEC_glcd_n+2 
	MOVWF       FARG_GLCD_OUT_DEC_glcd_n+3 
	MOVLW       4
	MOVWF       FARG_GLCD_OUT_DEC_glcd_length+0 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_DEC_black_white+0 
	CALL        _GLCD_OUT_DEC+0, 0
;main.c,84 :: 		GLCD_OUT_STR(60, 10 ,txt_V1, BLACK);
	MOVLW       60
	MOVWF       FARG_GLCD_OUT_STR_glcd_x+0 
	MOVLW       10
	MOVWF       FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       main_txt_V1_L0+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(main_txt_V1_L0+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,85 :: 		GLCD_OUT_STR(60, 20 ,txt_So, BLACK);
	MOVLW       60
	MOVWF       FARG_GLCD_OUT_STR_glcd_x+0 
	MOVLW       20
	MOVWF       FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       main_txt_So_L0+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(main_txt_So_L0+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,86 :: 		GLCD_DISPLAY();
	CALL        _GLCD_DISPLAY+0, 0
;main.c,87 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main155:
	DECFSZ      R13, 1, 1
	BRA         L_main155
	DECFSZ      R12, 1, 1
	BRA         L_main155
	DECFSZ      R11, 1, 1
	BRA         L_main155
	NOP
	NOP
;main.c,107 :: 		}
	GOTO        L_main153
;main.c,109 :: 		}
	GOTO        $+0
; end of _main
