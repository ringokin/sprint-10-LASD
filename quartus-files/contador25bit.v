module contador25bit(
input clk, reset,
output modulo
);
reg [24:0] saida;
wire mod;
wire rst;

assign rst = reset | mod;
//assign mod = (saida[24:0] == 25'd20000000);
//assign mod = (saida[24:0] == 25'd25000000);
assign mod = (saida[24:0] == 25'd2500000);
//assign mod = (saida[24:0] == 'b1011111010111100001000000);
assign modulo = mod;
always @(posedge clk or posedge rst) begin
	if (rst)
		saida <= 25'd0;
	else
		saida <= saida + 25'd1;
end

endmodule 