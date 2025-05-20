# Copyright 2025 IRVI
# Solderpad Hardware License, Version 2.1, see LICENSE.md for details.
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

## Clock signal
set_property -dict { PACKAGE_PIN R4 IOSTANDARD LVCMOS33 } [get_ports {clk_i}]; #IO_L13P_T2_MRCC_34 Sch=sysclk
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets jtag_tck_i_IBUF]

set_property -dict { PACKAGE_PIN G4  IOSTANDARD LVCMOS15 } [get_ports {rst_i}]; #IO_L12N_T1_MRCC_35 Sch=cpu_resetn


## LEDs
# the two first LEDs are used for the reset and clock signals
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS25 } [get_ports { rst_led_o }]; #IO_L15P_T2_DQS_13 Sch=led[0]
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS25 } [get_ports { clk_led_o }]; #IO_L15N_T2_DQS_13 Sch=led[1]
# the last two LEDs are used for the exit signal
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS25 } [get_ports { exit_valid_o }]; #IO_L16P_T2_13 Sch=led[6]
set_property -dict { PACKAGE_PIN Y13   IOSTANDARD LVCMOS25 } [get_ports { exit_value_o }]; #IO_L5P_T0_13 Sch=led[7]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_led_o_OBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets rst_led_o_OBUF]

##Switches
# switch[1] is used to select the execution mode
set_property -dict { PACKAGE_PIN F21  IOSTANDARD LVCMOS12 } [get_ports { execute_from_flash_i }]; #IO_25_16 Sch=sw[1]
# switch[2] is used to select the boot mode
set_property -dict { PACKAGE_PIN G21  IOSTANDARD LVCMOS12 } [get_ports { boot_select_i }]; #IO_L24P_T3_16 Sch=sw[2]

##Switches
# switch[0] is used to reset the JTAG controller
set_property -dict { PACKAGE_PIN E22  IOSTANDARD LVCMOS12 } [get_ports { jtag_trst_ni }]; #IO_L22P_T3_16 Sch=sw[0]

## PMOD JB and JC are used for the programming interface

# FLASH
# QSPI
# Q0 / MOSI
# Q1 / MISO
# Q2 / nWP
# Q3 / nHLD
## Pmod Header JB
set_property -dict { PACKAGE_PIN W9    IOSTANDARD LVCMOS33 } [get_ports { spi_flash_csb_o }]; #IO_L24P_T3_34 Sch=jb_p[3]
set_property -dict { PACKAGE_PIN V9    IOSTANDARD LVCMOS33 } [get_ports { spi_flash_sck_o }]; #IO_L21P_T3_DQS_34 Sch=jb_p[1]
set_property -dict { PACKAGE_PIN Y9    IOSTANDARD LVCMOS33 } [get_ports { spi_flash_sd_io[0] }]; #IO_L24N_T3_34 Sch=jb_n[3]
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { spi_flash_sd_io[1] }]; #IO_L21N_T3_DQS_34 Sch=jb_n[1]
set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { spi_flash_sd_io[2] }]; #IO_L23P_T3_34 Sch=jb_p[4]
set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { spi_flash_sd_io[3] }]; #IO_L19P_T3_34 Sch=jb_p[2]

## Pmod Header JC
# UART
set_property -dict { PACKAGE_PIN Y6    IOSTANDARD LVCMOS33 } [get_ports { uart_tx_o }]; #IO_L18P_T2_34 Sch=jc_p[1]
set_property -dict { PACKAGE_PIN R6    IOSTANDARD LVCMOS33 } [get_ports { uart_rx_i }]; #IO_L17P_T2_34 Sch=jc_p[3]
# JTAG
set_property -dict { PACKAGE_PIN AA6   IOSTANDARD LVCMOS33 } [get_ports { jtag_tdi_i }]; #IO_L18N_T2_34 Sch=jc_n[1]
set_property -dict { PACKAGE_PIN AB7   IOSTANDARD LVCMOS33 } [get_ports { jtag_tdo_o }]; #IO_L20P_T3_34 Sch=jc_p[4]
set_property -dict { PACKAGE_PIN AA8   IOSTANDARD LVCMOS33 } [get_ports { jtag_tms_i }]; #IO_L22P_T3_34 Sch=jc_p[2]
set_property -dict { PACKAGE_PIN T6    IOSTANDARD LVCMOS33 } [get_ports { jtag_tck_i }]; #IO_L17N_T2_34 Sch=jc_n[3]
# I2C
set_property -dict { PACKAGE_PIN AB6   IOSTANDARD LVCMOS33 } [get_ports { i2c_scl_io }]; #IO_L20N_T3_34 Sch=jc_n[4]
set_property -dict { PACKAGE_PIN AB8   IOSTANDARD LVCMOS33 } [get_ports { i2c_sda_io }]; #IO_L22N_T3_34 Sch=jc_n[2]

#####################################################################################################################
## The following pins are mandatory to be connected. In other case, the vivado tool will not be able to generate the bitstream with the following error: "ERROR: [DRC NSTD-1] Unspecified I/O Standard: 36 out of 59 logical ports use I/O standard (IOSTANDARD) value 'DEFAULT', instead of a user assigned specific value."
## At the moment, this signals are not used.
#####################################################################################################################

## Pmod Header JA
## SPI SD
set_property -dict { PACKAGE_PIN AB22  IOSTANDARD LVCMOS33 } [get_ports { spi_csb_o }]; #IO_L10N_T1_D15_14 Sch=ja[1]
set_property -dict { PACKAGE_PIN AB21  IOSTANDARD LVCMOS33 } [get_ports { spi_sck_o }]; #IO_L10P_T1_D14_14 Sch=ja[2]
set_property -dict { PACKAGE_PIN AB20  IOSTANDARD LVCMOS33 } [get_ports { spi_sd_io[0] }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=ja[3]
set_property -dict { PACKAGE_PIN AB18  IOSTANDARD LVCMOS33 } [get_ports { spi_sd_io[1] }]; #IO_L17N_T2_A13_D29_14 Sch=ja[4]
set_property -dict { PACKAGE_PIN Y21   IOSTANDARD LVCMOS33 } [get_ports { spi_sd_io[2] }]; #IO_L9P_T1_DQS_14 Sch=ja[7]
set_property -dict { PACKAGE_PIN AA21  IOSTANDARD LVCMOS33 } [get_ports { spi_sd_io[3] }]; #IO_L8N_T1_D12_14 Sch=ja[8]

## SPI2 SD
set_property -dict { PACKAGE_PIN A19   IOSTANDARD LVCMOS12 } [get_ports { spi2_sd_io[0] }]; #IO_L17N_T2_16 Sch=fmc_la_n[19]
set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS12 } [get_ports { spi2_sd_io[1] }]; #IO_L17P_T2_16 Sch=fmc_la_p[19]
set_property -dict { PACKAGE_PIN F20   IOSTANDARD LVCMOS12 } [get_ports { spi2_sd_io[2] }]; #IO_L18N_T2_16 Sch=fmc_la_n[20]
set_property -dict { PACKAGE_PIN F19   IOSTANDARD LVCMOS12 } [get_ports { spi2_sd_io[3] }]; #IO_L18P_T2_16 Sch=fmc_la_p[20]

# GPIOs
set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[0] }]; #IO_L14N_T2_SRCC_16 Sch=fmc_la_n[21]
set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[1] }]; #IO_L14P_T2_SRCC_16 Sch=fmc_la_p[21]
set_property -dict { PACKAGE_PIN D21   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[2] }]; #IO_L23N_T3_16 Sch=fmc_la_n[22]
set_property -dict { PACKAGE_PIN E21   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[3] }]; #IO_L23P_T3_16 Sch=fmc_la_p[22]
set_property -dict { PACKAGE_PIN A21   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[4] }]; #IO_L21N_T3_DQS_16 Sch=fmc_la_n[23]
set_property -dict { PACKAGE_PIN B21   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[5] }]; #IO_L21P_T3_DQS_16 Sch=fmc_la_p[23]
set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[6] }]; #IO_L7N_T1_16 Sch=fmc_la_n[24]
set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[7] }]; #IO_L7P_T1_16 Sch=fmc_la_p[24]
set_property -dict { PACKAGE_PIN E17   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[8] }]; #IO_L2N_T0_16 Sch=fmc_la_n[25]
set_property -dict { PACKAGE_PIN F16   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[9] }]; #IO_L2P_T0_16 Sch=fmc_la_p[25]
set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[10] }]; #IO_L15N_T2_DQS_16 Sch=fmc_la_n[26]
set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[11] }]; #IO_L15P_T2_DQS_16 Sch=fmc_la_p[26]
set_property -dict { PACKAGE_PIN A20   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[12] }]; #IO_L16N_T2_16 Sch=fmc_la_n[27]
set_property -dict { PACKAGE_PIN B20   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[13] }]; #IO_L16P_T2_16 Sch=fmc_la_p[27]
set_property -dict { PACKAGE_PIN B13   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[14] }]; #IO_L8N_T1_16 Sch=fmc_la_n[28]
set_property -dict { PACKAGE_PIN C13   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[15] }]; #IO_L8P_T1_16 Sch=fmc_la_p[28]
set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[16] }]; #IO_L3N_T0_DQS_16 Sch=fmc_la_n[29]
set_property -dict { PACKAGE_PIN C14   IOSTANDARD LVCMOS12 } [get_ports { gpio_io[17] }]; #IO_L3P_T0_DQS_16 Sch=fmc_la_p[29]

# PDM2PCM
set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS12 } [get_ports { pdm2pcm_clk_io }]; #IO_L10N_T1_16 Sch=fmc_la_n[30]
set_property -dict { PACKAGE_PIN A13   IOSTANDARD LVCMOS12 } [get_ports { pdm2pcm_pdm_io }]; #IO_L10P_T1_16 Sch=fmc_la_p[30]

# I2S
set_property -dict { PACKAGE_PIN E14   IOSTANDARD LVCMOS12 } [get_ports { i2s_sck_io }]; #IO_L4N_T0_16 Sch=fmc_la_n[31]
set_property -dict { PACKAGE_PIN E13   IOSTANDARD LVCMOS12 } [get_ports { i2s_ws_io }]; #IO_L4P_T0_16 Sch=fmc_la_p[31]
set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS12 } [get_ports { i2s_sd_io }]; #IO_L9N_T1_DQS_16 Sch=fmc_la_n[32]

# SPI2
set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS12 } [get_ports { spi2_csb_o[0] }]; #IO_L9P_T1_DQS_16 Sch=fmc_la_p[32]
set_property -dict { PACKAGE_PIN F14   IOSTANDARD LVCMOS12 } [get_ports { spi2_csb_o[1] }]; #IO_L1N_T0_16 Sch=fmc_la_n[33]
set_property -dict { PACKAGE_PIN F13   IOSTANDARD LVCMOS12 } [get_ports { spi2_sck_o }]; #IO_L1P_T0_16 Sch=fmc_la_p[33]