#include "C:\Users\Jo\Desktop\GLCD_Jo.h"
const code char truck_bmp[1024];
sbit DAT at RC5_bit;
sbit SH_CP at RD2_bit;
sbit ST_CP at RD3_bit;
const unsigned int mode[] = {0b01011011};

void Shift_data(unsigned int index)
{
	unsigned int  data_shift,i;
	for(i=8;i>=1;i--)
   {
		data_shift = mode[index];   //   (In & (1<<BitNo)) && 1
		DAT = (data_shift & (1 << (i-1))) && 1;	//check bit (i-1) of data_shift
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
        float Vs = 0.0755;
        float Vo;
        float So;

        CCP1CON = 0x00;
        CCP2CON = 0x00;
        ADCON0 = 0x00;
        ADCON1 = 0b00001110;        // configure RA0 & RA1 pins as analog
        TRISA  = 0b00000001;        // configure RAO & RA1 pins as inputs
        PORTA = 0;
        delay_ms(500);
        TRISE = 0;
        TRISB = 0;
        TRISD = 0;
        TRISC = 0;
        PORTA = 0xFF;

        GLCD_INIT();
        GLCD_FILL(WHITE);
        GLCD_OUT_STR(0,0,"Value = ",BLACK);
        GLCD_OUT_STR(0,10,"Voltage = ",BLACK);
        GLCD_OUT_STR(95,10,"V",BLACK);
        GLCD_OUT_STR(0,20,"S = ",BLACK);
        GLCD_OUT_STR(95,20,"mS/cm",BLACK);
        GLCD_DISPLAY();
		//Bom vao
		/*
		Shift_data(0);
		ST_CP = 1;
		delay_ms(1);
		ST_CP = 0;
		delay_ms(10000);
                  */
		//Khuay
		Shift_data(0);
		ST_CP = 1;
		delay_ms(1);
		ST_CP = 0;
        //while(1);
        while(1)
        {
              temp_res = ADC_Read(0);   // Get results of AD conversion
              Vo = (float)5/1024*temp_res;
              So = Vo / Vs;
              //FloatToStr(Vo, txt_Vo);
              //FloatToStr(So, txt_So);
              sprintf(txt_Vo,"%2.4f",Vo);
              sprintf(txt_So,"%2.4f",So);
              GLCD_OUT_DEC(60, 0 ,temp_res ,4, BLACK);
              //GLCD_OUT_STR_LEN(60, 10 ,txt_Vo, 5, BLACK);
              //GLCD_OUT_STR_LEN(60, 20 ,txt_So, 5, BLACK);
              GLCD_OUT_STR(60, 10 ,txt_Vo, BLACK);
              GLCD_OUT_STR(60, 20 ,txt_So, BLACK);
              GLCD_DISPLAY();
              delay_ms(1000);
              GLCD_OUT_DEC(60, 0 ,temp_res ,4, WHITE);
              GLCD_OUT_STR(60, 10 ,txt_Vo,WHITE);
              GLCD_OUT_STR(60, 20 ,txt_So,WHITE);
              //GLCD_OUT_STR_LEN(60, 10 ,txt_Vo, 5,WHITE);
              //GLCD_OUT_STR_LEN(60, 10 ,txt_Vo, 5,WHITE);
              /* 
              //Test done !
              temp_res = 255;
              GLCD_OUT_DEC(60, 0 ,temp_res ,4, BLACK);
              GLCD_DISPLAY();
              delay_ms(1000);
              GLCD_OUT_DEC(60, 0 ,temp_res ,4, WHITE);
              temp_res = 64;
              GLCD_OUT_DEC(60, 0 ,temp_res ,4, BLACK);
              GLCD_DISPLAY();
              delay_ms(1000);
              GLCD_OUT_DEC(60, 0 ,temp_res ,4, WHITE);
              */
        }

}