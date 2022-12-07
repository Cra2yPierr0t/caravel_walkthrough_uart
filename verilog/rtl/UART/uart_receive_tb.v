module uart_receive_tb;
  reg rst = 1'b0;
  reg clk = 1'b0;
  reg rx  = 1'b1;
  reg read = 1'b0;
  reg irq_en = 1'b1;
  wire irq;
  wire [7:0] rx_data;

  always #1 begin
      clk <= ~clk;
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, DUT);
  end

  uart_receive DUT(
    .rst    (rst    ),
    .clk    (clk    ),
    .clk_div(32'd8  ),
    .rx     (rx     ),
    .read   (read   ),
    .irq_en (irq_en ),
    .irq    (irq    ),
    .rx_data(rx_data)
  );

  parameter UART_CLK=8*2;

  initial begin
    rx = 1'b1;
    #100
    rx = 1'b0; // start
    #UART_CLK
    rx = 1'b1;
    #UART_CLK
    rx = 1'b0;
    #UART_CLK
    rx = 1'b0;
    #UART_CLK
    rx = 1'b0;
    #UART_CLK
    rx = 1'b0;
    #UART_CLK
    rx = 1'b0;
    #UART_CLK
    rx = 1'b1;
    #UART_CLK
    rx = 1'b0;
    #UART_CLK
    rx = 1'b1;
    #100
    read = 1'b1;
    #2
    read = 1'b0;
    #100
    $finish;
  end

endmodule
