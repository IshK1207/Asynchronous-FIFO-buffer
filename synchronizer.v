`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module synchronizer #(parameter WIDTH=3)
                     (input clk,
                      input rst_n,
                      input [WIDTH:0] d_in,
                      output reg [WIDTH:0] d_out);
  reg [WIDTH:0] q1;
  always@(rst_n) begin
    if(!rst_n) begin
      q1 <= 0;
      d_out <= 0;
    end
 end
 always@(posedge clk) begin
    if(!rst_n) begin
      q1 <= d_in;
      d_out <= q1;
    end
    else begin
      q1 <= 0;
      d_out <= 0;
    end
 end
endmodule
