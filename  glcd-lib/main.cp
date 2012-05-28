#line 1 "C:/Users/Jo/Desktop/GLCD Lib/main.c"
#line 1 "c:/users/jo/desktop/glcd_jo.h"
#line 10 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_INIT();
void GLCD_FILL(unsigned char black_white);
void GLCD_DISPLAY();
void GLCD_CS1_ENABLE();
void GLCD_CS2_ENABLE();
void GLCD_OUT_CMD(unsigned char glcd_cmd);
void GLCD_OUT_DATA(unsigned char glcd_data);
void GLCD_POINT_DRW(unsigned char x, unsigned char y);
void GLCD_POINT_CLR(unsigned char x, unsigned char y);
void GLCD_DRW_REC_EMPTY(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char black_white);
void GLCD_DRW_REC_SOLID(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char black_white);
void GLCD_DRW_LINE(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char black_white);
void GLCD_DRW_VECTOR(unsigned char x1, unsigned char y1, unsigned int angle, unsigned char length, unsigned char black_white);
void GLCD_DRW_CIRCLE_EMPTY(unsigned char x, unsigned char y, unsigned char r, unsigned char black_white);
void GLCD_DRW_CIRCLE_SOLID(unsigned char x, unsigned char y, unsigned char r, unsigned char black_white);
unsigned int GLCD_CHAR_SET(unsigned char glcd_x, unsigned char glcd_y, const char * glcd_font, unsigned char num);
unsigned int GLCD_CHAR_CLR(unsigned char glcd_x, unsigned char glcd_y, const char * glcd_font, unsigned char num);
unsigned int GLCD_OUT_STR(unsigned char glcd_x, unsigned char glcd_y, char *glcd_str, unsigned char black_white);
unsigned int GLCD_OUT_DEC(unsigned char glcd_x, unsigned char glcd_y, unsigned long int glcd_n, unsigned char glcd_length, unsigned char black_white);
void GLCD_IMAGE(char image);
void delayTime (unsigned long counter);
#line 37 "c:/users/jo/desktop/glcd_jo.h"
sbit GLCD_CS1 at RE2_bit;
sbit GLCD_CS2 at RE1_bit;
sbit GLCD_DI at RD5_bit;
sbit GLCD_RW at RD6_bit;
sbit GLCD_EN at RD7_bit;
sbit GLCD_RST at RE0_bit;

sbit GLCD_DataPort_Direction at TRISB;
sbit GLCD_CS1_Direction at TRISE2_bit;
sbit GLCD_CS2_Direction at TRISE1_bit;
sbit GLCD_DI_Direction at TRISD5_bit;
sbit GLCD_RW_Direction at TRISD6_bit;
sbit GLCD_EN_Direction at TRISD7_bit;
sbit GLCD_RST_Direction at TRISE0_bit;
#line 57 "c:/users/jo/desktop/glcd_jo.h"
unsigned char glcd_buff[1024];
unsigned int glcd_address;
unsigned char glcd_column = 0;
unsigned char glcd_line = 0;

const char basic_font[] =
{
 0x00,0x00,0x00,0x00,0x00,
 0x00,0x00,0x4F,0x00,0x00,
 0x00,0x07,0x00,0x07,0x00,
 0x14,0x7F,0x14,0x7F,0x14,
 0x24,0x2A,0x7F,0x2A,0x12,
 0x23,0x13,0x08,0x64,0x62,
 0x36,0x49,0x55,0x22,0x50,
 0x00,0x05,0x03,0x00,0x00,
 0x00,0x1C,0x22,0x41,0x00,
 0x00,0x41,0x22,0x1C,0x00,
 0x14,0x08,0x3E,0x08,0x14,
 0x08,0x08,0x3E,0x08,0x08,
 0x00,0x50,0x30,0x00,0x00,
 0x08,0x08,0x08,0x08,0x08,
 0x00,0x60,0x60,0x00,0x00,
 0x20,0x10,0x08,0x04,0x02,
 0x3E,0x51,0x49,0x45,0x3E,
 0x00,0x42,0x7F,0x40,0x00,
 0x42,0x61,0x51,0x49,0x46,
 0x21,0x41,0x45,0x4B,0x31,
 0x18,0x14,0x12,0x7F,0x10,
 0x27,0x45,0x45,0x45,0x39,
 0x3C,0x4A,0x49,0x49,0x30,
 0x01,0x71,0x09,0x05,0x03,
 0x36,0x49,0x49,0x49,0x36,
 0x06,0x49,0x49,0x29,0x1E,
 0x00,0x36,0x36,0x00,0x00,
 0x00,0x56,0x36,0x00,0x00,
 0x00,0x08,0x14,0x22,0x41,
 0x14,0x14,0x14,0x14,0x14,
 0x41,0x22,0x14,0x08,0x00,
 0x02,0x01,0x59,0x05,0x02,
 0x32,0x49,0x79,0x41,0x3E,
 0x7E,0x11,0x11,0x11,0x7E,
 0x7F,0x49,0x49,0x49,0x36,
 0x3E,0x41,0x41,0x41,0x22,
 0x7F,0x41,0x41,0x22,0x1C,
 0x7F,0x49,0x49,0x49,0x41,
 0x7F,0x09,0x09,0x09,0x01,
 0x3E,0x41,0x41,0x49,0x7A,
 0x7F,0x08,0x08,0x08,0x7F,
 0x00,0x41,0x7F,0x41,0x00,
 0x20,0x40,0x41,0x3F,0x01,
 0x7F,0x08,0x14,0x22,0x41,
 0x7F,0x40,0x40,0x40,0x40,
 0x7F,0x02,0x0C,0x02,0x7F,
 0x7F,0x04,0x08,0x10,0x7F,
 0x3E,0x41,0x41,0x41,0x3E,
 0x7F,0x09,0x09,0x09,0x06,
 0x3E,0x41,0x51,0x21,0x5E,
 0x7F,0x09,0x19,0x29,0x46,
 0x46,0x49,0x49,0x49,0x31,
 0x01,0x01,0x7F,0x01,0x01,
 0x3F,0x40,0x40,0x40,0x3F,
 0x1F,0x20,0x40,0x20,0x1F,
 0x3F,0x40,0x30,0x40,0x3F,
 0x63,0x14,0x08,0x14,0x63,
 0x07,0x08,0x70,0x08,0x07,
 0x61,0x51,0x49,0x45,0x43,
 0x00,0x7F,0x41,0x41,0x00,
 0x02,0x04,0x08,0x10,0x20,
 0x00,0x41,0x41,0x7F,0x00,
 0x04,0x02,0x01,0x02,0x04,
 0x40,0x40,0x40,0x40,0x40,
 0x00,0x01,0x02,0x04,0x00,
 0x20,0x54,0x54,0x54,0x78,
 0x7F,0x48,0x44,0x44,0x38,
 0x38,0x44,0x44,0x44,0x20,
 0x38,0x44,0x44,0x48,0x7F,
 0x38,0x54,0x54,0x54,0x18,
 0x08,0x7E,0x09,0x01,0x02,
 0x0C,0x52,0x52,0x52,0x3E,
 0x7F,0x08,0x04,0x04,0x78,
 0x00,0x44,0x7D,0x40,0x00,
 0x20,0x40,0x44,0x3D,0x00,
 0x7F,0x10,0x28,0x44,0x00,
 0x00,0x41,0x7F,0x40,0x00,
 0x7C,0x04,0x7C,0x04,0x78,
 0x7C,0x08,0x04,0x04,0x78,
 0x38,0x44,0x44,0x44,0x38,
 0x7C,0x14,0x14,0x14,0x08,
 0x08,0x14,0x14,0x14,0x7C,
 0x7C,0x08,0x04,0x04,0x08,
 0x48,0x54,0x54,0x54,0x20,
 0x04,0x3F,0x44,0x40,0x20,
 0x3C,0x40,0x40,0x20,0x7C,
 0x1C,0x20,0x40,0x20,0x1C,
 0x3C,0x40,0x30,0x40,0x3C,
 0x44,0x28,0x10,0x28,0x44,
 0x0C,0x50,0x50,0x50,0x3C,
 0x44,0x64,0x54,0x4C,0x44,
 0x00,0x08,0x36,0x41,0x00,
 0x00,0x00,0x7F,0x00,0x00,
 0x00,0x41,0x36,0x08,0x00,
 0x10,0x08,0x10,0x08,0x00
};
#line 174 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_INIT()
{
 GLCD_DataPort_Direction = 0x00;
 GLCD_CS1_Direction = 0;
 GLCD_CS2_Direction = 0;
 GLCD_DI_Direction = 0;
 GLCD_RW_Direction = 0;
 GLCD_EN_Direction = 0;
 GLCD_RST_Direction = 0;


 GLCD_RST = 1;
 GLCD_CS1 = 1;
 GLCD_CS2 = 1;
 GLCD_DI = 0;

 delayTime(10000);
 GLCD_OUT_CMD(0b11000000);

 delayTime(10000);
 GLCD_OUT_CMD(0b01000000);

 delayTime(10000);
 GLCD_OUT_CMD(0b10111000);

 delayTime(10000);
 GLCD_OUT_CMD(0b00111111);

 GLCD_CS1 = 0;
 GLCD_CS2 = 0;
}
#line 214 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_FILL(unsigned char black_white)
{
 unsigned int index;
 for(index=0;index<1024;index++)
 {
 glcd_buff[index] = black_white;
 }
 GLCD_DISPLAY();
}
#line 231 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_DISPLAY()
{
 for(glcd_address = 0; glcd_address < 1024; glcd_address++)
 {
 if(glcd_column == 128)
 {
 glcd_column = 0;
 glcd_line++;



 GLCD_CS1 = 1;
 GLCD_CS2 = 1;

 glcd_line &= 0x07;
 glcd_line |= 0xB8;

 GLCD_OUT_CMD(glcd_line);

 GLCD_OUT_CMD(0b01000000);
 }

 if(glcd_column <= 63)
 GLCD_CS1_ENABLE();

 if(glcd_column >= 64)
 GLCD_CS2_ENABLE();

 GLCD_OUT_DATA(glcd_buff[glcd_address]);

 glcd_column++;
 }
}
#line 273 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_CS1_ENABLE()
{
 GLCD_CS1 = 1;
 GLCD_CS2 = 0;
}
#line 287 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_CS2_ENABLE()
{
 GLCD_CS2 = 1;
 GLCD_CS1 = 0;
}
#line 301 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_OUT_CMD(unsigned char glcd_cmd)
{
 GLCD_DI = 0;
 GLCD_EN = 1;
  PORTB  = glcd_cmd;
  PORTB  = glcd_cmd;
  PORTB  = glcd_cmd;
  PORTB  = glcd_cmd;
 GLCD_EN = 0;
}
#line 320 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_OUT_DATA(unsigned char glcd_data)
{
 GLCD_DI = 1;
 GLCD_EN = 1;
  PORTB  = glcd_data;
  PORTB  = glcd_data;
  PORTB  = glcd_data;
  PORTB  = glcd_data;
 GLCD_EN = 0;
}
#line 339 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_POINT_DRW(unsigned char x, unsigned char y)
{
 unsigned char h_line;
 unsigned int temp;
 temp = x + ((y >> 3) << 7);
 h_line = (unsigned char)(y & 0x07);
 glcd_buff[temp] |= (1<<h_line);
}
#line 356 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_POINT_CLR(unsigned char x, unsigned char y)
{
 unsigned char h_line;
 unsigned int temp;
 temp = x + ((y >> 3) << 7);
 h_line = (unsigned char)(y & 0x07);
 glcd_buff[temp] &= ~(1<<h_line);
}
#line 376 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_DRW_REC_EMPTY(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char black_white)
{
 unsigned char glcd_temp;
 if(x1 > x2)
 {
 glcd_temp = x1;
 x1 = x2;
 x2 = glcd_temp;
 }
 if(y1 > y2)
 {
 glcd_temp = y1;
 y1 = y2;
 y2 = glcd_temp;
 }
 if(black_white)
 {
 for(glcd_temp=x1;glcd_temp<=x2;glcd_temp++)
 {
 GLCD_POINT_DRW(glcd_temp,y1);
 GLCD_POINT_DRW(glcd_temp,y2);
 }
 for(glcd_temp=y1;glcd_temp<=y2;glcd_temp++)
 {
 GLCD_POINT_DRW(x1,glcd_temp);
 GLCD_POINT_DRW(x2,glcd_temp);
 }
 }
 else
 {
 for(glcd_temp=x1;glcd_temp<=x2;glcd_temp++)
 {
 GLCD_POINT_CLR(glcd_temp,y1);
 GLCD_POINT_CLR(glcd_temp,y2);
 }
 for(glcd_temp=y1;glcd_temp<=y2;glcd_temp++)
 {
 GLCD_POINT_CLR(x1,glcd_temp);
 GLCD_POINT_CLR(x2,glcd_temp);
 }
 }
}
#line 429 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_DRW_REC_SOLID(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char black_white)
{
 unsigned char glcd_temp;
 unsigned char i,j;
 if(x1 > x2)
 {
 glcd_temp = x1;
 x1 = x2;
 x2 = glcd_temp;
 }
 if(y1 > y2)
 {
 glcd_temp = y1;
 y1 = y2;
 y2 = glcd_temp;
 }
 for(i=x1;i<=x2;i++)
 for(j=y1;j<=y2;j++)
 {
 if(black_white)
 GLCD_POINT_DRW(i,j);
 else
 GLCD_POINT_CLR(i,j);
 }
}
#line 465 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_DRW_LINE(unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char black_white)
{
 unsigned char i;
 float a, b;

 if(x2 == x1)
 {
 if(y2 >= y1)
 for(i=y1;i<=y2;i++)
 if(black_white != 0)
 GLCD_POINT_DRW(x1,i);
 else
 GLCD_POINT_CLR(x1,i);
 else
 for(i=y2;i<=y1;i++)
 if(black_white != 0)
 GLCD_POINT_DRW(x1,i);
 else
 GLCD_POINT_CLR(x1,i);
 }
 else
 {
 a = (float)(y2 - y1) / (float)(x2 - x1);
 b = (float)(y2 - a*x2);

 if(x2 > x1)
 {
 for(i=x1;i<=x2;i++)
 if(black_white != 0)
 GLCD_POINT_DRW(i,(a*i + b));
 else
 GLCD_POINT_CLR(i,(a*i + b));
 }
 else
 {
 for(i=x2;i<=x1;i++)
 if(black_white != 0)
 GLCD_POINT_DRW(i,(a*i + b));
 else
 GLCD_POINT_CLR(i,(a*i + b));
 }
 }
}
#line 518 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_DRW_VECTOR(unsigned char x1, unsigned char y1, unsigned int angle, unsigned char length, unsigned char black_white)
{
 unsigned int i;
 char x_max;
 double a;
 double goc;
 if(angle == 0)
 {
 if(black_white != 0)
 GLCD_DRW_LINE(x1,y1,x1,y1-length,1);
 else
 GLCD_DRW_LINE(x1,y1,x1,y1-length,0);
 }
 else if(angle == 90)
 {
 if(black_white != 0)
 GLCD_DRW_LINE(x1,y1,x1+length,y1,1);
 else
 GLCD_DRW_LINE(x1,y1,x1+length,y1,0);
 }
 else if(angle == 180)
 {
 if(black_white != 0)
 GLCD_DRW_LINE(x1,y1,x1,y1+length,1);
 else
 GLCD_DRW_LINE(x1,y1,x1,y1+length,0);
 }
 else if(angle == 270)
 {
 if(black_white != 0)
 GLCD_DRW_LINE(x1,y1,x1-length,y1,1);
 else
 GLCD_DRW_LINE(x1,y1,x1-length,y1,0);
 }
 else
 {
 if(angle < 180)
 goc = ((double)(angle*3.14)/180);
 else
 goc = ((double)((360 - angle)*3.14)/180);

 x_max = (char)(length*sin(goc));

 a = 1/tan(goc);
 if(angle < 180)
 for(i=x1;i<=x1+x_max;i++)
 {
 if(black_white)
 GLCD_POINT_DRW(i,(unsigned char)(y1 - a*(i-x1)));
 else
 GLCD_POINT_CLR(i,(unsigned char)(y1 - a*(i-x1)));
 }
 else
 for(i=(x1-x_max);i<=x1;i++)
 {
 if(black_white)
 GLCD_POINT_DRW(i,(unsigned char)(y1 - a*(x1-i)));
 else
 GLCD_POINT_CLR(i,(unsigned char)(y1 - a*(x1-i)));
 }
 }
}
#line 590 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_DRW_CIRCLE_EMPTY(unsigned char x, unsigned char y, unsigned char r, unsigned char black_white)
{
 unsigned char i,j;
 unsigned int r2,ri2;
 r2 = r*r;
 for(i=0;i<=r;i++)
 {
 j = 0;
 ri2 = (r-i)*(r-i);

 while((ri2 + (r-j)*(r-j)) > r2)
 {
 j++;
 }

 if(black_white)
 {
 GLCD_POINT_DRW(x-r+i,y-r+j);
 GLCD_POINT_DRW(x-r+i,y+r-j);
 GLCD_POINT_DRW(x+r-i,y+r-j);
 GLCD_POINT_DRW(x+r-i,y-r+j);
 }
 else
 {
 GLCD_POINT_CLR(x-r+i,y-r+j);
 GLCD_POINT_CLR(x-r+i,y+r-j);
 GLCD_POINT_CLR(x+r-i,y+r-j);
 GLCD_POINT_CLR(x+r-i,y-r+j);
 }
 }
}
#line 631 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_DRW_CIRCLE_SOLID(unsigned char x, unsigned char y, unsigned char r, unsigned char black_white)
{
 unsigned char i,j;
 unsigned int r2,ri2;
 r2 = r*r;
 for(i=0;i<=r;i++)
 {
 ri2 = (r-i)*(r-i);
 for(j=0;j<=r;j++)
 {
 if((ri2 + (r-j)*(r-j)) <= r2)
 {
 if(black_white != 0)
 {
 GLCD_POINT_DRW(x-r+i,y-r+j);
 GLCD_POINT_DRW(x-r+i,y+r-j);
 GLCD_POINT_DRW(x+r-i,y+r-j);
 GLCD_POINT_DRW(x+r-i,y-r+j);
 }
 else
 {
 GLCD_POINT_CLR(x-r+i,y-r+j);
 GLCD_POINT_CLR(x-r+i,y+r-j);
 GLCD_POINT_CLR(x+r-i,y+r-j);
 GLCD_POINT_CLR(x+r-i,y-r+j);
 }
 }
 }
 }
}
#line 671 "c:/users/jo/desktop/glcd_jo.h"
unsigned int GLCD_CHAR_SET(unsigned char glcd_x, unsigned char glcd_y, const char * glcd_font, unsigned char num)
{
 unsigned char i;
 unsigned char c;
 unsigned int add;

 add = (glcd_y / 8)*128 + glcd_x;
 glcd_y = glcd_y % 8;

 if((num >= 32)&&(num <= 126))
 {
 glcd_font = glcd_font + (num-32)*5;

 for(i=0;i<5;i++)
 {
 c = *glcd_font;
 glcd_buff[add] |= (c << glcd_y);
 glcd_buff[add + 128] |= (c >> (8 - glcd_y));
 add++;
 glcd_font++;
 }
 }
 return (glcd_x + 6);
}
#line 705 "c:/users/jo/desktop/glcd_jo.h"
unsigned int GLCD_CHAR_CLR(unsigned char glcd_x, unsigned char glcd_y, const char * glcd_font, unsigned char num)
{
 unsigned char i;
 unsigned char c;
 unsigned int add;

 add = (glcd_y / 8)*128 + glcd_x;
 glcd_y = glcd_y % 8;

 if((num >= 32)&&(num <= 126))
 {
 glcd_font = glcd_font + (num-32)*5;

 for(i=0;i<5;i++)
 {
 c = *glcd_font;
 glcd_buff[add] &= ((c << glcd_y) ^ 0xFF);
 glcd_buff[add + 128] &= ((c >> (8 - glcd_y)) ^ 0xFF);
 add++;
 glcd_font++;
 }
 }
 return (glcd_x + 6);
}
#line 739 "c:/users/jo/desktop/glcd_jo.h"
unsigned int GLCD_OUT_STR(unsigned char glcd_x, unsigned char glcd_y, char *glcd_str, unsigned char black_white)
{
 while(*glcd_str)
 {
 if(black_white)
 GLCD_CHAR_SET(glcd_x, glcd_y, basic_font, *glcd_str);
 else
 GLCD_CHAR_CLR(glcd_x, glcd_y, basic_font, *glcd_str);
 glcd_x = glcd_x + 6;
 glcd_str++;
 }
 return (glcd_x);
}
unsigned int GLCD_OUT_STR_LEN(unsigned char glcd_x, unsigned char glcd_y, char *glcd_str, unsigned char glcd_length, unsigned char black_white)
{
 unsigned char i;
 for(i=glcd_length;i>0;i--)
 {
 if(black_white)
 GLCD_CHAR_SET(glcd_x, glcd_y, basic_font, *glcd_str);
 else
 GLCD_CHAR_CLR(glcd_x, glcd_y, basic_font, *glcd_str);
 glcd_x = glcd_x + 6;
 glcd_str++;
 }
 return (glcd_x);
}
#line 777 "c:/users/jo/desktop/glcd_jo.h"
unsigned int GLCD_OUT_DEC(unsigned char glcd_x, unsigned char glcd_y, unsigned long int glcd_n, unsigned char glcd_length, unsigned char black_white)
{
 unsigned char glcd_temp;
 unsigned char i;

 if(black_white)
 for(i=glcd_length;i>0;i--)
 {
 glcd_temp = (glcd_n % 10) + 0x30;
 glcd_n = glcd_n / 10;
 GLCD_CHAR_SET((glcd_x + (i-1)*6), glcd_y, basic_font, glcd_temp);
 }
 else
 for(i=glcd_length;i>0;i--)
 {
 glcd_temp = (glcd_n % 10) + 0x30;
 glcd_n = glcd_n / 10;
 GLCD_CHAR_CLR((glcd_x + (i-1)*6), glcd_y, basic_font, glcd_temp);
 }
 return (glcd_x + glcd_length*6);
}
#line 807 "c:/users/jo/desktop/glcd_jo.h"
void GLCD_IMAGE(const char *image)
{
 int index;
 for(index=0; index<1024; index++)
 glcd_buff[index] = (const char *)image[index];
}
#line 823 "c:/users/jo/desktop/glcd_jo.h"
void delayTime (unsigned long counter)
{
 while (counter--);
}
#line 2 "C:/Users/Jo/Desktop/GLCD Lib/main.c"
const code char truck_bmp[1024];
sbit DAT at RC5_bit;
sbit SH_CP at RD2_bit;
sbit ST_CP at RD3_bit;
const unsigned int mode[] = {0b01011011};

void Shift_data(unsigned int index)
{
 unsigned int data_shift,i;
 for(i=8;i>=1;i--)
 {
 data_shift = mode[index];
 DAT = (data_shift & (1 << (i-1))) && 1;
 SH_CP = 1;
 delay_ms(1);
 SH_CP = 0;
 delay_ms(1);
 }
}
void main() {
 unsigned int temp_res;
 char txt_Vo[15];
 char txt_So[15];
 float Vs = 0.302;
 float Vo;
 float So;

 CCP1CON = 0x00;
 CCP2CON = 0x00;
 ADCON0 = 0x00;
 ADCON1 = 0b00001110;
 TRISA = 0b00000001;
 PORTA = 0;
 delay_ms(500);
 TRISE = 0;
 TRISB = 0;
 TRISD = 0;
 TRISC = 0;
 PORTA = 0xFF;

 GLCD_INIT();
 GLCD_FILL( 0 );
 GLCD_OUT_STR(0,0,"Value = ", 1 );
 GLCD_OUT_STR(0,10,"Voltage = ", 1 );
 GLCD_OUT_STR(95,10,"V", 1 );
 GLCD_OUT_STR(0,20,"S = ", 1 );
 GLCD_OUT_STR(95,20,"mS/cm", 1 );
 GLCD_DISPLAY();
#line 59 "C:/Users/Jo/Desktop/GLCD Lib/main.c"
 Shift_data(0);
 ST_CP = 1;
 delay_ms(1);
 ST_CP = 0;

 while(1)
 {
 temp_res = ADC_Read(0);
 Vo = (float)5/1024*temp_res;
 So = Vo / Vs;


 sprintf(txt_Vo,"%2.4f",Vo);
 sprintf(txt_So,"%2.4f",So);
 GLCD_OUT_DEC(60, 0 ,temp_res ,4,  1 );


 GLCD_OUT_STR(60, 10 ,txt_Vo,  1 );
 GLCD_OUT_STR(60, 20 ,txt_So,  1 );
 GLCD_DISPLAY();
 delay_ms(1000);
 GLCD_OUT_DEC(60, 0 ,temp_res ,4,  0 );
 GLCD_OUT_STR(60, 10 ,txt_Vo, 0 );
 GLCD_OUT_STR(60, 20 ,txt_So, 0 );
#line 98 "C:/Users/Jo/Desktop/GLCD Lib/main.c"
 }

}
