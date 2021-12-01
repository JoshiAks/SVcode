// Moore Sequence Detector for 01011
module seq_det_moore(
  input logic clk,
  input logic rst,
  input logic in,  
  output logic out
); 
 
// Students to add code for Moore Sequence Detector

//Parameters to define FSM state encodings
localparam[5:0] IDLE=6'b000001,
					S1=6'b000010,
					S2=6'b000100,
					S3=6'b001000,
					S4=6'b010000,
					S5=6'b100000;
					
//Current state and next state variables
logic[5:0] present_state, next_state;

//Sequential logic for present state
always_ff@(posedge clk)
begin
	if(!rst)
		present_state <= IDLE;
	else
		present_state <= next_state;
end

//Combinational logic for next state and output
always@(present_state,in)
begin
	case(present_state)
		IDLE: begin
			if(in==0) next_state = S1;
			else next_state = IDLE;
		end
		S1: begin
			if(in==1) next_state = S2;
			else next_state = S1;
		end
		S2: begin
			if(in==0) next_state = S3;
			else next_state = IDLE;
		end
		S3: begin
			if(in==1) next_state = S4;
			else next_state = S1;
		end
		S4: begin
			if(in==1) next_state = S5;
			else next_state = S3;
		end
		S5: begin
			if(in==0) next_state = S1;
			else next_state = IDLE;
		end
		default: next_state = IDLE;
	endcase
end

always@(present_state)
begin
	case(present_state)
		S5: out = 1;
		default: out = 0;
	endcase
end

endmodule: seq_det_moore
 

