/*
Prueba simplificada de la comunicación UART2 con el pin duplicado.

Autora : Maryana Pyzh
Fecha : 21-04-2025
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <core_v_mini_mcu.h>
#include <gpio.h>
#include <gpio_regs.h>
#include <mmio.h>

#include <uart.h>
#include <uart2_regs.h>

#include <x-heep.h>


// Define un retardo aproximado de 1 segundo, 1seg=1millon
void delay_approx_1s() {
    for (volatile int i = 0; i < 1000000; i++);
}


int main(int argc, char *argv[])
{

    const char buffer[100] = {0};  // Inicializamos el buffer a ceros

    uart_t uart2 = {
        .base_addr = mmio_region_from_addr(UART2_START_ADDRESS),
        .baudrate = UART_BAUDRATE,  // Asegurar baudrate estándar
        .clk_freq_hz = REFERENCE_CLOCK_Hz,  // Frecuencia del reloj de referencia
        .nco = UART_NCO  // Cálculo preciso de NCO
    };

    printf("UART2 Test\n");

    // Inicializa la UART2
    uart_init(&uart2);

    const char *message = "Pynq-z2 se ha comunicado por UART2\n";

    printf("Mensaje a enviado: %s\n", message);

    // Enviar el mensaje a través de UART2
    uart_write(&uart2, (const uint8_t *)message, strlen(message));

    delay_approx_1s();

    // Recibir el mensaje a través de UART2
    uart_read(&uart2, (const uint8_t *)buffer, strlen(message));

    delay_approx_1s();

    printf("Mensaje recibido: %s\n", buffer);

    return EXIT_SUCCESS;
}


