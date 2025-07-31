module MUX_REG_INPUT (in,sel,out,CLK,rst,enable);
parameter WIDTH = 1 ;
parameter MODE="SYNC";
input [WIDTH-1:0]in;
input sel,rst,CLK,enable;
output [WIDTH-1:0] out ;
generate 
if (MODE=="SYNC") sync_model #(.WIDTH(WIDTH)) SS(in,sel,out,CLK,rst,enable);
else Async_model #(.WIDTH(WIDTH)) AA(in,sel,out,CLK,rst,enable);
endgenerate
endmodule //MUX_REG_INPUT
module sync_model(in,sel,out,CLK,rst,enable);
parameter WIDTH = 1 ;
input [WIDTH-1:0]in;
input sel,rst,CLK,enable;
output [WIDTH-1:0] out ;
reg [WIDTH-1:0] out_reg ;
assign out =(sel)?out_reg:in;
always @(posedge CLK) begin
  if(rst) out_reg<=0;
  else if (enable) begin
    out_reg<=in;
  end
end
endmodule
module Async_model(in,sel,out,CLK,rst,enable);
parameter WIDTH = 1 ;
input [WIDTH-1:0]in;
input sel,rst,CLK,enable;
output [WIDTH-1:0] out ;
reg [WIDTH-1:0] out_reg ;
assign out =(sel)?out_reg:in;
always @(posedge CLK or posedge rst) begin
  if(rst) out_reg<=0;
  else if (enable) begin
    out_reg<=in;
  end
end
endmodule