module uart_transmission_tb;
  reg rst = 1'b0;
  reg clk = 1'b0;
  reg [7:0] tx_data = 8'h41;
  reg tx_start = 1'b0;
  wire tx;
  wire clear_req;

  always #1 begin
      clk <= ~clk;
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, DUT);
  end

  uart_transmission DUT(
    .rst        (rst    ),
    .clk        (clk    ),
    .clk_div    (32'd8  ),
    .tx         (tx     ),
    .tx_data    (tx_data),
    .tx_start   (tx_start ),
    .clear_req  (clear_req)
  );

  parameter UART_CLK=8*2;

  initial begin
    #100
    tx_start <= 1'b1;
    #2
    tx_start <= 1'b0;
    #200
    tx_data <= 8'h0f;
    tx_start <= 1'b1;
    #2
    tx_start <= 1'b0;
    #500
    $finish;
  end

endmodule
