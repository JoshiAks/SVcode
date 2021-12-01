// Mealy Sequence Detector for 01011
module seq_det_mealy(
  input logic clk,
  input logic rst,
  input logic in,  
  output logic out
); 
 
// Students to add code for Mealy Sequence Detector

//Parameters to define FSM state codings
localparam[4:0] IDLE=5'b00001,
					S1=5'b00010,
					S2=5'b00100,
					S3=5'b01000,
					S4=5'b10000;
					
//Current state and next state variables
logic[4:0] present_state, next_state;

//Sequential Logic for present state
always_ff@(posedge clk)
begin
	if(!rst)
		present_state <= IDLE;
	else
		present_state <= next_state;
end

//Combinational logic for next state and output
always@(present_state, in)
begin
	case(present_state)
		IDLE: begin
			if(in==0) begin
				next_state = S1;
				out = 0;
			end
			else begin
				next_state = IDLE;
				out = 0;
			end
		end
		S1: begin
			if(in==1) begin
				next_state = S2;
				out = 0;
			end
			else begin
				next_state = S1;
				out = 0;
			end
		end
		S2: begin
			if(in==0) begin
				next_state = S3;
				out = 0;
			end
			else begin
				next_state = IDLE;
				out = 0;
			end
		end
		S3: begin
			if(in==1) begin
				next_state = S4;
				out = 0;
			end
			else begin
				next_state = S1;
				out = 0;
			end
		end
		S4: begin
			if(in==1) begin
				next_state = IDLE;
				out = 1;
			end
			else begin
				next_state = S3;
				out = 0;
			end
		end
		default: begin
			next_state = IDLE;
			out = 0;
		end
	endcase
end

endmodule: seq_det_mealy
 

