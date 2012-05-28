
_GLCD_INIT:

;glcd_jo.h,174 :: 		void GLCD_INIT()
;glcd_jo.h,176 :: 		GLCD_DataPort_Direction = 0x00;
	BCF         TRISB+0, 0 
;glcd_jo.h,177 :: 		GLCD_CS1_Direction = 0;
	BCF         TRISE2_bit+0, 2 
;glcd_jo.h,178 :: 		GLCD_CS2_Direction = 0;
	BCF         TRISE1_bit+0, 1 
;glcd_jo.h,179 :: 		GLCD_DI_Direction  = 0;
	BCF         TRISD5_bit+0, 5 
;glcd_jo.h,180 :: 		GLCD_RW_Direction  = 0;
	BCF         TRISD6_bit+0, 6 
;glcd_jo.h,181 :: 		GLCD_EN_Direction  = 0;
	BCF         TRISD7_bit+0, 7 
;glcd_jo.h,182 :: 		GLCD_RST_Direction = 0;
	BCF         TRISE0_bit+0, 0 
;glcd_jo.h,185 :: 		GLCD_RST = 1;
	BSF         RE0_bit+0, 0 
;glcd_jo.h,186 :: 		GLCD_CS1 = 1;
	BSF         RE2_bit+0, 2 
;glcd_jo.h,187 :: 		GLCD_CS2 = 1;
	BSF         RE1_bit+0, 1 
;glcd_jo.h,188 :: 		GLCD_DI = 0;		// Set for instruction
	BCF         RD5_bit+0, 5 
;glcd_jo.h,190 :: 		delayTime(10000);
	MOVLW       16
	MOVWF       FARG_delayTime_counter+0 
	MOVLW       39
	MOVWF       FARG_delayTime_counter+1 
	MOVLW       0
	MOVWF       FARG_delayTime_counter+2 
	MOVWF       FARG_delayTime_counter+3 
	CALL        _delayTime+0, 0
;glcd_jo.h,191 :: 		GLCD_OUT_CMD(0b11000000);
	MOVLW       192
	MOVWF       FARG_GLCD_OUT_CMD_glcd_cmd+0 
	CALL        _GLCD_OUT_CMD+0, 0
;glcd_jo.h,193 :: 		delayTime(10000);
	MOVLW       16
	MOVWF       FARG_delayTime_counter+0 
	MOVLW       39
	MOVWF       FARG_delayTime_counter+1 
	MOVLW       0
	MOVWF       FARG_delayTime_counter+2 
	MOVWF       FARG_delayTime_counter+3 
	CALL        _delayTime+0, 0
;glcd_jo.h,194 :: 		GLCD_OUT_CMD(0b01000000);
	MOVLW       64
	MOVWF       FARG_GLCD_OUT_CMD_glcd_cmd+0 
	CALL        _GLCD_OUT_CMD+0, 0
;glcd_jo.h,196 :: 		delayTime(10000);
	MOVLW       16
	MOVWF       FARG_delayTime_counter+0 
	MOVLW       39
	MOVWF       FARG_delayTime_counter+1 
	MOVLW       0
	MOVWF       FARG_delayTime_counter+2 
	MOVWF       FARG_delayTime_counter+3 
	CALL        _delayTime+0, 0
;glcd_jo.h,197 :: 		GLCD_OUT_CMD(0b10111000);
	MOVLW       184
	MOVWF       FARG_GLCD_OUT_CMD_glcd_cmd+0 
	CALL        _GLCD_OUT_CMD+0, 0
;glcd_jo.h,199 :: 		delayTime(10000);
	MOVLW       16
	MOVWF       FARG_delayTime_counter+0 
	MOVLW       39
	MOVWF       FARG_delayTime_counter+1 
	MOVLW       0
	MOVWF       FARG_delayTime_counter+2 
	MOVWF       FARG_delayTime_counter+3 
	CALL        _delayTime+0, 0
;glcd_jo.h,200 :: 		GLCD_OUT_CMD(0b00111111);
	MOVLW       63
	MOVWF       FARG_GLCD_OUT_CMD_glcd_cmd+0 
	CALL        _GLCD_OUT_CMD+0, 0
;glcd_jo.h,202 :: 		GLCD_CS1 = 0;		//Disable the CS1 of display
	BCF         RE2_bit+0, 2 
;glcd_jo.h,203 :: 		GLCD_CS2 = 0;       //Disable the CS2 of display
	BCF         RE1_bit+0, 1 
;glcd_jo.h,204 :: 		}
	RETURN      0
; end of _GLCD_INIT

_GLCD_FILL:

;glcd_jo.h,214 :: 		void GLCD_FILL(unsigned char black_white)
;glcd_jo.h,217 :: 		for(index=0;index<1024;index++)
	CLRF        GLCD_FILL_index_L0+0 
	CLRF        GLCD_FILL_index_L0+1 
L_GLCD_FILL0:
	MOVLW       4
	SUBWF       GLCD_FILL_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_FILL155
	MOVLW       0
	SUBWF       GLCD_FILL_index_L0+0, 0 
L__GLCD_FILL155:
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_FILL1
;glcd_jo.h,219 :: 		glcd_buff[index] = black_white;
	MOVLW       _glcd_buff+0
	ADDWF       GLCD_FILL_index_L0+0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_glcd_buff+0)
	ADDWFC      GLCD_FILL_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_GLCD_FILL_black_white+0, 0 
	MOVWF       POSTINC1+0 
;glcd_jo.h,217 :: 		for(index=0;index<1024;index++)
	INFSNZ      GLCD_FILL_index_L0+0, 1 
	INCF        GLCD_FILL_index_L0+1, 1 
;glcd_jo.h,220 :: 		}
	GOTO        L_GLCD_FILL0
L_GLCD_FILL1:
;glcd_jo.h,221 :: 		GLCD_DISPLAY();
	CALL        _GLCD_DISPLAY+0, 0
;glcd_jo.h,222 :: 		}
	RETURN      0
; end of _GLCD_FILL

_GLCD_DISPLAY:

;glcd_jo.h,231 :: 		void GLCD_DISPLAY()
;glcd_jo.h,233 :: 		for(glcd_address = 0; glcd_address < 1024; glcd_address++)
	CLRF        _glcd_address+0 
	CLRF        _glcd_address+1 
L_GLCD_DISPLAY3:
	MOVLW       4
	SUBWF       _glcd_address+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DISPLAY156
	MOVLW       0
	SUBWF       _glcd_address+0, 0 
L__GLCD_DISPLAY156:
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DISPLAY4
;glcd_jo.h,235 :: 		if(glcd_column == 128)
	MOVF        _glcd_column+0, 0 
	XORLW       128
	BTFSS       STATUS+0, 2 
	GOTO        L_GLCD_DISPLAY6
;glcd_jo.h,237 :: 		glcd_column = 0;
	CLRF        _glcd_column+0 
;glcd_jo.h,238 :: 		glcd_line++;
	INCF        _glcd_line+0, 1 
;glcd_jo.h,242 :: 		GLCD_CS1 = 1;       //Enable the CS1 of the display
	BSF         RE2_bit+0, 2 
;glcd_jo.h,243 :: 		GLCD_CS2 = 1;		//Enable the CS2 of the display
	BSF         RE1_bit+0, 1 
;glcd_jo.h,245 :: 		glcd_line &= 0x07;
	MOVLW       7
	ANDWF       _glcd_line+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _glcd_line+0 
;glcd_jo.h,246 :: 		glcd_line |= 0xB8;
	MOVLW       184
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _glcd_line+0 
;glcd_jo.h,248 :: 		GLCD_OUT_CMD(glcd_line);
	MOVF        R0, 0 
	MOVWF       FARG_GLCD_OUT_CMD_glcd_cmd+0 
	CALL        _GLCD_OUT_CMD+0, 0
;glcd_jo.h,250 :: 		GLCD_OUT_CMD(0b01000000);
	MOVLW       64
	MOVWF       FARG_GLCD_OUT_CMD_glcd_cmd+0 
	CALL        _GLCD_OUT_CMD+0, 0
;glcd_jo.h,251 :: 		}
L_GLCD_DISPLAY6:
;glcd_jo.h,253 :: 		if(glcd_column <= 63)
	MOVF        _glcd_column+0, 0 
	SUBLW       63
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DISPLAY7
;glcd_jo.h,254 :: 		GLCD_CS1_ENABLE();
	CALL        _GLCD_CS1_ENABLE+0, 0
L_GLCD_DISPLAY7:
;glcd_jo.h,256 :: 		if(glcd_column >= 64)
	MOVLW       64
	SUBWF       _glcd_column+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DISPLAY8
;glcd_jo.h,257 :: 		GLCD_CS2_ENABLE();
	CALL        _GLCD_CS2_ENABLE+0, 0
L_GLCD_DISPLAY8:
;glcd_jo.h,259 :: 		GLCD_OUT_DATA(glcd_buff[glcd_address]);
	MOVLW       _glcd_buff+0
	ADDWF       _glcd_address+0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_glcd_buff+0)
	ADDWFC      _glcd_address+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_GLCD_OUT_DATA_glcd_data+0 
	CALL        _GLCD_OUT_DATA+0, 0
;glcd_jo.h,261 :: 		glcd_column++;
	INCF        _glcd_column+0, 1 
;glcd_jo.h,233 :: 		for(glcd_address = 0; glcd_address < 1024; glcd_address++)
	INFSNZ      _glcd_address+0, 1 
	INCF        _glcd_address+1, 1 
;glcd_jo.h,262 :: 		}
	GOTO        L_GLCD_DISPLAY3
L_GLCD_DISPLAY4:
;glcd_jo.h,263 :: 		}
	RETURN      0
; end of _GLCD_DISPLAY

_GLCD_CS1_ENABLE:

;glcd_jo.h,273 :: 		void GLCD_CS1_ENABLE()
;glcd_jo.h,275 :: 		GLCD_CS1 = 1; //Enable the CS1 of the display
	BSF         RE2_bit+0, 2 
;glcd_jo.h,276 :: 		GLCD_CS2 = 0; //Disable the CS2 of the display
	BCF         RE1_bit+0, 1 
;glcd_jo.h,277 :: 		}
	RETURN      0
; end of _GLCD_CS1_ENABLE

_GLCD_CS2_ENABLE:

;glcd_jo.h,287 :: 		void GLCD_CS2_ENABLE()
;glcd_jo.h,289 :: 		GLCD_CS2 = 1; //Enable the CS2 of the display
	BSF         RE1_bit+0, 1 
;glcd_jo.h,290 :: 		GLCD_CS1 = 0; //Disable the CS1 of the display
	BCF         RE2_bit+0, 2 
;glcd_jo.h,291 :: 		}
	RETURN      0
; end of _GLCD_CS2_ENABLE

_GLCD_OUT_CMD:

;glcd_jo.h,301 :: 		void GLCD_OUT_CMD(unsigned char glcd_cmd)
;glcd_jo.h,303 :: 		GLCD_DI = 0;   //Clear RS. Command mode
	BCF         RD5_bit+0, 5 
;glcd_jo.h,304 :: 		GLCD_EN = 1;   //lcd 'E' pin high
	BSF         RD7_bit+0, 7 
;glcd_jo.h,305 :: 		GLCD_data_PORT = glcd_cmd;
	MOVF        FARG_GLCD_OUT_CMD_glcd_cmd+0, 0 
	MOVWF       PORTB+0 
;glcd_jo.h,306 :: 		GLCD_data_PORT = glcd_cmd;
	MOVF        FARG_GLCD_OUT_CMD_glcd_cmd+0, 0 
	MOVWF       PORTB+0 
;glcd_jo.h,307 :: 		GLCD_data_PORT = glcd_cmd;
	MOVF        FARG_GLCD_OUT_CMD_glcd_cmd+0, 0 
	MOVWF       PORTB+0 
;glcd_jo.h,308 :: 		GLCD_data_PORT = glcd_cmd;
	MOVF        FARG_GLCD_OUT_CMD_glcd_cmd+0, 0 
	MOVWF       PORTB+0 
;glcd_jo.h,309 :: 		GLCD_EN = 0;   //lcd 'E' pin low
	BCF         RD7_bit+0, 7 
;glcd_jo.h,310 :: 		}
	RETURN      0
; end of _GLCD_OUT_CMD

_GLCD_OUT_DATA:

;glcd_jo.h,320 :: 		void GLCD_OUT_DATA(unsigned char glcd_data)
;glcd_jo.h,322 :: 		GLCD_DI = 1;
	BSF         RD5_bit+0, 5 
;glcd_jo.h,323 :: 		GLCD_EN = 1;	//lcd 'E' pin high
	BSF         RD7_bit+0, 7 
;glcd_jo.h,324 :: 		GLCD_data_PORT = glcd_data;
	MOVF        FARG_GLCD_OUT_DATA_glcd_data+0, 0 
	MOVWF       PORTB+0 
;glcd_jo.h,325 :: 		GLCD_data_PORT = glcd_data;
	MOVF        FARG_GLCD_OUT_DATA_glcd_data+0, 0 
	MOVWF       PORTB+0 
;glcd_jo.h,326 :: 		GLCD_data_PORT = glcd_data;
	MOVF        FARG_GLCD_OUT_DATA_glcd_data+0, 0 
	MOVWF       PORTB+0 
;glcd_jo.h,327 :: 		GLCD_data_PORT = glcd_data;
	MOVF        FARG_GLCD_OUT_DATA_glcd_data+0, 0 
	MOVWF       PORTB+0 
;glcd_jo.h,328 :: 		GLCD_EN = 0;	//lcd 'E' pin low
	BCF         RD7_bit+0, 7 
;glcd_jo.h,329 :: 		}
	RETURN      0
; end of _GLCD_OUT_DATA

_GLCD_POINT_DRW:

;glcd_jo.h,339 :: 		void GLCD_POINT_DRW(unsigned char x, unsigned char y)
;glcd_jo.h,343 :: 		temp = x + ((y >> 3) << 7);
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
L__GLCD_POINT_DRW157:
	BZ          L__GLCD_POINT_DRW158
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__GLCD_POINT_DRW157
L__GLCD_POINT_DRW158:
	MOVF        FARG_GLCD_POINT_DRW_x+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
;glcd_jo.h,344 :: 		h_line = (unsigned char)(y & 0x07);
	MOVLW       7
	ANDWF       FARG_GLCD_POINT_DRW_y+0, 0 
	MOVWF       R0 
;glcd_jo.h,345 :: 		glcd_buff[temp] |= (1<<h_line);
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
L__GLCD_POINT_DRW159:
	BZ          L__GLCD_POINT_DRW160
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__GLCD_POINT_DRW159
L__GLCD_POINT_DRW160:
	MOVFF       R4, FSR0L
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	IORWF       R0, 1 
	MOVFF       R4, FSR1L
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;glcd_jo.h,346 :: 		}
	RETURN      0
; end of _GLCD_POINT_DRW

_GLCD_POINT_CLR:

;glcd_jo.h,356 :: 		void GLCD_POINT_CLR(unsigned char x, unsigned char y)
;glcd_jo.h,360 :: 		temp = x + ((y >> 3) << 7);
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
L__GLCD_POINT_CLR161:
	BZ          L__GLCD_POINT_CLR162
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__GLCD_POINT_CLR161
L__GLCD_POINT_CLR162:
	MOVF        FARG_GLCD_POINT_CLR_x+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
;glcd_jo.h,361 :: 		h_line = (unsigned char)(y & 0x07);
	MOVLW       7
	ANDWF       FARG_GLCD_POINT_CLR_y+0, 0 
	MOVWF       R0 
;glcd_jo.h,362 :: 		glcd_buff[temp] &= ~(1<<h_line);
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
L__GLCD_POINT_CLR163:
	BZ          L__GLCD_POINT_CLR164
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__GLCD_POINT_CLR163
L__GLCD_POINT_CLR164:
	COMF        R0, 1 
	MOVFF       R4, FSR0L
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	ANDWF       R0, 1 
	MOVFF       R4, FSR1L
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;glcd_jo.h,363 :: 		}
	RETURN      0
; end of _GLCD_POINT_CLR

_GLCD_DRW_REC_EMPTY:

;glcd_jo.h,376 :: 		void GLCD_DRW_REC_EMPTY(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char black_white)
;glcd_jo.h,379 :: 		if(x1 > x2)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x1+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_EMPTY_x2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_EMPTY9
;glcd_jo.h,381 :: 		glcd_temp = x1;
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x1+0, 0 
	MOVWF       GLCD_DRW_REC_EMPTY_glcd_temp_L0+0 
;glcd_jo.h,382 :: 		x1 = x2;
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x2+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_EMPTY_x1+0 
;glcd_jo.h,383 :: 		x2 = glcd_temp;
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_EMPTY_x2+0 
;glcd_jo.h,384 :: 		}
L_GLCD_DRW_REC_EMPTY9:
;glcd_jo.h,385 :: 		if(y1 > y2)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y1+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_EMPTY_y2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_EMPTY10
;glcd_jo.h,387 :: 		glcd_temp = y1;
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y1+0, 0 
	MOVWF       GLCD_DRW_REC_EMPTY_glcd_temp_L0+0 
;glcd_jo.h,388 :: 		y1 = y2;
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y2+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_EMPTY_y1+0 
;glcd_jo.h,389 :: 		y2 = glcd_temp;
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_EMPTY_y2+0 
;glcd_jo.h,390 :: 		}
L_GLCD_DRW_REC_EMPTY10:
;glcd_jo.h,391 :: 		if(black_white)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_REC_EMPTY11
;glcd_jo.h,393 :: 		for(glcd_temp=x1;glcd_temp<=x2;glcd_temp++)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x1+0, 0 
	MOVWF       GLCD_DRW_REC_EMPTY_glcd_temp_L0+0 
L_GLCD_DRW_REC_EMPTY12:
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_EMPTY_x2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_EMPTY13
;glcd_jo.h,395 :: 		GLCD_POINT_DRW(glcd_temp,y1);
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y1+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_jo.h,396 :: 		GLCD_POINT_DRW(glcd_temp,y2);
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y2+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_jo.h,393 :: 		for(glcd_temp=x1;glcd_temp<=x2;glcd_temp++)
	INCF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 1 
;glcd_jo.h,397 :: 		}
	GOTO        L_GLCD_DRW_REC_EMPTY12
L_GLCD_DRW_REC_EMPTY13:
;glcd_jo.h,398 :: 		for(glcd_temp=y1;glcd_temp<=y2;glcd_temp++)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y1+0, 0 
	MOVWF       GLCD_DRW_REC_EMPTY_glcd_temp_L0+0 
L_GLCD_DRW_REC_EMPTY15:
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_EMPTY_y2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_EMPTY16
;glcd_jo.h,400 :: 		GLCD_POINT_DRW(x1,glcd_temp);
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x1+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_jo.h,401 :: 		GLCD_POINT_DRW(x2,glcd_temp);
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x2+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
;glcd_jo.h,398 :: 		for(glcd_temp=y1;glcd_temp<=y2;glcd_temp++)
	INCF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 1 
;glcd_jo.h,402 :: 		}
	GOTO        L_GLCD_DRW_REC_EMPTY15
L_GLCD_DRW_REC_EMPTY16:
;glcd_jo.h,403 :: 		}
	GOTO        L_GLCD_DRW_REC_EMPTY18
L_GLCD_DRW_REC_EMPTY11:
;glcd_jo.h,406 :: 		for(glcd_temp=x1;glcd_temp<=x2;glcd_temp++)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x1+0, 0 
	MOVWF       GLCD_DRW_REC_EMPTY_glcd_temp_L0+0 
L_GLCD_DRW_REC_EMPTY19:
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_EMPTY_x2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_EMPTY20
;glcd_jo.h,408 :: 		GLCD_POINT_CLR(glcd_temp,y1);
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y1+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_jo.h,409 :: 		GLCD_POINT_CLR(glcd_temp,y2);
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y2+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_jo.h,406 :: 		for(glcd_temp=x1;glcd_temp<=x2;glcd_temp++)
	INCF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 1 
;glcd_jo.h,410 :: 		}
	GOTO        L_GLCD_DRW_REC_EMPTY19
L_GLCD_DRW_REC_EMPTY20:
;glcd_jo.h,411 :: 		for(glcd_temp=y1;glcd_temp<=y2;glcd_temp++)
	MOVF        FARG_GLCD_DRW_REC_EMPTY_y1+0, 0 
	MOVWF       GLCD_DRW_REC_EMPTY_glcd_temp_L0+0 
L_GLCD_DRW_REC_EMPTY22:
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_EMPTY_y2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_EMPTY23
;glcd_jo.h,413 :: 		GLCD_POINT_CLR(x1,glcd_temp);
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x1+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_jo.h,414 :: 		GLCD_POINT_CLR(x2,glcd_temp);
	MOVF        FARG_GLCD_DRW_REC_EMPTY_x2+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
;glcd_jo.h,411 :: 		for(glcd_temp=y1;glcd_temp<=y2;glcd_temp++)
	INCF        GLCD_DRW_REC_EMPTY_glcd_temp_L0+0, 1 
;glcd_jo.h,415 :: 		}
	GOTO        L_GLCD_DRW_REC_EMPTY22
L_GLCD_DRW_REC_EMPTY23:
;glcd_jo.h,416 :: 		}
L_GLCD_DRW_REC_EMPTY18:
;glcd_jo.h,417 :: 		}
	RETURN      0
; end of _GLCD_DRW_REC_EMPTY

_GLCD_DRW_REC_SOLID:

;glcd_jo.h,429 :: 		void GLCD_DRW_REC_SOLID(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char black_white)
;glcd_jo.h,433 :: 		if(x1 > x2)
	MOVF        FARG_GLCD_DRW_REC_SOLID_x1+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_SOLID_x2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_SOLID25
;glcd_jo.h,435 :: 		glcd_temp = x1;
	MOVF        FARG_GLCD_DRW_REC_SOLID_x1+0, 0 
	MOVWF       GLCD_DRW_REC_SOLID_glcd_temp_L0+0 
;glcd_jo.h,436 :: 		x1 = x2;
	MOVF        FARG_GLCD_DRW_REC_SOLID_x2+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_SOLID_x1+0 
;glcd_jo.h,437 :: 		x2 = glcd_temp;
	MOVF        GLCD_DRW_REC_SOLID_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_SOLID_x2+0 
;glcd_jo.h,438 :: 		}
L_GLCD_DRW_REC_SOLID25:
;glcd_jo.h,439 :: 		if(y1 > y2)
	MOVF        FARG_GLCD_DRW_REC_SOLID_y1+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_SOLID_y2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_SOLID26
;glcd_jo.h,441 :: 		glcd_temp = y1;
	MOVF        FARG_GLCD_DRW_REC_SOLID_y1+0, 0 
	MOVWF       GLCD_DRW_REC_SOLID_glcd_temp_L0+0 
;glcd_jo.h,442 :: 		y1 = y2;
	MOVF        FARG_GLCD_DRW_REC_SOLID_y2+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_SOLID_y1+0 
;glcd_jo.h,443 :: 		y2 = glcd_temp;
	MOVF        GLCD_DRW_REC_SOLID_glcd_temp_L0+0, 0 
	MOVWF       FARG_GLCD_DRW_REC_SOLID_y2+0 
;glcd_jo.h,444 :: 		}
L_GLCD_DRW_REC_SOLID26:
;glcd_jo.h,445 :: 		for(i=x1;i<=x2;i++)
	MOVF        FARG_GLCD_DRW_REC_SOLID_x1+0, 0 
	MOVWF       GLCD_DRW_REC_SOLID_i_L0+0 
L_GLCD_DRW_REC_SOLID27:
	MOVF        GLCD_DRW_REC_SOLID_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_SOLID_x2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_SOLID28
;glcd_jo.h,446 :: 		for(j=y1;j<=y2;j++)
	MOVF        FARG_GLCD_DRW_REC_SOLID_y1+0, 0 
	MOVWF       GLCD_DRW_REC_SOLID_j_L0+0 
L_GLCD_DRW_REC_SOLID30:
	MOVF        GLCD_DRW_REC_SOLID_j_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_REC_SOLID_y2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_REC_SOLID31
;glcd_jo.h,448 :: 		if(black_white)
	MOVF        FARG_GLCD_DRW_REC_SOLID_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_REC_SOLID33
;glcd_jo.h,449 :: 		GLCD_POINT_DRW(i,j);
	MOVF        GLCD_DRW_REC_SOLID_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_REC_SOLID_j_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
	GOTO        L_GLCD_DRW_REC_SOLID34
L_GLCD_DRW_REC_SOLID33:
;glcd_jo.h,451 :: 		GLCD_POINT_CLR(i,j);
	MOVF        GLCD_DRW_REC_SOLID_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_REC_SOLID_j_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
L_GLCD_DRW_REC_SOLID34:
;glcd_jo.h,446 :: 		for(j=y1;j<=y2;j++)
	INCF        GLCD_DRW_REC_SOLID_j_L0+0, 1 
;glcd_jo.h,452 :: 		}
	GOTO        L_GLCD_DRW_REC_SOLID30
L_GLCD_DRW_REC_SOLID31:
;glcd_jo.h,445 :: 		for(i=x1;i<=x2;i++)
	INCF        GLCD_DRW_REC_SOLID_i_L0+0, 1 
;glcd_jo.h,452 :: 		}
	GOTO        L_GLCD_DRW_REC_SOLID27
L_GLCD_DRW_REC_SOLID28:
;glcd_jo.h,453 :: 		}
	RETURN      0
; end of _GLCD_DRW_REC_SOLID

_GLCD_DRW_LINE:

;glcd_jo.h,465 :: 		void GLCD_DRW_LINE(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char black_white)
;glcd_jo.h,470 :: 		if(x2 == x1)
	MOVF        FARG_GLCD_DRW_LINE_x2+0, 0 
	XORWF       FARG_GLCD_DRW_LINE_x1+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_GLCD_DRW_LINE35
;glcd_jo.h,472 :: 		if(y2 >= y1)
	MOVF        FARG_GLCD_DRW_LINE_y1+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_y2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_LINE36
;glcd_jo.h,473 :: 		for(i=y1;i<=y2;i++)
	MOVF        FARG_GLCD_DRW_LINE_y1+0, 0 
	MOVWF       GLCD_DRW_LINE_i_L0+0 
L_GLCD_DRW_LINE37:
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_y2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_LINE38
;glcd_jo.h,474 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_LINE_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_LINE40
;glcd_jo.h,475 :: 		GLCD_POINT_DRW(x1,i);
	MOVF        FARG_GLCD_DRW_LINE_x1+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
	GOTO        L_GLCD_DRW_LINE41
L_GLCD_DRW_LINE40:
;glcd_jo.h,477 :: 		GLCD_POINT_CLR(x1,i);
	MOVF        FARG_GLCD_DRW_LINE_x1+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
L_GLCD_DRW_LINE41:
;glcd_jo.h,473 :: 		for(i=y1;i<=y2;i++)
	INCF        GLCD_DRW_LINE_i_L0+0, 1 
;glcd_jo.h,477 :: 		GLCD_POINT_CLR(x1,i);
	GOTO        L_GLCD_DRW_LINE37
L_GLCD_DRW_LINE38:
	GOTO        L_GLCD_DRW_LINE42
L_GLCD_DRW_LINE36:
;glcd_jo.h,479 :: 		for(i=y2;i<=y1;i++)
	MOVF        FARG_GLCD_DRW_LINE_y2+0, 0 
	MOVWF       GLCD_DRW_LINE_i_L0+0 
L_GLCD_DRW_LINE43:
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_y1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_LINE44
;glcd_jo.h,480 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_LINE_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_LINE46
;glcd_jo.h,481 :: 		GLCD_POINT_DRW(x1,i);
	MOVF        FARG_GLCD_DRW_LINE_x1+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_x+0 
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_DRW_y+0 
	CALL        _GLCD_POINT_DRW+0, 0
	GOTO        L_GLCD_DRW_LINE47
L_GLCD_DRW_LINE46:
;glcd_jo.h,483 :: 		GLCD_POINT_CLR(x1,i);
	MOVF        FARG_GLCD_DRW_LINE_x1+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_x+0 
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	MOVWF       FARG_GLCD_POINT_CLR_y+0 
	CALL        _GLCD_POINT_CLR+0, 0
L_GLCD_DRW_LINE47:
;glcd_jo.h,479 :: 		for(i=y2;i<=y1;i++)
	INCF        GLCD_DRW_LINE_i_L0+0, 1 
;glcd_jo.h,483 :: 		GLCD_POINT_CLR(x1,i);
	GOTO        L_GLCD_DRW_LINE43
L_GLCD_DRW_LINE44:
L_GLCD_DRW_LINE42:
;glcd_jo.h,484 :: 		}
	GOTO        L_GLCD_DRW_LINE48
L_GLCD_DRW_LINE35:
;glcd_jo.h,487 :: 		a = (float)(y2 - y1) / (float)(x2 - x1);
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
;glcd_jo.h,488 :: 		b = (float)(y2 - a*x2);
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
;glcd_jo.h,490 :: 		if(x2 > x1)
	MOVF        FARG_GLCD_DRW_LINE_x2+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_x1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_LINE49
;glcd_jo.h,492 :: 		for(i=x1;i<=x2;i++)
	MOVF        FARG_GLCD_DRW_LINE_x1+0, 0 
	MOVWF       GLCD_DRW_LINE_i_L0+0 
L_GLCD_DRW_LINE50:
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_x2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_LINE51
;glcd_jo.h,493 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_LINE_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_LINE53
;glcd_jo.h,494 :: 		GLCD_POINT_DRW(i,(a*i + b));
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
	GOTO        L_GLCD_DRW_LINE54
L_GLCD_DRW_LINE53:
;glcd_jo.h,496 :: 		GLCD_POINT_CLR(i,(a*i + b));
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
L_GLCD_DRW_LINE54:
;glcd_jo.h,492 :: 		for(i=x1;i<=x2;i++)
	INCF        GLCD_DRW_LINE_i_L0+0, 1 
;glcd_jo.h,496 :: 		GLCD_POINT_CLR(i,(a*i + b));
	GOTO        L_GLCD_DRW_LINE50
L_GLCD_DRW_LINE51:
;glcd_jo.h,497 :: 		}
	GOTO        L_GLCD_DRW_LINE55
L_GLCD_DRW_LINE49:
;glcd_jo.h,500 :: 		for(i=x2;i<=x1;i++)
	MOVF        FARG_GLCD_DRW_LINE_x2+0, 0 
	MOVWF       GLCD_DRW_LINE_i_L0+0 
L_GLCD_DRW_LINE56:
	MOVF        GLCD_DRW_LINE_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_LINE_x1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_LINE57
;glcd_jo.h,501 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_LINE_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_LINE59
;glcd_jo.h,502 :: 		GLCD_POINT_DRW(i,(a*i + b));
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
	GOTO        L_GLCD_DRW_LINE60
L_GLCD_DRW_LINE59:
;glcd_jo.h,504 :: 		GLCD_POINT_CLR(i,(a*i + b));
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
L_GLCD_DRW_LINE60:
;glcd_jo.h,500 :: 		for(i=x2;i<=x1;i++)
	INCF        GLCD_DRW_LINE_i_L0+0, 1 
;glcd_jo.h,504 :: 		GLCD_POINT_CLR(i,(a*i + b));
	GOTO        L_GLCD_DRW_LINE56
L_GLCD_DRW_LINE57:
;glcd_jo.h,505 :: 		}
L_GLCD_DRW_LINE55:
;glcd_jo.h,506 :: 		}
L_GLCD_DRW_LINE48:
;glcd_jo.h,507 :: 		}
	RETURN      0
; end of _GLCD_DRW_LINE

_GLCD_DRW_VECTOR:

;glcd_jo.h,518 :: 		void GLCD_DRW_VECTOR(unsigned char x1, unsigned char y1, unsigned int angle, unsigned char length, unsigned char black_white)
;glcd_jo.h,524 :: 		if(angle == 0)
	MOVLW       0
	XORWF       FARG_GLCD_DRW_VECTOR_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR165
	MOVLW       0
	XORWF       FARG_GLCD_DRW_VECTOR_angle+0, 0 
L__GLCD_DRW_VECTOR165:
	BTFSS       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR61
;glcd_jo.h,526 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_VECTOR_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR62
;glcd_jo.h,527 :: 		GLCD_DRW_LINE(x1,y1,x1,y1-length,1);
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
	GOTO        L_GLCD_DRW_VECTOR63
L_GLCD_DRW_VECTOR62:
;glcd_jo.h,529 :: 		GLCD_DRW_LINE(x1,y1,x1,y1-length,0);
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
L_GLCD_DRW_VECTOR63:
;glcd_jo.h,530 :: 		}
	GOTO        L_GLCD_DRW_VECTOR64
L_GLCD_DRW_VECTOR61:
;glcd_jo.h,531 :: 		else if(angle == 90)
	MOVLW       0
	XORWF       FARG_GLCD_DRW_VECTOR_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR166
	MOVLW       90
	XORWF       FARG_GLCD_DRW_VECTOR_angle+0, 0 
L__GLCD_DRW_VECTOR166:
	BTFSS       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR65
;glcd_jo.h,533 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_VECTOR_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR66
;glcd_jo.h,534 :: 		GLCD_DRW_LINE(x1,y1,x1+length,y1,1);
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
	GOTO        L_GLCD_DRW_VECTOR67
L_GLCD_DRW_VECTOR66:
;glcd_jo.h,536 :: 		GLCD_DRW_LINE(x1,y1,x1+length,y1,0);
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
L_GLCD_DRW_VECTOR67:
;glcd_jo.h,537 :: 		}
	GOTO        L_GLCD_DRW_VECTOR68
L_GLCD_DRW_VECTOR65:
;glcd_jo.h,538 :: 		else if(angle == 180)
	MOVLW       0
	XORWF       FARG_GLCD_DRW_VECTOR_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR167
	MOVLW       180
	XORWF       FARG_GLCD_DRW_VECTOR_angle+0, 0 
L__GLCD_DRW_VECTOR167:
	BTFSS       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR69
;glcd_jo.h,540 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_VECTOR_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR70
;glcd_jo.h,541 :: 		GLCD_DRW_LINE(x1,y1,x1,y1+length,1);
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
	GOTO        L_GLCD_DRW_VECTOR71
L_GLCD_DRW_VECTOR70:
;glcd_jo.h,543 :: 		GLCD_DRW_LINE(x1,y1,x1,y1+length,0);
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
L_GLCD_DRW_VECTOR71:
;glcd_jo.h,544 :: 		}
	GOTO        L_GLCD_DRW_VECTOR72
L_GLCD_DRW_VECTOR69:
;glcd_jo.h,545 :: 		else if(angle == 270)
	MOVF        FARG_GLCD_DRW_VECTOR_angle+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR168
	MOVLW       14
	XORWF       FARG_GLCD_DRW_VECTOR_angle+0, 0 
L__GLCD_DRW_VECTOR168:
	BTFSS       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR73
;glcd_jo.h,547 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_VECTOR_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR74
;glcd_jo.h,548 :: 		GLCD_DRW_LINE(x1,y1,x1-length,y1,1);
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
	GOTO        L_GLCD_DRW_VECTOR75
L_GLCD_DRW_VECTOR74:
;glcd_jo.h,550 :: 		GLCD_DRW_LINE(x1,y1,x1-length,y1,0);
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
L_GLCD_DRW_VECTOR75:
;glcd_jo.h,551 :: 		}
	GOTO        L_GLCD_DRW_VECTOR76
L_GLCD_DRW_VECTOR73:
;glcd_jo.h,554 :: 		if(angle < 180)
	MOVLW       0
	SUBWF       FARG_GLCD_DRW_VECTOR_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR169
	MOVLW       180
	SUBWF       FARG_GLCD_DRW_VECTOR_angle+0, 0 
L__GLCD_DRW_VECTOR169:
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_VECTOR77
;glcd_jo.h,555 :: 		goc = ((double)(angle*3.14)/180);
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
	GOTO        L_GLCD_DRW_VECTOR78
L_GLCD_DRW_VECTOR77:
;glcd_jo.h,557 :: 		goc = ((double)((360 - angle)*3.14)/180);
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
L_GLCD_DRW_VECTOR78:
;glcd_jo.h,559 :: 		x_max = (char)(length*sin(goc));
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
;glcd_jo.h,561 :: 		a = 1/tan(goc);
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
;glcd_jo.h,562 :: 		if(angle < 180)
	MOVLW       0
	SUBWF       FARG_GLCD_DRW_VECTOR_angle+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR170
	MOVLW       180
	SUBWF       FARG_GLCD_DRW_VECTOR_angle+0, 0 
L__GLCD_DRW_VECTOR170:
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_VECTOR79
;glcd_jo.h,563 :: 		for(i=x1;i<=x1+x_max;i++)
	MOVF        FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       GLCD_DRW_VECTOR_i_L0+0 
	MOVLW       0
	MOVWF       GLCD_DRW_VECTOR_i_L0+1 
L_GLCD_DRW_VECTOR80:
	MOVF        GLCD_DRW_VECTOR_x_max_L0+0, 0 
	ADDWF       FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVF        GLCD_DRW_VECTOR_i_L0+1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR171
	MOVF        GLCD_DRW_VECTOR_i_L0+0, 0 
	SUBWF       R1, 0 
L__GLCD_DRW_VECTOR171:
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_VECTOR81
;glcd_jo.h,565 :: 		if(black_white)
	MOVF        FARG_GLCD_DRW_VECTOR_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR83
;glcd_jo.h,566 :: 		GLCD_POINT_DRW(i,(unsigned char)(y1 - a*(i-x1)));
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
	GOTO        L_GLCD_DRW_VECTOR84
L_GLCD_DRW_VECTOR83:
;glcd_jo.h,568 :: 		GLCD_POINT_CLR(i,(unsigned char)(y1 - a*(i-x1)));
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
L_GLCD_DRW_VECTOR84:
;glcd_jo.h,563 :: 		for(i=x1;i<=x1+x_max;i++)
	INFSNZ      GLCD_DRW_VECTOR_i_L0+0, 1 
	INCF        GLCD_DRW_VECTOR_i_L0+1, 1 
;glcd_jo.h,569 :: 		}
	GOTO        L_GLCD_DRW_VECTOR80
L_GLCD_DRW_VECTOR81:
	GOTO        L_GLCD_DRW_VECTOR85
L_GLCD_DRW_VECTOR79:
;glcd_jo.h,571 :: 		for(i=(x1-x_max);i<=x1;i++)
	MOVF        GLCD_DRW_VECTOR_x_max_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_VECTOR_x1+0, 0 
	MOVWF       GLCD_DRW_VECTOR_i_L0+0 
	CLRF        GLCD_DRW_VECTOR_i_L0+1 
	MOVLW       0
	SUBWFB      GLCD_DRW_VECTOR_i_L0+1, 1 
L_GLCD_DRW_VECTOR86:
	MOVLW       0
	MOVWF       R0 
	MOVF        GLCD_DRW_VECTOR_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_DRW_VECTOR172
	MOVF        GLCD_DRW_VECTOR_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_VECTOR_x1+0, 0 
L__GLCD_DRW_VECTOR172:
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_VECTOR87
;glcd_jo.h,573 :: 		if(black_white)
	MOVF        FARG_GLCD_DRW_VECTOR_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_VECTOR89
;glcd_jo.h,574 :: 		GLCD_POINT_DRW(i,(unsigned char)(y1 - a*(x1-i)));
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
	GOTO        L_GLCD_DRW_VECTOR90
L_GLCD_DRW_VECTOR89:
;glcd_jo.h,576 :: 		GLCD_POINT_CLR(i,(unsigned char)(y1 - a*(x1-i)));
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
L_GLCD_DRW_VECTOR90:
;glcd_jo.h,571 :: 		for(i=(x1-x_max);i<=x1;i++)
	INFSNZ      GLCD_DRW_VECTOR_i_L0+0, 1 
	INCF        GLCD_DRW_VECTOR_i_L0+1, 1 
;glcd_jo.h,577 :: 		}
	GOTO        L_GLCD_DRW_VECTOR86
L_GLCD_DRW_VECTOR87:
L_GLCD_DRW_VECTOR85:
;glcd_jo.h,578 :: 		}
L_GLCD_DRW_VECTOR76:
L_GLCD_DRW_VECTOR72:
L_GLCD_DRW_VECTOR68:
L_GLCD_DRW_VECTOR64:
;glcd_jo.h,579 :: 		}
	RETURN      0
; end of _GLCD_DRW_VECTOR

_GLCD_DRW_CIRCLE_EMPTY:

;glcd_jo.h,590 :: 		void GLCD_DRW_CIRCLE_EMPTY(unsigned char x, unsigned char y, unsigned char r, unsigned char black_white)
;glcd_jo.h,594 :: 		r2 = r*r;
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	MULWF       FARG_GLCD_DRW_CIRCLE_EMPTY_r+0 
	MOVF        PRODL+0, 0 
	MOVWF       GLCD_DRW_CIRCLE_EMPTY_r2_L0+0 
	MOVF        PRODH+0, 0 
	MOVWF       GLCD_DRW_CIRCLE_EMPTY_r2_L0+1 
;glcd_jo.h,595 :: 		for(i=0;i<=r;i++)
	CLRF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0 
L_GLCD_DRW_CIRCLE_EMPTY91:
	MOVF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_EMPTY_r+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_CIRCLE_EMPTY92
;glcd_jo.h,597 :: 		j = 0;
	CLRF        GLCD_DRW_CIRCLE_EMPTY_j_L0+0 
;glcd_jo.h,598 :: 		ri2 = (r-i)*(r-i);
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
;glcd_jo.h,600 :: 		while((ri2 + (r-j)*(r-j)) > r2)
L_GLCD_DRW_CIRCLE_EMPTY94:
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
	GOTO        L__GLCD_DRW_CIRCLE_EMPTY173
	MOVF        R2, 0 
	SUBWF       GLCD_DRW_CIRCLE_EMPTY_r2_L0+0, 0 
L__GLCD_DRW_CIRCLE_EMPTY173:
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_DRW_CIRCLE_EMPTY95
;glcd_jo.h,602 :: 		j++;
	INCF        GLCD_DRW_CIRCLE_EMPTY_j_L0+0, 1 
;glcd_jo.h,603 :: 		}
	GOTO        L_GLCD_DRW_CIRCLE_EMPTY94
L_GLCD_DRW_CIRCLE_EMPTY95:
;glcd_jo.h,605 :: 		if(black_white)
	MOVF        FARG_GLCD_DRW_CIRCLE_EMPTY_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_CIRCLE_EMPTY96
;glcd_jo.h,607 :: 		GLCD_POINT_DRW(x-r+i,y-r+j);
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
;glcd_jo.h,608 :: 		GLCD_POINT_DRW(x-r+i,y+r-j);
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
;glcd_jo.h,609 :: 		GLCD_POINT_DRW(x+r-i,y+r-j);
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
;glcd_jo.h,610 :: 		GLCD_POINT_DRW(x+r-i,y-r+j);
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
;glcd_jo.h,611 :: 		}
	GOTO        L_GLCD_DRW_CIRCLE_EMPTY97
L_GLCD_DRW_CIRCLE_EMPTY96:
;glcd_jo.h,614 :: 		GLCD_POINT_CLR(x-r+i,y-r+j);
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
;glcd_jo.h,615 :: 		GLCD_POINT_CLR(x-r+i,y+r-j);
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
;glcd_jo.h,616 :: 		GLCD_POINT_CLR(x+r-i,y+r-j);
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
;glcd_jo.h,617 :: 		GLCD_POINT_CLR(x+r-i,y-r+j);
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
;glcd_jo.h,618 :: 		}
L_GLCD_DRW_CIRCLE_EMPTY97:
;glcd_jo.h,595 :: 		for(i=0;i<=r;i++)
	INCF        GLCD_DRW_CIRCLE_EMPTY_i_L0+0, 1 
;glcd_jo.h,619 :: 		}
	GOTO        L_GLCD_DRW_CIRCLE_EMPTY91
L_GLCD_DRW_CIRCLE_EMPTY92:
;glcd_jo.h,620 :: 		}
	RETURN      0
; end of _GLCD_DRW_CIRCLE_EMPTY

_GLCD_DRW_CIRCLE_SOLID:

;glcd_jo.h,631 :: 		void GLCD_DRW_CIRCLE_SOLID(unsigned char x, unsigned char y, unsigned char r, unsigned char black_white)
;glcd_jo.h,635 :: 		r2 = r*r;
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	MULWF       FARG_GLCD_DRW_CIRCLE_SOLID_r+0 
	MOVF        PRODL+0, 0 
	MOVWF       GLCD_DRW_CIRCLE_SOLID_r2_L0+0 
	MOVF        PRODH+0, 0 
	MOVWF       GLCD_DRW_CIRCLE_SOLID_r2_L0+1 
;glcd_jo.h,636 :: 		for(i=0;i<=r;i++)
	CLRF        GLCD_DRW_CIRCLE_SOLID_i_L0+0 
L_GLCD_DRW_CIRCLE_SOLID98:
	MOVF        GLCD_DRW_CIRCLE_SOLID_i_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_CIRCLE_SOLID99
;glcd_jo.h,638 :: 		ri2 = (r-i)*(r-i);
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
;glcd_jo.h,639 :: 		for(j=0;j<=r;j++)
	CLRF        GLCD_DRW_CIRCLE_SOLID_j_L0+0 
L_GLCD_DRW_CIRCLE_SOLID101:
	MOVF        GLCD_DRW_CIRCLE_SOLID_j_L0+0, 0 
	SUBWF       FARG_GLCD_DRW_CIRCLE_SOLID_r+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_CIRCLE_SOLID102
;glcd_jo.h,641 :: 		if((ri2 + (r-j)*(r-j)) <= r2)
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
	GOTO        L__GLCD_DRW_CIRCLE_SOLID174
	MOVF        R2, 0 
	SUBWF       GLCD_DRW_CIRCLE_SOLID_r2_L0+0, 0 
L__GLCD_DRW_CIRCLE_SOLID174:
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_DRW_CIRCLE_SOLID104
;glcd_jo.h,643 :: 		if(black_white != 0)
	MOVF        FARG_GLCD_DRW_CIRCLE_SOLID_black_white+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_DRW_CIRCLE_SOLID105
;glcd_jo.h,645 :: 		GLCD_POINT_DRW(x-r+i,y-r+j);
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
;glcd_jo.h,646 :: 		GLCD_POINT_DRW(x-r+i,y+r-j);
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
;glcd_jo.h,647 :: 		GLCD_POINT_DRW(x+r-i,y+r-j);
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
;glcd_jo.h,648 :: 		GLCD_POINT_DRW(x+r-i,y-r+j);
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
;glcd_jo.h,649 :: 		}
	GOTO        L_GLCD_DRW_CIRCLE_SOLID106
L_GLCD_DRW_CIRCLE_SOLID105:
;glcd_jo.h,652 :: 		GLCD_POINT_CLR(x-r+i,y-r+j);
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
;glcd_jo.h,653 :: 		GLCD_POINT_CLR(x-r+i,y+r-j);
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
;glcd_jo.h,654 :: 		GLCD_POINT_CLR(x+r-i,y+r-j);
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
;glcd_jo.h,655 :: 		GLCD_POINT_CLR(x+r-i,y-r+j);
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
;glcd_jo.h,656 :: 		}
L_GLCD_DRW_CIRCLE_SOLID106:
;glcd_jo.h,657 :: 		}
L_GLCD_DRW_CIRCLE_SOLID104:
;glcd_jo.h,639 :: 		for(j=0;j<=r;j++)
	INCF        GLCD_DRW_CIRCLE_SOLID_j_L0+0, 1 
;glcd_jo.h,658 :: 		}
	GOTO        L_GLCD_DRW_CIRCLE_SOLID101
L_GLCD_DRW_CIRCLE_SOLID102:
;glcd_jo.h,636 :: 		for(i=0;i<=r;i++)
	INCF        GLCD_DRW_CIRCLE_SOLID_i_L0+0, 1 
;glcd_jo.h,659 :: 		}
	GOTO        L_GLCD_DRW_CIRCLE_SOLID98
L_GLCD_DRW_CIRCLE_SOLID99:
;glcd_jo.h,660 :: 		}
	RETURN      0
; end of _GLCD_DRW_CIRCLE_SOLID

_GLCD_CHAR_SET:

;glcd_jo.h,671 :: 		unsigned int GLCD_CHAR_SET(unsigned char glcd_x, unsigned char glcd_y, const char * glcd_font, unsigned char num)
;glcd_jo.h,677 :: 		add = (glcd_y / 8)*128 + glcd_x;
	MOVLW       3
	MOVWF       R0 
	MOVF        FARG_GLCD_CHAR_SET_glcd_y+0, 0 
	MOVWF       GLCD_CHAR_SET_add_L0+0 
	MOVLW       0
	MOVWF       GLCD_CHAR_SET_add_L0+1 
	MOVF        R0, 0 
L__GLCD_CHAR_SET175:
	BZ          L__GLCD_CHAR_SET176
	RRCF        GLCD_CHAR_SET_add_L0+0, 1 
	BCF         GLCD_CHAR_SET_add_L0+0, 7 
	ADDLW       255
	GOTO        L__GLCD_CHAR_SET175
L__GLCD_CHAR_SET176:
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       GLCD_CHAR_SET_add_L0+1 
	MOVF        R0, 0 
L__GLCD_CHAR_SET177:
	BZ          L__GLCD_CHAR_SET178
	RLCF        GLCD_CHAR_SET_add_L0+0, 1 
	BCF         GLCD_CHAR_SET_add_L0+0, 0 
	RLCF        GLCD_CHAR_SET_add_L0+1, 1 
	ADDLW       255
	GOTO        L__GLCD_CHAR_SET177
L__GLCD_CHAR_SET178:
	MOVF        FARG_GLCD_CHAR_SET_glcd_x+0, 0 
	ADDWF       GLCD_CHAR_SET_add_L0+0, 1 
	MOVLW       0
	ADDWFC      GLCD_CHAR_SET_add_L0+1, 1 
;glcd_jo.h,678 :: 		glcd_y = glcd_y % 8;
	MOVLW       7
	ANDWF       FARG_GLCD_CHAR_SET_glcd_y+0, 1 
;glcd_jo.h,680 :: 		if((num >= 32)&&(num <= 126))
	MOVLW       32
	SUBWF       FARG_GLCD_CHAR_SET_num+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_CHAR_SET109
	MOVF        FARG_GLCD_CHAR_SET_num+0, 0 
	SUBLW       126
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_CHAR_SET109
L__GLCD_CHAR_SET153:
;glcd_jo.h,682 :: 		glcd_font = glcd_font + (num-32)*5;
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
;glcd_jo.h,684 :: 		for(i=0;i<5;i++)
	CLRF        GLCD_CHAR_SET_i_L0+0 
L_GLCD_CHAR_SET110:
	MOVLW       5
	SUBWF       GLCD_CHAR_SET_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_CHAR_SET111
;glcd_jo.h,686 :: 		c = *glcd_font;
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
;glcd_jo.h,687 :: 		glcd_buff[add] |= (c << glcd_y);
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
L__GLCD_CHAR_SET179:
	BZ          L__GLCD_CHAR_SET180
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__GLCD_CHAR_SET179
L__GLCD_CHAR_SET180:
	MOVFF       R2, FSR0L
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	IORWF       R0, 1 
	MOVFF       R2, FSR1L
	MOVFF       R3, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;glcd_jo.h,688 :: 		glcd_buff[add + 128] |= (c >> (8 - glcd_y));
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
L__GLCD_CHAR_SET181:
	BZ          L__GLCD_CHAR_SET182
	RRCF        R0, 1 
	BCF         R0, 7 
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
;glcd_jo.h,689 :: 		add++;
	INFSNZ      GLCD_CHAR_SET_add_L0+0, 1 
	INCF        GLCD_CHAR_SET_add_L0+1, 1 
;glcd_jo.h,690 :: 		glcd_font++;
	MOVLW       1
	ADDWF       FARG_GLCD_CHAR_SET_glcd_font+0, 1 
	MOVLW       0
	ADDWFC      FARG_GLCD_CHAR_SET_glcd_font+1, 1 
	ADDWFC      FARG_GLCD_CHAR_SET_glcd_font+2, 1 
;glcd_jo.h,684 :: 		for(i=0;i<5;i++)
	INCF        GLCD_CHAR_SET_i_L0+0, 1 
;glcd_jo.h,691 :: 		}
	GOTO        L_GLCD_CHAR_SET110
L_GLCD_CHAR_SET111:
;glcd_jo.h,692 :: 		}
L_GLCD_CHAR_SET109:
;glcd_jo.h,693 :: 		return (glcd_x + 6);
	MOVLW       6
	ADDWF       FARG_GLCD_CHAR_SET_glcd_x+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
;glcd_jo.h,694 :: 		}
	RETURN      0
; end of _GLCD_CHAR_SET

_GLCD_CHAR_CLR:

;glcd_jo.h,705 :: 		unsigned int GLCD_CHAR_CLR(unsigned char glcd_x, unsigned char glcd_y, const char * glcd_font, unsigned char num)
;glcd_jo.h,711 :: 		add = (glcd_y / 8)*128 + glcd_x;
	MOVLW       3
	MOVWF       R0 
	MOVF        FARG_GLCD_CHAR_CLR_glcd_y+0, 0 
	MOVWF       GLCD_CHAR_CLR_add_L0+0 
	MOVLW       0
	MOVWF       GLCD_CHAR_CLR_add_L0+1 
	MOVF        R0, 0 
L__GLCD_CHAR_CLR183:
	BZ          L__GLCD_CHAR_CLR184
	RRCF        GLCD_CHAR_CLR_add_L0+0, 1 
	BCF         GLCD_CHAR_CLR_add_L0+0, 7 
	ADDLW       255
	GOTO        L__GLCD_CHAR_CLR183
L__GLCD_CHAR_CLR184:
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       GLCD_CHAR_CLR_add_L0+1 
	MOVF        R0, 0 
L__GLCD_CHAR_CLR185:
	BZ          L__GLCD_CHAR_CLR186
	RLCF        GLCD_CHAR_CLR_add_L0+0, 1 
	BCF         GLCD_CHAR_CLR_add_L0+0, 0 
	RLCF        GLCD_CHAR_CLR_add_L0+1, 1 
	ADDLW       255
	GOTO        L__GLCD_CHAR_CLR185
L__GLCD_CHAR_CLR186:
	MOVF        FARG_GLCD_CHAR_CLR_glcd_x+0, 0 
	ADDWF       GLCD_CHAR_CLR_add_L0+0, 1 
	MOVLW       0
	ADDWFC      GLCD_CHAR_CLR_add_L0+1, 1 
;glcd_jo.h,712 :: 		glcd_y = glcd_y % 8;
	MOVLW       7
	ANDWF       FARG_GLCD_CHAR_CLR_glcd_y+0, 1 
;glcd_jo.h,714 :: 		if((num >= 32)&&(num <= 126))
	MOVLW       32
	SUBWF       FARG_GLCD_CHAR_CLR_num+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_CHAR_CLR115
	MOVF        FARG_GLCD_CHAR_CLR_num+0, 0 
	SUBLW       126
	BTFSS       STATUS+0, 0 
	GOTO        L_GLCD_CHAR_CLR115
L__GLCD_CHAR_CLR154:
;glcd_jo.h,716 :: 		glcd_font = glcd_font + (num-32)*5;
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
;glcd_jo.h,718 :: 		for(i=0;i<5;i++)
	CLRF        GLCD_CHAR_CLR_i_L0+0 
L_GLCD_CHAR_CLR116:
	MOVLW       5
	SUBWF       GLCD_CHAR_CLR_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_CHAR_CLR117
;glcd_jo.h,720 :: 		c = *glcd_font;
	MOVF        FARG_GLCD_CHAR_CLR_glcd_font+0, 0 
	MOVWF       TBLPTRL 
	MOVF        FARG_GLCD_CHAR_CLR_glcd_font+1, 0 
	MOVWF       TBLPTRH 
	MOVF        FARG_GLCD_CHAR_CLR_glcd_font+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R4
	MOVF        R4, 0 
	MOVWF       GLCD_CHAR_CLR_c_L0+0 
;glcd_jo.h,721 :: 		glcd_buff[add] &= ((c << glcd_y) ^ 0xFF);
	MOVLW       _glcd_buff+0
	ADDWF       GLCD_CHAR_CLR_add_L0+0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_glcd_buff+0)
	ADDWFC      GLCD_CHAR_CLR_add_L0+1, 0 
	MOVWF       R3 
	MOVF        FARG_GLCD_CHAR_CLR_glcd_y+0, 0 
	MOVWF       R1 
	MOVF        R4, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__GLCD_CHAR_CLR187:
	BZ          L__GLCD_CHAR_CLR188
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__GLCD_CHAR_CLR187
L__GLCD_CHAR_CLR188:
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
;glcd_jo.h,722 :: 		glcd_buff[add + 128] &= ((c >> (8 - glcd_y)) ^ 0xFF);
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
L__GLCD_CHAR_CLR189:
	BZ          L__GLCD_CHAR_CLR190
	RRCF        R0, 1 
	BCF         R0, 7 
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
;glcd_jo.h,723 :: 		add++;
	INFSNZ      GLCD_CHAR_CLR_add_L0+0, 1 
	INCF        GLCD_CHAR_CLR_add_L0+1, 1 
;glcd_jo.h,724 :: 		glcd_font++;
	MOVLW       1
	ADDWF       FARG_GLCD_CHAR_CLR_glcd_font+0, 1 
	MOVLW       0
	ADDWFC      FARG_GLCD_CHAR_CLR_glcd_font+1, 1 
	ADDWFC      FARG_GLCD_CHAR_CLR_glcd_font+2, 1 
;glcd_jo.h,718 :: 		for(i=0;i<5;i++)
	INCF        GLCD_CHAR_CLR_i_L0+0, 1 
;glcd_jo.h,725 :: 		}
	GOTO        L_GLCD_CHAR_CLR116
L_GLCD_CHAR_CLR117:
;glcd_jo.h,726 :: 		}
L_GLCD_CHAR_CLR115:
;glcd_jo.h,727 :: 		return (glcd_x + 6);
	MOVLW       6
	ADDWF       FARG_GLCD_CHAR_CLR_glcd_x+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
;glcd_jo.h,728 :: 		}
	RETURN      0
; end of _GLCD_CHAR_CLR

_GLCD_OUT_STR:

;glcd_jo.h,739 :: 		unsigned int GLCD_OUT_STR(unsigned char glcd_x, unsigned char glcd_y, char *glcd_str, unsigned char black_white)
;glcd_jo.h,741 :: 		while(*glcd_str)
L_GLCD_OUT_STR119:
	MOVFF       FARG_GLCD_OUT_STR_glcd_str+0, FSR0L
	MOVFF       FARG_GLCD_OUT_STR_glcd_str+1, FSR0H
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_OUT_STR120
;glcd_jo.h,743 :: 		if(black_white)
	MOVF        FARG_GLCD_OUT_STR_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_OUT_STR121
;glcd_jo.h,744 :: 		GLCD_CHAR_SET(glcd_x, glcd_y, basic_font, *glcd_str);
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
	GOTO        L_GLCD_OUT_STR122
L_GLCD_OUT_STR121:
;glcd_jo.h,746 :: 		GLCD_CHAR_CLR(glcd_x, glcd_y, basic_font, *glcd_str);
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
L_GLCD_OUT_STR122:
;glcd_jo.h,747 :: 		glcd_x = glcd_x + 6;
	MOVLW       6
	ADDWF       FARG_GLCD_OUT_STR_glcd_x+0, 1 
;glcd_jo.h,748 :: 		glcd_str++;
	INFSNZ      FARG_GLCD_OUT_STR_glcd_str+0, 1 
	INCF        FARG_GLCD_OUT_STR_glcd_str+1, 1 
;glcd_jo.h,749 :: 		}
	GOTO        L_GLCD_OUT_STR119
L_GLCD_OUT_STR120:
;glcd_jo.h,750 :: 		return (glcd_x);
	MOVF        FARG_GLCD_OUT_STR_glcd_x+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
;glcd_jo.h,751 :: 		}
	RETURN      0
; end of _GLCD_OUT_STR

_GLCD_OUT_STR_LEN:

;glcd_jo.h,752 :: 		unsigned int GLCD_OUT_STR_LEN(unsigned char glcd_x, unsigned char glcd_y, char *glcd_str, unsigned char glcd_length, unsigned char black_white)
;glcd_jo.h,755 :: 		for(i=glcd_length;i>0;i--)
	MOVF        FARG_GLCD_OUT_STR_LEN_glcd_length+0, 0 
	MOVWF       GLCD_OUT_STR_LEN_i_L0+0 
L_GLCD_OUT_STR_LEN123:
	MOVF        GLCD_OUT_STR_LEN_i_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_OUT_STR_LEN124
;glcd_jo.h,757 :: 		if(black_white)
	MOVF        FARG_GLCD_OUT_STR_LEN_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_OUT_STR_LEN126
;glcd_jo.h,758 :: 		GLCD_CHAR_SET(glcd_x, glcd_y, basic_font, *glcd_str);
	MOVF        FARG_GLCD_OUT_STR_LEN_glcd_x+0, 0 
	MOVWF       FARG_GLCD_CHAR_SET_glcd_x+0 
	MOVF        FARG_GLCD_OUT_STR_LEN_glcd_y+0, 0 
	MOVWF       FARG_GLCD_CHAR_SET_glcd_y+0 
	MOVLW       _basic_font+0
	MOVWF       FARG_GLCD_CHAR_SET_glcd_font+0 
	MOVLW       hi_addr(_basic_font+0)
	MOVWF       FARG_GLCD_CHAR_SET_glcd_font+1 
	MOVLW       higher_addr(_basic_font+0)
	MOVWF       FARG_GLCD_CHAR_SET_glcd_font+2 
	MOVFF       FARG_GLCD_OUT_STR_LEN_glcd_str+0, FSR0L
	MOVFF       FARG_GLCD_OUT_STR_LEN_glcd_str+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_GLCD_CHAR_SET_num+0 
	CALL        _GLCD_CHAR_SET+0, 0
	GOTO        L_GLCD_OUT_STR_LEN127
L_GLCD_OUT_STR_LEN126:
;glcd_jo.h,760 :: 		GLCD_CHAR_CLR(glcd_x, glcd_y, basic_font, *glcd_str);
	MOVF        FARG_GLCD_OUT_STR_LEN_glcd_x+0, 0 
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_x+0 
	MOVF        FARG_GLCD_OUT_STR_LEN_glcd_y+0, 0 
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_y+0 
	MOVLW       _basic_font+0
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_font+0 
	MOVLW       hi_addr(_basic_font+0)
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_font+1 
	MOVLW       higher_addr(_basic_font+0)
	MOVWF       FARG_GLCD_CHAR_CLR_glcd_font+2 
	MOVFF       FARG_GLCD_OUT_STR_LEN_glcd_str+0, FSR0L
	MOVFF       FARG_GLCD_OUT_STR_LEN_glcd_str+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_GLCD_CHAR_CLR_num+0 
	CALL        _GLCD_CHAR_CLR+0, 0
L_GLCD_OUT_STR_LEN127:
;glcd_jo.h,761 :: 		glcd_x = glcd_x + 6;
	MOVLW       6
	ADDWF       FARG_GLCD_OUT_STR_LEN_glcd_x+0, 1 
;glcd_jo.h,762 :: 		glcd_str++;
	INFSNZ      FARG_GLCD_OUT_STR_LEN_glcd_str+0, 1 
	INCF        FARG_GLCD_OUT_STR_LEN_glcd_str+1, 1 
;glcd_jo.h,755 :: 		for(i=glcd_length;i>0;i--)
	DECF        GLCD_OUT_STR_LEN_i_L0+0, 1 
;glcd_jo.h,763 :: 		}
	GOTO        L_GLCD_OUT_STR_LEN123
L_GLCD_OUT_STR_LEN124:
;glcd_jo.h,764 :: 		return (glcd_x);
	MOVF        FARG_GLCD_OUT_STR_LEN_glcd_x+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
;glcd_jo.h,765 :: 		}
	RETURN      0
; end of _GLCD_OUT_STR_LEN

_GLCD_OUT_DEC:

;glcd_jo.h,777 :: 		unsigned int GLCD_OUT_DEC(unsigned char glcd_x, unsigned char glcd_y, unsigned long int glcd_n, unsigned char glcd_length, unsigned char black_white)
;glcd_jo.h,782 :: 		if(black_white)
	MOVF        FARG_GLCD_OUT_DEC_black_white+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GLCD_OUT_DEC128
;glcd_jo.h,783 :: 		for(i=glcd_length;i>0;i--)
	MOVF        FARG_GLCD_OUT_DEC_glcd_length+0, 0 
	MOVWF       GLCD_OUT_DEC_i_L0+0 
L_GLCD_OUT_DEC129:
	MOVF        GLCD_OUT_DEC_i_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_OUT_DEC130
;glcd_jo.h,785 :: 		glcd_temp = (glcd_n % 10) + 0x30;
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
;glcd_jo.h,786 :: 		glcd_n = glcd_n / 10;
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
;glcd_jo.h,787 :: 		GLCD_CHAR_SET((glcd_x + (i-1)*6), glcd_y, basic_font, glcd_temp);
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
;glcd_jo.h,783 :: 		for(i=glcd_length;i>0;i--)
	DECF        GLCD_OUT_DEC_i_L0+0, 1 
;glcd_jo.h,788 :: 		}
	GOTO        L_GLCD_OUT_DEC129
L_GLCD_OUT_DEC130:
	GOTO        L_GLCD_OUT_DEC132
L_GLCD_OUT_DEC128:
;glcd_jo.h,790 :: 		for(i=glcd_length;i>0;i--)
	MOVF        FARG_GLCD_OUT_DEC_glcd_length+0, 0 
	MOVWF       GLCD_OUT_DEC_i_L0+0 
L_GLCD_OUT_DEC133:
	MOVF        GLCD_OUT_DEC_i_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_OUT_DEC134
;glcd_jo.h,792 :: 		glcd_temp = (glcd_n % 10) + 0x30;
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
;glcd_jo.h,793 :: 		glcd_n = glcd_n / 10;
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
;glcd_jo.h,794 :: 		GLCD_CHAR_CLR((glcd_x + (i-1)*6), glcd_y, basic_font, glcd_temp);
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
;glcd_jo.h,790 :: 		for(i=glcd_length;i>0;i--)
	DECF        GLCD_OUT_DEC_i_L0+0, 1 
;glcd_jo.h,795 :: 		}
	GOTO        L_GLCD_OUT_DEC133
L_GLCD_OUT_DEC134:
L_GLCD_OUT_DEC132:
;glcd_jo.h,796 :: 		return (glcd_x + glcd_length*6);
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
;glcd_jo.h,797 :: 		}
	RETURN      0
; end of _GLCD_OUT_DEC

_GLCD_IMAGE:

;glcd_jo.h,807 :: 		void GLCD_IMAGE(const char *image)
;glcd_jo.h,810 :: 		for(index=0; index<1024; index++)
	CLRF        R3 
	CLRF        R4 
L_GLCD_IMAGE136:
	MOVLW       128
	XORWF       R4, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       4
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GLCD_IMAGE191
	MOVLW       0
	SUBWF       R3, 0 
L__GLCD_IMAGE191:
	BTFSC       STATUS+0, 0 
	GOTO        L_GLCD_IMAGE137
;glcd_jo.h,811 :: 		glcd_buff[index] = (const char *)image[index];
	MOVLW       _glcd_buff+0
	ADDWF       R3, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_glcd_buff+0)
	ADDWFC      R4, 0 
	MOVWF       FSR1H 
	MOVF        R3, 0 
	ADDWF       FARG_GLCD_IMAGE_image+0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      FARG_GLCD_IMAGE_image+1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	BTFSC       R4, 7 
	MOVLW       255
	ADDWFC      FARG_GLCD_IMAGE_image+2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;glcd_jo.h,810 :: 		for(index=0; index<1024; index++)
	INFSNZ      R3, 1 
	INCF        R4, 1 
;glcd_jo.h,811 :: 		glcd_buff[index] = (const char *)image[index];
	GOTO        L_GLCD_IMAGE136
L_GLCD_IMAGE137:
;glcd_jo.h,812 :: 		}
	RETURN      0
; end of _GLCD_IMAGE

_delayTime:

;glcd_jo.h,823 :: 		void delayTime (unsigned long counter)
;glcd_jo.h,825 :: 		while (counter--);
L_delayTime139:
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
	GOTO        L_delayTime140
	GOTO        L_delayTime139
L_delayTime140:
;glcd_jo.h,826 :: 		}
	RETURN      0
; end of _delayTime

_Shift_data:

;main.c,8 :: 		void Shift_data(unsigned int index)
;main.c,11 :: 		for(i=8;i>=1;i--)
	MOVLW       8
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
L_Shift_data141:
	MOVLW       0
	SUBWF       R6, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Shift_data192
	MOVLW       1
	SUBWF       R5, 0 
L__Shift_data192:
	BTFSS       STATUS+0, 0 
	GOTO        L_Shift_data142
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
;main.c,14 :: 		DAT = (data_shift & (1 << (i-1))) && 1;	//check bit (i-1) of data_shift
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
L__Shift_data193:
	BZ          L__Shift_data194
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__Shift_data193
L__Shift_data194:
	MOVF        R3, 0 
	ANDWF       R0, 1 
	MOVF        R4, 0 
	ANDWF       R1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_Shift_data145
	MOVLW       1
	MOVWF       R0 
	GOTO        L_Shift_data144
L_Shift_data145:
	CLRF        R0 
L_Shift_data144:
	BTFSC       R0, 0 
	GOTO        L__Shift_data195
	BCF         RC5_bit+0, 5 
	GOTO        L__Shift_data196
L__Shift_data195:
	BSF         RC5_bit+0, 5 
L__Shift_data196:
;main.c,15 :: 		SH_CP = 1;
	BSF         RD2_bit+0, 2 
;main.c,16 :: 		delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_Shift_data146:
	DECFSZ      R13, 1, 1
	BRA         L_Shift_data146
	DECFSZ      R12, 1, 1
	BRA         L_Shift_data146
	NOP
	NOP
;main.c,17 :: 		SH_CP = 0;
	BCF         RD2_bit+0, 2 
;main.c,18 :: 		delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_Shift_data147:
	DECFSZ      R13, 1, 1
	BRA         L_Shift_data147
	DECFSZ      R12, 1, 1
	BRA         L_Shift_data147
	NOP
	NOP
;main.c,11 :: 		for(i=8;i>=1;i--)
	MOVLW       1
	SUBWF       R5, 1 
	MOVLW       0
	SUBWFB      R6, 1 
;main.c,19 :: 		}
	GOTO        L_Shift_data141
L_Shift_data142:
;main.c,20 :: 		}
	RETURN      0
; end of _Shift_data

_main:

;main.c,21 :: 		void main() {
;main.c,25 :: 		float Vs = 0.302;
	MOVLW       190
	MOVWF       main_Vs_L0+0 
	MOVLW       159
	MOVWF       main_Vs_L0+1 
	MOVLW       26
	MOVWF       main_Vs_L0+2 
	MOVLW       125
	MOVWF       main_Vs_L0+3 
;main.c,29 :: 		CCP1CON = 0x00;
	CLRF        CCP1CON+0 
;main.c,30 :: 		CCP2CON = 0x00;
	CLRF        CCP2CON+0 
;main.c,31 :: 		ADCON0 = 0x00;
	CLRF        ADCON0+0 
;main.c,32 :: 		ADCON1 = 0b00001110;        // configure RA0 & RA1 pins as analog
	MOVLW       14
	MOVWF       ADCON1+0 
;main.c,33 :: 		TRISA  = 0b00000001;        // configure RAO & RA1 pins as inputs
	MOVLW       1
	MOVWF       TRISA+0 
;main.c,34 :: 		PORTA = 0;
	CLRF        PORTA+0 
;main.c,35 :: 		delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main148:
	DECFSZ      R13, 1, 1
	BRA         L_main148
	DECFSZ      R12, 1, 1
	BRA         L_main148
	DECFSZ      R11, 1, 1
	BRA         L_main148
	NOP
	NOP
;main.c,36 :: 		TRISE = 0;
	CLRF        TRISE+0 
;main.c,37 :: 		TRISB = 0;
	CLRF        TRISB+0 
;main.c,38 :: 		TRISD = 0;
	CLRF        TRISD+0 
;main.c,39 :: 		TRISC = 0;
	CLRF        TRISC+0 
;main.c,40 :: 		PORTA = 0xFF;
	MOVLW       255
	MOVWF       PORTA+0 
;main.c,42 :: 		GLCD_INIT();
	CALL        _GLCD_INIT+0, 0
;main.c,43 :: 		GLCD_FILL(WHITE);
	CLRF        FARG_GLCD_FILL_black_white+0 
	CALL        _GLCD_FILL+0, 0
;main.c,44 :: 		GLCD_OUT_STR(0,0,"Value = ",BLACK);
	CLRF        FARG_GLCD_OUT_STR_glcd_x+0 
	CLRF        FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       ?lstr1_main+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(?lstr1_main+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,45 :: 		GLCD_OUT_STR(0,10,"Voltage = ",BLACK);
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
;main.c,46 :: 		GLCD_OUT_STR(95,10,"V",BLACK);
	MOVLW       95
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
;main.c,47 :: 		GLCD_OUT_STR(0,20,"S = ",BLACK);
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
;main.c,48 :: 		GLCD_OUT_STR(95,20,"mS/cm",BLACK);
	MOVLW       95
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
;main.c,49 :: 		GLCD_DISPLAY();
	CALL        _GLCD_DISPLAY+0, 0
;main.c,59 :: 		Shift_data(0);
	CLRF        FARG_Shift_data_index+0 
	CLRF        FARG_Shift_data_index+1 
	CALL        _Shift_data+0, 0
;main.c,60 :: 		ST_CP = 1;
	BSF         RD3_bit+0, 3 
;main.c,61 :: 		delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_main149:
	DECFSZ      R13, 1, 1
	BRA         L_main149
	DECFSZ      R12, 1, 1
	BRA         L_main149
	NOP
	NOP
;main.c,62 :: 		ST_CP = 0;
	BCF         RD3_bit+0, 3 
;main.c,64 :: 		while(1)
L_main150:
;main.c,66 :: 		temp_res = ADC_Read(0);   // Get results of AD conversion
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       main_temp_res_L0+0 
	MOVF        R1, 0 
	MOVWF       main_temp_res_L0+1 
;main.c,67 :: 		Vo = (float)5/1024*temp_res;
	CALL        _Word2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
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
;main.c,68 :: 		So = Vo / Vs;
	MOVF        main_Vs_L0+0, 0 
	MOVWF       R4 
	MOVF        main_Vs_L0+1, 0 
	MOVWF       R5 
	MOVF        main_Vs_L0+2, 0 
	MOVWF       R6 
	MOVF        main_Vs_L0+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       main_So_L0+0 
	MOVF        R1, 0 
	MOVWF       main_So_L0+1 
	MOVF        R2, 0 
	MOVWF       main_So_L0+2 
	MOVF        R3, 0 
	MOVWF       main_So_L0+3 
;main.c,71 :: 		sprintf(txt_Vo,"%2.4f",Vo);
	MOVLW       main_txt_Vo_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(main_txt_Vo_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_6_main+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_6_main+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_6_main+0)
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
;main.c,72 :: 		sprintf(txt_So,"%2.4f",So);
	MOVLW       main_txt_So_L0+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(main_txt_So_L0+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_7_main+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_7_main+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_7_main+0)
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
;main.c,73 :: 		GLCD_OUT_DEC(60, 0 ,temp_res ,4, BLACK);
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
;main.c,76 :: 		GLCD_OUT_STR(60, 10 ,txt_Vo, BLACK);
	MOVLW       60
	MOVWF       FARG_GLCD_OUT_STR_glcd_x+0 
	MOVLW       10
	MOVWF       FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       main_txt_Vo_L0+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(main_txt_Vo_L0+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	MOVLW       1
	MOVWF       FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,77 :: 		GLCD_OUT_STR(60, 20 ,txt_So, BLACK);
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
;main.c,78 :: 		GLCD_DISPLAY();
	CALL        _GLCD_DISPLAY+0, 0
;main.c,79 :: 		delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main152:
	DECFSZ      R13, 1, 1
	BRA         L_main152
	DECFSZ      R12, 1, 1
	BRA         L_main152
	DECFSZ      R11, 1, 1
	BRA         L_main152
	NOP
	NOP
;main.c,80 :: 		GLCD_OUT_DEC(60, 0 ,temp_res ,4, WHITE);
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
	CLRF        FARG_GLCD_OUT_DEC_black_white+0 
	CALL        _GLCD_OUT_DEC+0, 0
;main.c,81 :: 		GLCD_OUT_STR(60, 10 ,txt_Vo,WHITE);
	MOVLW       60
	MOVWF       FARG_GLCD_OUT_STR_glcd_x+0 
	MOVLW       10
	MOVWF       FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       main_txt_Vo_L0+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(main_txt_Vo_L0+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	CLRF        FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,82 :: 		GLCD_OUT_STR(60, 20 ,txt_So,WHITE);
	MOVLW       60
	MOVWF       FARG_GLCD_OUT_STR_glcd_x+0 
	MOVLW       20
	MOVWF       FARG_GLCD_OUT_STR_glcd_y+0 
	MOVLW       main_txt_So_L0+0
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+0 
	MOVLW       hi_addr(main_txt_So_L0+0)
	MOVWF       FARG_GLCD_OUT_STR_glcd_str+1 
	CLRF        FARG_GLCD_OUT_STR_black_white+0 
	CALL        _GLCD_OUT_STR+0, 0
;main.c,98 :: 		}
	GOTO        L_main150
;main.c,100 :: 		}
	GOTO        $+0
; end of _main
