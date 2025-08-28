// Copyright 2022 OpenHW Group
// Solderpad Hardware License, Version 2.1, see LICENSE.md for details.
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1

module debug_subsystem
  import obi_pkg::*;
#(
    parameter NRHARTS = 1,
    parameter JTAG_IDCODE = 32'h10001c05
) (
    input logic clk_i,
    input logic rst_ni,

    //JTAG
    input  logic jtag_tck_i,
    input  logic jtag_tms_i,
    input  logic jtag_trst_ni,
    input  logic jtag_tdi_i,
    output logic jtag_tdo_o,


    output logic debug_ndmreset_no,
    output logic [NRHARTS-1:0] debug_core_req_o,

    output obi_req_t  debug_master_req_o,
    input  obi_resp_t debug_master_resp_i

);

  import dm::*;

  logic [NRHARTS-1:0]    unavailable;
  dm::hartinfo_t [NRHARTS-1:0] hartinfo;
  logic dmi_rst_n;

  always_comb begin
    for (int i = 0; i < NRHARTS; i++) begin
      hartinfo[i].zero1 = '0;
      hartinfo[i].nscratch = 2;  // Debug module needs at least two scratch regs
      hartinfo[i].zero0 = '0;
      hartinfo[i].dataaccess = 1'b1;  // data registers are memory mapped in the debugger
      hartinfo[i].datasize = dm::DataCount;
      hartinfo[i].dataaddr = dm::DataAddr;
      unavailable[i] = ~(1'b1);
    end
  end

  dm::dmi_req_t  dmi_req;
  logic          dmi_req_valid;
  logic          dmi_req_ready;
  dm::dmi_resp_t dmi_resp;
  logic          dmi_resp_ready;
  logic          dmi_resp_valid;
  logic          ndmreset;

  obi_req_t dm_req, spi_slave_req;
  obi_resp_t dm_resp, spi_slave_resp;

  obi_req_t tofifo_req;
  obi_resp_t tofifo_resp;
  obi_req_t [2-1:0] dbg_spi_req;
  obi_resp_t [2-1:0] dbg_spi_resp;

  assign debug_ndmreset_no = ~ndmreset;

  // Default assignment for debug_core_req_o (no debug module instantiated)
  assign debug_core_req_o  = '0;

  dmi_jtag #(
      .IdcodeValue(JTAG_IDCODE)
  ) dmi_jtag_i (
      .clk_i           (clk_i),
      .rst_ni          (rst_ni),
      .testmode_i      (1'b0),
      .dmi_req_o       (dmi_req),
      .dmi_req_valid_o (dmi_req_valid),
      .dmi_req_ready_i (dmi_req_ready),
      .dmi_resp_i      (dmi_resp),
      .dmi_resp_ready_o(dmi_resp_ready),
      .dmi_resp_valid_i(dmi_resp_valid),
      .dmi_rst_no      (dmi_rst_n),
      .tck_i           (jtag_tck_i),
      .tms_i           (jtag_tms_i),
      .trst_ni         (jtag_trst_ni),
      .td_i            (jtag_tdi_i),
      .td_o            (jtag_tdo_o),
      .tdo_oe_o        ()
  );

  assign tofifo_req         = '0;
  assign tofifo_resp        = '0;
  assign dbg_spi_req[0]     = '0;
  assign dbg_spi_req[1]     = '0;
  assign dbg_spi_resp[0]    = '0;
  assign dbg_spi_resp[1]    = '0;
  assign debug_master_req_o = dm_req;
  assign dm_resp            = debug_master_resp_i;

  // Default assignments for DMI interface (no debug module instantiated)
  assign dm_req             = '0;
  assign dmi_req_ready      = 1'b0;
  assign dmi_resp           = '0;
  assign dmi_resp_valid     = 1'b0;
  assign ndmreset           = 1'b0;


endmodule : debug_subsystem
