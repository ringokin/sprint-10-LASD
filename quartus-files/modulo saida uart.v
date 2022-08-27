// Code your design here
module saidaUART(
  input reset,
  input [7:0] ParalelIn,
  input H ,clock, 
  output reg SerialOut,
  output Idle
);
  parameter IDLE = 0;
  parameter INICIO = 1;
  parameter ESCRITA = 2;
  parameter FIM = 3;
  
  reg resetCLK;
  reg [1:0] estado;
  reg [3:0] PosAtual;
  reg [7:0] entrada;
  wire clkAux;
  
  //assign flag = ~estado[0] & ~estado[1];
  
  assign Idle = (estado == IDLE)?1:0;
  
  always@(negedge clock or posedge reset)begin
	 if (reset) begin
		 resetCLK = 0;
		 estado = 0;
		 PosAtual = 0;
	 end
	 else if ((estado == IDLE) & H)begin
      entrada = ParalelIn;
      PosAtual = 3'b000;
      estado = INICIO;
    end
    else if (estado == INICIO)begin
      SerialOut = 0;
      estado = ESCRITA;
    end
    else if (estado == ESCRITA)begin
      SerialOut = entrada[PosAtual];
      if (PosAtual == 3'b111)
        estado = FIM;
      PosAtual = PosAtual + 1;
    end
    else if (estado == FIM) begin
      SerialOut = 1;
      estado = IDLE;
    end
  end
  
  
  
endmodule
  