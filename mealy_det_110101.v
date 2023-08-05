`timescale 1ns/1ns

module det_110101_tb;
reg clk=0, reset,in;
wire [7:0] out;

det_110101 u1(clk,reset,in,out);

always begin clk=~clk;
#10;
end

always @(*) begin
$display("%0t time= reset=%b in=%b out=%h ",$time,reset,in,out );

end

initial begin 

reset=1'b1;
#20;
reset=1'b0;
in=1'b1;
#20;
in=1'b1;
#20;
in=1'b0;
#20;
in=1'b1;
#20;
in=1'b0;
#20;
in=1'b1;
#20;
//
in=1'b0;
#20;
in=1'b1;
#20;
in=1'b1;
#20;
in=1'b1;
#20;
in=1'b0;
#20;
in=1'b1;
#20;
in=1'b0;
#20;
in=1'b1;
#20;
$finish;
end


endmodule



module det_110101(input clk,reset,in,
                  output reg [7:0]out);
reg [2:0] curr_state,next_state;
//states
parameter IDLE = 3'b000;
parameter s1 = 3'b001;
parameter s11 = 3'b010;
parameter s110 = 3'b011;
parameter s1101 = 3'b100;
parameter s11010 = 3'b101;
parameter s110101 = 3'b110;
//moore

always @(posedge clk)
begin
if(reset) curr_state<=IDLE;
else curr_state<=next_state;
end
//mealy machine
always @(curr_state or in) begin
if (curr_state==IDLE) begin out='h1F; end
if (curr_state==s1) begin out='h2F; end
if (curr_state==s11) begin out='h3F; end
if (curr_state==s110) begin out='h4F; end
if (curr_state==s1101) begin out='h5F; end
if (curr_state==s11010) begin out='h6F; end
if (curr_state==s110101) begin out='h1A; end
end


always @(curr_state or in)
begin
case(curr_state)
IDLE:  if(in) next_state=s1;
      else next_state=IDLE; 

s1:  if(in) next_state=s11;
      else next_state=IDLE; 

s11:  if(in) next_state=s11;
      else next_state=s110; 

s110:  if(in) next_state=s1101;
      else next_state=IDLE; 

s1101:  if(in) next_state=IDLE;
       else next_state=s11010; 

s11010:  if(in) next_state=s110101;
        else next_state=IDLE; 

s110101:  if(in) next_state=s1;
         else next_state=IDLE; 

endcase
end
endmodule
