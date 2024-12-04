`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module rhandler #(parameter PTR_WIDTH=3) (
                  input rclk,
                  input rrst_n, 
                  input r_en,
                  input [PTR_WIDTH:0] g_wptr_sync,
                  output reg [PTR_WIDTH-1:0] b_rptr,
                  output reg [PTR_WIDTH-1:0] g_rptr,
                  output reg empty);
                
reg [PTR_WIDTH-1:0] b_rptr_next;
wire [PTR_WIDTH-1:0] g_rptr_next;

assign g_rptr_next = (b_rptr_next >>1)^b_rptr_next;
assign rempty = (g_wptr_sync == g_rptr_next);
  
always @(posedge rclk)
begin
    if (!rrst_n & r_en) begin
        if (!rempty) begin
            b_rptr <= b_rptr_next;
            g_rptr <= g_rptr_next;
            b_rptr_next <= b_rptr_next + 1;
            empty <= rempty;
        end
    end
    else if(rrst_n)
    begin
        b_rptr <= 0;
        g_rptr <= 0;
        b_rptr_next <= 1;
        empty <= 1;
    end
end
endmodule