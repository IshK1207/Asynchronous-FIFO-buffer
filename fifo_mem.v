`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////




module fifo_mem #(parameter DEPTH=8, DATA_WIDTH=20, PTR_WIDTH=3) (
                  input wclk,
                  input w_en,
                  input rclk,
                  input r_en,
                  input [PTR_WIDTH-1:0] b_wptr,
                  input [PTR_WIDTH-1:0] b_rptr,
                  input [DATA_WIDTH-1:0] data_in,
                  input full,
                  input empty,
                  output reg [DATA_WIDTH-1:0] data_out);
  reg [DATA_WIDTH-1:0] fifo[0:DEPTH-1];
  
  always@(posedge wclk) begin
    if(w_en & !full) begin
      fifo[b_wptr] <= data_in;
    end
  end
  
  always@(posedge rclk) begin
    if(r_en & !empty) begin
      data_out <= fifo[b_rptr];
    end
  end
  
endmodule
