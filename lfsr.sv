//RTL Model for Linear Feedback Shift Register
module lfsr
#(parameter N = 4) // Number of bits for LFSR
(
  input logic clk, reset, load_seed,
  input logic[N-1:0] seed_data,
  output logic lfsr_done,
  output logic[N-1:0] lfsr_data
);

//student to add implementation for LFSR code 
logic[N-1:0] temp;
logic a;

always @(posedge clk or negedge reset)
begin
	if(reset == 0)
		lfsr_data <= 0;
	else if(load_seed == 1)
		lfsr_data <= seed_data;
	else
		lfsr_data <= temp;
		
end

always_comb
begin
	temp = lfsr_data;
	case(N)
		2 :	a = temp[N-1] ^ temp[N-2];
		3 :	a = temp[N-1] ^ temp[N-2];
		4 :	a = temp[N-1] ^ temp[N-2];
		5 :	a = temp[N-1] ^ temp[N-3];
		6 :	a = temp[N-1] ^ temp[N-2];
		7 :	a = temp[N-1] ^ temp[N-2];
		8 :	a = temp[N-1] ^ temp[N-3] ^ temp[N-4] ^ temp[N-5];
	endcase	
	temp = temp << 1;
	temp[0] = a;
	if(lfsr_data == seed_data)
		lfsr_done = 1;
	else
		lfsr_done = 0;
end
 
endmodule: lfsr