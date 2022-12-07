module uart #(
  parameter BAUD_RATE = 115200
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif
  // Wishbone Slave ports (WB MI A)
  input wire    wb_clk_i,
  input wire    wb_rst_i,
  input wire    wbs_stb_i,
  input wire    wbs_cyc_i,
  input wire    wbs_we_i,
  input wire    [3:0] wbs_sel_i,
  input wire    [31:0] wbs_dat_i,
  input wire    [31:0] wbs_adr_i,
  output wire   wbs_ack_o,
  output wire   [31:0] wbs_dat_o,

  // UART ports
  output wire   tx,
  input wire    rx,

  // irq
  output wire   irq
);

  // CSR
  wire [31:0] clk_freq;

  wire [7:0] rx_data;
  wire       irq_en;
  wire       read;

  wire [7:0] tx_data;
  wire tx_clear_req;
  wire tx_start;

  CSR CSR(
    .i_clk      (wb_clk_i   ),
    .i_rst_n    (~wb_rst_i  ),
    .i_wb_cyc   (wbs_cyc_i  ),
    .i_wb_stb   (wbs_stb_i  ),
    .o_wb_stall (),
    .i_wb_adr   (wbs_adr_i  ),
    .i_wb_we    (wbs_we_i   ),
    .i_wb_dat   (wbs_dat_i ),
    .i_wb_sel   (wbs_sel_i  ),
    .o_wb_ack   (wbs_ack_o ),
    .o_wb_err   (),
    .o_wb_rty   (),
    .o_wb_dat   (wbs_dat_o  ),
    .o_CLOCK_FREQ_clock_freq            (clk_freq   ),
    .i_RECEIVED_DATA_rx                 (rx_data    ),
    .o_RECEIVED_DATA_rx_read_trigger    (read       ),
    .o_TRANSMISSION_DATA_tx             (tx_data    ),
    .o_INTERRUPT_ENABLE_irq_en          (irq_en     ),
    .i_TRANSMISSION_START_tx_start_clear(tx_clear_req),
    .o_TRANSMISSION_START_tx_start      (tx_start   )
  );

  wire [31:0] clk_div;
  assign clk_div = clk_freq / BAUD_RATE;

  uart_receive      receive(
    .rst        (wb_rst_i   ),
    .clk        (wb_clk_i   ),
    .clk_div    (clk_div    ),
    .rx         (rx         ),
    .rx_data    (rx_data    ),
    .read       (read       ),
    .irq_en     (irq_en     ),
    .irq        (irq        )
  );

  uart_transmission transmission(
    .rst        (wb_rst_i   ),
    .clk        (wb_clk_i   ),
    .clk_div    (clk_div    ),
    .tx         (tx         ),
    .tx_data    (tx_data    ),
    .clear_req  (tx_clear_req),
    .tx_start   (tx_start   )
  );

endmodule
