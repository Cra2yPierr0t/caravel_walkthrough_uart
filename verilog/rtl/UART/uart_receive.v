module uart_receive (
  input wire        rst,
  input wire        clk,
  input wire [31:0] clk_div,
  input wire        rx,
  input wire        read,
  input wire        irq_en,
  output reg        irq     = 1'b0,
  output reg [7:0]  rx_data = 8'h0
);

  parameter WAIT        = 4'b0000;
  parameter START_BIT   = 4'b0001;
  parameter GET_DATA    = 4'b0010;
  parameter STOP_BIT    = 4'b0011;
  parameter WAIT_READ   = 4'b0100;

  reg [3:0] state;

  reg [31:0] clk_cnt = 32'h0000_0000;

  reg [2:0] rx_index = 3'b000;

  always @(posedge clk) begin
    if(rst) begin
      state     <= WAIT;
      clk_cnt   <= 32'h0000_0000;
      rx_index  <= 3'b000;
      irq       <= 1'b0;
      rx_data   <= 8'h0;
    end else begin
      case(state)
        WAIT      : begin
          irq <= 1'b0;
          if(rx == 1'b0) begin
            state <= START_BIT;
          end
        end
        START_BIT : begin
          // check the middle of wave
          if(clk_cnt == ((clk_div >> 1) - 1)) begin
            clk_cnt <= 32'h0000_0000;
            if(rx == 1'b0) begin
              state <= GET_DATA;
            end
          end else begin
            clk_cnt <= clk_cnt + 32'h0000_0001;
          end
        end
        GET_DATA  : begin
          // get the middle of wave
          if(clk_cnt == (clk_div - 1)) begin
            clk_cnt <= 32'h0000_0000;
            if(rx_index == 3'b111) begin
              state <= STOP_BIT;
            end
            rx_index <= rx_index + 3'b001;
            rx_data[rx_index] <= rx;
          end else begin
            clk_cnt <= clk_cnt + 32'h0000_0001;
          end
        end
        STOP_BIT  : begin
          // check the middle of wave
          if(clk_cnt == (clk_div - 1)) begin
            clk_cnt <= 32'h0000_0000;
            if(rx == 1'b1) begin
              state <= WAIT_READ;
              if(irq_en) begin
                irq <= 1'b1;
              end
            end
          end else begin
            clk_cnt <= clk_cnt + 32'h0000_0001;
          end
        end
        WAIT_READ : begin
          if(read) begin
            irq <= 1'b0;
            state <= WAIT;
          end
        end
        default   : begin
          state     <= WAIT;
          clk_cnt   <= 32'h0000_0000;
          rx_index  <= 3'b000;
          irq       <= 1'b0;
          rx_data   <= 8'h0;
        end
      endcase
    end
  end

endmodule
