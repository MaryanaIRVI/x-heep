// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Description: uart2 top level wrapper file

`include "prim_assert.sv"

module uart2 #(
    parameter type reg_req_t = logic,
    parameter type reg_rsp_t = logic
) (
    input clk_i,
    input rst_ni,

    // Bus Interface
    //input  tlul_pkg::tl_h2d_t tl_i,
    //output tlul_pkg::tl_d2h_t tl_o,

    input  reg_req_t reg_req_i,
    output reg_rsp_t reg_rsp_o,

    // Generic IO
    input        cio_rx_i,
    output logic cio_tx_o,
    output logic cio_tx_en_o,

    // Interrupts
    output logic intr_tx_watermark_o,
    output logic intr_rx_watermark_o,
    output logic intr_tx_empty_o,
    output logic intr_rx_overflow_o,
    output logic intr_rx_frame_err_o,
    output logic intr_rx_break_err_o,
    output logic intr_rx_timeout_o,
    output logic intr_rx_parity_err_o
);

  import uart2_reg_pkg::*;

  uart2_reg2hw_t reg2hw;
  uart2_hw2reg_t hw2reg;

  uart2_reg_top #(
      .reg_req_t(reg_req_t),
      .reg_rsp_t(reg_rsp_t)
  ) u_reg_top_i (
      .clk_i,
      .rst_ni,
      .reg_req_i(reg_req_i),
      .reg_rsp_o(reg_rsp_o),
      .reg2hw,
      .hw2reg,
      .devmode_i(1'b1)
  );

  uart2_core uart2_core (
      .clk_i,
      .rst_ni,
      .reg2hw,
      .hw2reg,

      .rx(cio_rx_i),
      .tx(cio_tx_o),

      .intr_tx_watermark_o,
      .intr_rx_watermark_o,
      .intr_tx_empty_o,
      .intr_rx_overflow_o,
      .intr_rx_frame_err_o,
      .intr_rx_break_err_o,
      .intr_rx_timeout_o,
      .intr_rx_parity_err_o
  );

  // always enable the driving out of TX
  assign cio_tx_en_o = 1'b1;

  // Assert Known for outputs
  `ASSERT_KNOWN(txenKnown, cio_tx_en_o)
  `ASSERT_KNOWN(txKnown, cio_tx_o, clk_i, !rst_ni || !cio_tx_en_o)

  // Assert Known for interrupts
  `ASSERT_KNOWN(txWatermarkKnown, intr_tx_watermark_o)
  `ASSERT_KNOWN(rxWatermarkKnown, intr_rx_watermark_o)
  `ASSERT_KNOWN(txEmptyKnown, intr_tx_empty_o)
  `ASSERT_KNOWN(rxOverflowKnown, intr_rx_overflow_o)
  `ASSERT_KNOWN(rxFrameErrKnown, intr_rx_frame_err_o)
  `ASSERT_KNOWN(rxBreakErrKnown, intr_rx_break_err_o)
  `ASSERT_KNOWN(rxTimeoutKnown, intr_rx_timeout_o)
  `ASSERT_KNOWN(rxParityErrKnown, intr_rx_parity_err_o)

endmodule
