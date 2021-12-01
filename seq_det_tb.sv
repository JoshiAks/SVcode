`timescale 1ns/1ns
//Sequence Detector Testbench 

module seq_det_tb;
 parameter NUM_BITS = 6;
 
 logic clk, reset;
 logic out_moore,out_mealy,load_seed,lsfr_done;
 logic[NUM_BITS-1:0] seed, data;
 
 
 
   lfsr #(.N(NUM_BITS)) lfsr1(
   .clk(clk),
   .reset(reset),
   .load_seed(load_seed),
   .seed_data(seed),
   .lfsr_data(data),
   .lfsr_done(lfsr_done)
  );

	seq_det_moore moore(
	.clk(clk),
	.rst(reset),
	.in(data[0]),
	.out(out_moore)
	);
	seq_det_mealy mealy(
	.clk(clk),
	.rst(reset),
	.in(data[0]),
	.out(out_mealy)
	);
	
 
 
 
initial begin
// Initialize Inputs
reset = 0;
// Wait 10 ns for global reset to finish and start counter
#10;
reset = 1;
load_seed = 1;
seed = 6'b000111;
#10;
load_seed = 0;

$display("Starting");
#5000ns;
$display("Completed");
// terminate simulation
$finish();
end

initial begin	
	clk =0;
	forever #5 clk=!clk;
end	

always_comb begin
	if(data[4:0] == 5'b01011) begin
		$display(" time=%0t, data=%6b",$time, data);
	end
end

wire mealy_right, moore_right;
assign mealy_right = (data[4:0] == 5'b01011) ? out_mealy : 1;
assign moore_right = (data[5:1] == 5'b01011) ? out_moore : 1;

always_ff @(posedge clk) begin
	if(!mealy_right) $display("mealy failed");
	if(!moore_right) $display("moore failed");
end

/*always_comb begin	
	if(data[4:0] == 5'b01011) begin
		$display(" time=%0t,  mealy_out=%b   data=%6b",$time, out_mealy,  data);
		if (!out_mealy) $display("mealy failed");
	end
	if(data[5:1] == 5'b01011) begin
		$display(" time=%0t,  moore_out=%b  data=%6b",$time,  out_moore, data);
		if (!out_moore) $display("moore failed");
	end
end	*/

endmodule: seq_det_tb