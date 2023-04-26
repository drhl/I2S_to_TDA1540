/*

Module for mute BCK output for 30 seconds.

Author: drhl
Year: 2023

*/

module mute_sck(
	input in_clk, // system clock, 50 MHz
	input in_sck, // I2S SCK/BCK input
	output out_sck_mute, // I2S SCK/BCK output with mute function 
	output reg out_mute_led  // status LED for muted state
); 

reg [28:0] counter;	// counts in_clk ticks
reg [7:0] seconds;	// number of elapsed seconds
reg [1:0] enable;	// BCK output enable flag

initial begin
	counter <= 0;
	seconds <= 0;
	out_mute_led <= 1;
	enable <= 0;
end

// assign input BCK to output BCK only when BCK output flag is asserted
assign out_sck_mute = enable == 1 ? in_sck : 0;

always @(posedge in_clk)
begin
   // wait ca. 30s
	if(seconds < 30)
		begin
			// in_clk - 50MHz
			if(counter >= 50000000) begin
				counter <= 0;
				seconds <= seconds + 1;
			end else begin
				counter <= counter + 1;
			end
		end
	else
		begin
			if(enable == 0) begin
				// turn off mute LED
				out_mute_led <= 0;
				// enable BCK/SCK output
				enable <= 1;
			end
		end
end

endmodule
