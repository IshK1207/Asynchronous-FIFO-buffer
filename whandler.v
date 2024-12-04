`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////



module whandler #(parameter PTR_WIDTH=3) (
                  input wclk,
                  input wrst_n, 
                  input w_en,
                  input [PTR_WIDTH-1:0] g_rptr_sync,
                  output reg [PTR_WIDTH-1:0] b_wptr,
                  output reg [PTR_WIDTH-1:0] g_wptr,
                  output reg full);
                
reg [PTR_WIDTH-1:0] b_wptr_next;
wire [PTR_WIDTH-1:0] g_wptr_next;

assign g_wptr_next = (b_wptr_next >>1)^b_wptr_next;
assign wfull = (g_rptr_sync == g_wptr_next);
  
always @(posedge wclk)
begin
    if (!wrst_n & w_en) begin
        if (!wfull) begin
            b_wptr <= b_wptr_next;
            g_wptr <= g_wptr_next;
            b_wptr_next <= b_wptr_next + 1;
            full <= wfull;
        end
    end
    else if(wrst_n)
    begin
        b_wptr <= 0;
        g_wptr <= 0;
        b_wptr_next <= 1;
        full <= 1;
    end
end
  
endmodule