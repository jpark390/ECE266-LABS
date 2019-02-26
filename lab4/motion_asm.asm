; To include names declared in C
                .cdecls "stdint.h", "stdbool.h", "stdio.h", "inc/hw_memmap.h", "driverlib/pin_map.h", "driverlib/gpio.h", "driverlib/sysctl.h", "launchpad.h", "motion.h"

                .text

                .global motionDetect


MOTION_PERIPH   .field  SYSCTL_PERIPH_GPIOC
MOTION_PORT     .field  GPIO_PORTC_BASE
MOTION_PIN      .equ    GPIO_PIN_4


motion      PUSH    {LR}
de
                ; Initialize the GPIO peripheral for the port that the buzzer uses:
                ;   Call SysCtlPeripheralEnable(MOTION_PERIPH)
                LDR     r0, MOTION_PERIPH
                BL      SysCtlPeripheralEnable

                ; Set the GPIO pin for the buzzer as output type:
                ;   Call GPIOPinTypeGPIOOutput(MOTION_PORT, MOTION_PIN)
                LDR     r0, MOTION_PORT
                MOV     r1, #MOTION_PIN
                BL      GPIOPinTypeGPIOInput

                POP     {PC}

;
; void motionOn(): Turn on the motion. It calls GPIOPinWrite() to write 1 to the signal pin.
;
motionDetect        PUSH    {LR}

                ; Write 1 to the GPIO pin that the motion uses:
                ;   Call GPIOPinWrite(MOTION_PORT, MOTION_PIN, MOTION_PIN)
                LDR     r0, MOTION_PORT
                MOV     r1, #MOTION_PIN

                BL      GPIOPinRead

                POP     {PC}

;

