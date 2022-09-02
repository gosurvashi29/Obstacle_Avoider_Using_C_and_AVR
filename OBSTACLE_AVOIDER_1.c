#define F_CPU 1000000
#include<avr/io.h>
#include<util/delay.h>
int main()
{
   DDRC=0xff;
   DDRA=0b11111100;
  
   while(1)
  { 
     if(PINA==0b00000000)
     PORTC=0b00001010;
		  /* if(PINA==0b00000011)
		     PORTC=0b00001001;
		  if(PINA==0b00000001)
		     PORTC=0b00001001;
		   if(PINA==0b00000010)
		      PORTC=0b00001001; */
	  else
	  {
	    PORTC=0b00001001;
	  }
  } 
}
