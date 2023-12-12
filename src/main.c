#include "stm32f4xx.h"
#include "stm32f4_discovery.h"

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

char  str[50];

int8_t x, y, z;
uint8_t x_address = 0x29, y_address = 0x2B, z_address = 0x2D;

char rx_buffer[20];
char control_buffer[5];
char tx_buffer[50];

int i = 0;

void delayy(uint32_t time)
{
	while(time--);
}

void RCC_Config()
{
	RCC->CR |= 0x00010000;			// HSEON and HSEONRDY enable
	while(!(RCC->CR & 0x00020000));	// HSEON Ready Flag wait
	RCC->CR |= 0x00080000;			// CSS Enable
	RCC->CR |= 0x01000000;			//pll enable
	RCC->PLLCFGR |= 0x00400000;		// PLL e HSE seçtik
	RCC->PLLCFGR |= 0x00000004;		// PLL M = 4
	RCC->PLLCFGR |= 0x00005A00;		// Pll N = 168
	RCC->PLLCFGR |= 0x00000000;		// PLL p = 2
	RCC->CFGR |= 0x00000000;		// AHB Prescaler = 1
	RCC->CFGR |= 0x00080000;		// APB2 Prescaler = 2
	RCC->CFGR |= 0x00001400;		// APB1 Prescaler = 4
	RCC->CIR |= 0x00800000;			// CSS Flag clear
}

void GPIO_Config()
{

	/********** PA5-PA6-PA7 (for SPI) **********/
	RCC->AHB1ENR |= (1 << 0);								// AHB1 A pin enabled
	GPIOA->MODER |= (2 << 10) | (2 << 12) | (2 << 14);		// A5-A6-A7 Alternate function ?
	//GPIOA->OTYPER |= (0 << 5) | (0 << 6) | (0 << 7);		// A5-A6-A7 Output push-pull
	GPIOA->OSPEEDR |= (2 << 10) | (2 << 12) | (2 << 14);	// A5-A6-A7 High speed
	//GPIOA->PUPDR |= (2 << 10) | (2 << 12) | (2 << 14);	// A5-A6-A7 Pull Down ?
	GPIOA->AFR[0] |= (5 << 20) | (5 << 24) | (5 << 28);		// A5-A6-A7 Alternate function bit set

	RCC->AHB1ENR |= (1 << 4);								// AHB1 E pin enabled
	GPIOE->MODER |= (1 << 6);								// E3 Output
	//GPIOE->OTYPER |= (0 << 3) | (0 << 4) | (0 <<5);		// A3-A4-A5 Output push-pull ?
	GPIOE->OSPEEDR |= (2 << 6);								// A3 High Speed
	//GPIOE->PUPDR |= (2 << 6) | (2 << 8) | (2 << 10);		// A3-A4-A5 Pull Down ?

	/********** PD12-PD13-PD14-PD15 (for LED) **********/
	RCC->AHB1ENR |= (1 << 3);											// Enable clock for GPIOD and Configure PD12 in output mode +
	GPIOD->MODER |= (1 << 24) | (1 << 26)  |  (1 << 28) | (1 << 30);	// Port D -> Pin 12 | Pin 13 | Pin 14 | Pin 15 Output selected +
	GPIOD->OSPEEDR |= (2 << 24) | (2 << 26)  |  (2 << 28) | (2 << 30);	// High Speed
	//GPIOD->PUPDR |= (2 << 24) | (2 << 26)  |  (2 << 28) | (2 << 30);	// Pull Down Mode

	/********** PA2-PA3 (for USART) **********/
	GPIOA->MODER |= (2<<4);  // Bits (5:4)= 1:0 --> Alternate Function for Pin PA2
	GPIOA->MODER |= (2<<6);  // Bits (7:6)= 1:0 --> Alternate Function for Pin PA3

	GPIOA->OSPEEDR |= (3<<4) | (3<<6);  // Bits (5:4)= 1:1 and Bits (7:6)= 1:1 --> High Speed for PIN PA2 and PA3

	GPIOA->AFR[0] |= (7<<8);  // Bytes (11:10:9:8) = 0:1:1:1  --> AF7 Alternate function for USART2 at Pin PA2
	GPIOA->AFR[0] |= (7<<12); // Bytes (15:14:13:12) = 0:1:1:1  --> AF7 Alternate function for USART2 at Pin PA3

}

void USART_Config()
{
	// Enable the UART CLOCK and GPIO CLOCK
	RCC->APB1ENR |= (1<<17);  // Enable UART2 CLOCK

	// Enable the USART by writing the UE bit in USART_CR1 register to 1.
	USART2->CR1 = 0x00;  // clear all
	USART2->CR1 |= (1<<13);  // UE = 1... Enable USART

	// Program the M bit in USART_CR1 to define the word length.
	USART2->CR1 &= ~(1<<12);  // M =0; 8 bit word length

	// Select the desired baud rate using the USART_BRR register.
	//USART2->BRR = (7<<0) | (24<<4);   // Baud rate of 115200, PCLK1 at 45MHz
	USART2->BRR = 0x1112;			// Baud Rate 9600

	// Enable the Transmitter/Receiver by Setting the TE and RE bits in USART_CR1 Register
	USART2->CR1 |= (1<<2); // RE=1.. Enable the Receiver
	USART2->CR1 |= (1<<3);  // TE=1.. Enable Transmitter
}


void UART2_SendChar (uint8_t c)
{
	USART2->DR = c; 			      	 // load the data into DR register
	while (!(USART2->SR & (1<<6)));  	// Wait for TC to SET.. This indicates that the data has been transmitted
}

void UART2_SendString (char *string)
{
	while (*string) UART2_SendChar (*string++);
}


void assign_the_data(char *buffer)
{
    char* ptr;
    ptr = &buffer[0];

    for(int i=0; i<20; i++)
    {
    	while (!(USART2->SR & (1<<5)));
        *(ptr+i) = USART2->DR;

        if(*(ptr+i) == '\n')
        	return;
    }
}


void SPI_Config()
{
	RCC->APB2ENR |= (1 << 12);								// SPI1 Clock Enable
	SPI1->CR1 |= (0 << 3);									// fPCLK/2 -> 84/2 = 42MHz
	SPI1->CR1 |= (1 << 0);									// Second clock transition first data capture edge.
	//SPI1->CR1 |= (1 << 0);
	SPI1->CR1 |= (0 << 11);									// 8 bit data
	SPI1->CR1 |= (0 << 10);									// Full duplex (Transmit and receive)
	SPI1->CR1 |= (0 << 7);									// MSB priority
	SPI1->CR1 |= (1 << 2);									// Master mode
	SPI1->CR1 |= (1 << 9) | (1 << 8);						// Software slave management enabled														// It ýs set when SSM is set
	SPI1->CR1 |= (1 << 6);									// SPI Enable

	GPIOE->ODR |= (1 << 3);
}


void  SPI_Write(uint8_t address, uint8_t data)
{

	GPIOE->ODR &= ~(1 << 3);
	while (!((SPI1->SR)&(1<<1)));  							// wait for TXE bit to set -> This will indicate that the buffer is empty
	SPI1->DR = address;
	while (!((SPI1->SR) &(1<<0)));							// Wait for RXNE to set -> This will indicate that the Rx buffer is not empty
	SPI1->DR;

	while (!((SPI1->SR)&(1<<1)));  							// wait for TXE bit to set -> This will indicate that the buffer is empty
	SPI1->DR = data;
	while (!((SPI1->SR) &(1<<0)));							// // Wait for RXNE to set -> This will indicate that the Rx buffer is not empty
	SPI1->DR;
	GPIOE->ODR |= (1 << 3);
}

uint8_t SPI_Read(uint8_t address, uint8_t data)
{
	GPIOE->ODR &= ~(1 << 3);
	address = address | 0x80;	// okuma islemi yapilacak
	while (!((SPI1->SR)&(1<<1)));  							// wait for TXE bit to set -> This will indicate that the buffer is empty
	SPI1->DR = address;
	while (!((SPI1->SR) &(1<<0)));							// // Wait for RXNE to set -> This will indicate that the Rx buffer is not empty
	SPI1->DR;
	while (!((SPI1->SR)&(1<<1)));  							// wait for TXE bit to set -> This will indicate that the buffer is empty
	SPI1->DR = data;
	while (!((SPI1->SR) &(1<<0)));							// // Wait for RXNE to set -> This will indicate that the Rx buffer is not empty
	SPI1->DR;
	GPIOE->ODR |= (1 << 3);
	return 	SPI1->DR;
}

int main(void)
{
  RCC_Config();
  GPIO_Config();
  SPI_Config();
  USART_Config();

  SPI_Write(0x20, 0x47);		// CTRL_REG1 100Hz +-8g

  while (1)
  {
	  x = SPI_Read(x_address, 0x00);
	  y = SPI_Read(y_address, 0x00);
	  z = SPI_Read(z_address, 0x00);

	  sprintf(str,"%d \n", x);
	  UART2_SendString(str);

	  sprintf(str,"%d \n", y);
	  UART2_SendString(str);

	  sprintf(str,"%d \n", z);
	  UART2_SendString(str);

	  delayy(600000);

  }
}

void EVAL_AUDIO_TransferComplete_CallBack(uint32_t pBuffer, uint32_t Size){
  /* TODO, implement your code here */
  return;
}


uint16_t EVAL_AUDIO_GetSampleCallBack(void){
  /* TODO, implement your code here */
  return -1;
}
