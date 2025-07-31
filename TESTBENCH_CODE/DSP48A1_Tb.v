module DSP48A1_Tb ();
reg CLK,CARRYIN,CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP;
reg RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP;
reg [17:0]A,B,D,BCIN;
reg [47:0]C,PCIN;
reg [7:0]OPMODE;
wire CARRYOUT,CARRYOUTF;
wire [47:0]P,PCOUT;
wire [35:0] M;
wire [17:0] BCOUT ;
DSP48A1 TEST(A,B,C,D,BCIN,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,CEA,CEB,CEC,CECARRYIN
,CED,CEM,CEOPMODE,CEP,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP,BCOUT,PCIN,PCOUT);
initial begin
    CLK=0;
    forever begin
        #1 CLK=~CLK;
    end
end
initial begin
{RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP}=8'b11111111;
A=$random; B=$random; C=$random; D=$random; BCIN=$random; CARRYIN=$random;
OPMODE=$random; CEA=$random; CEB=$random; CEC=$random; CECARRYIN=$random;
CED=$random; CEM=$random; CEOPMODE=$random;  CEP=$random; PCIN=$random;
repeat(2)@(negedge CLK); //// ro be clearly
if({P,M,CARRYOUT,CARRYOUTF,BCOUT,PCOUT}!=0)begin
  $display("ERROR IN RST FUNCTION");
  $stop;
end
/////PATH1
{RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP}=0;
{CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP}=8'b11111111;
A=20; B=10; C=350; D=25;
BCIN=$random; CARRYIN=$random; PCIN=$random;
OPMODE=8'b11011101;
repeat(4)@(negedge CLK);
if(BCOUT!='hf || M!='h12c ||P!='h32||PCOUT!='h32||CARRYOUT!=0||CARRYOUTF!=0)begin
  $display("ERROR IN PATH1");
  $stop;
end
/// Path 2
 A=20; B=10; C=350; D=25;
BCIN=$random; CARRYIN=$random; PCIN=$random;
OPMODE=8'b00010000;
repeat(3)@(negedge CLK);
if(BCOUT!='h23 || M!='h2bc ||P!=0||PCOUT!=0||CARRYOUT!=0||CARRYOUTF!=0)begin
  $display("ERROR IN PATH2");
  $stop;
end
/// path 3
A=20; B=10; C=350; D=25;
BCIN=$random; CARRYIN=$random; PCIN=$random;
OPMODE=8'b00001010;
repeat(3)@(negedge CLK);
if(BCOUT!='ha || M!='hc8 ||P!=0||PCOUT!=0||CARRYOUT!=0||CARRYOUTF!=0)begin
  $display("ERROR IN PATH3");
  $stop;
end
//// PATH4
A=5; B=6; C=350; D=25;
BCIN=$random; CARRYIN=$random; PCIN=3000;
OPMODE=8'b10100111;
repeat(3)@(negedge CLK);
if(BCOUT!='h6 || M!='h1e ||P!='hfe6fffec0bb1||PCOUT!='hfe6fffec0bb1||CARRYOUT!=1||CARRYOUTF!=1)begin
  $display("ERROR IN PATH4");
  $stop;
end
@(negedge CLK); // to make last out obvious 
$stop;
end
endmodule 