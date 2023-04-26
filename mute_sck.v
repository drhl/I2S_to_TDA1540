/*

Module for mute BCK output for 30 seconds.

Author: drhl
Year: 2023

*/

module mute_sck(
	input in_clk, // system clock, 50 MHz
	input in_sck, // I2S SCK/BCK input
	input in_le,  // I2S LE input
	output reg out_sck_mute, // I2S SCK/BCK output with mute function 
	output reg out_mute_led  // status LED for muted state
); 

reg [28:0] counter;	// counts in_clk ticks
reg [7:0] seconds;	// number of elapsed seconds
reg [1:0] enable;	// BCK output enable flag

initial begin
	counter <= 0;
	seconds <= 0;
	out_sck_mute <= 0;
	out_mute_led <= 1;
	enable <= 0;
end

always @(posedge in_clk)
begin
   // 50MHz
	if(enable == 1 && seconds < 30)
		begin
			if(counter == 50000000) 
				begin
					counter <= 0;
					seconds <= seconds + 1;
				end
			else
				counter <= counter + 1;
		end
	else
		begin
			if(out_mute_led == 1) 
			begin
				out_mute_led <= 0;
			end
			out_sck_mute <= in_sck;
		end
end


always @(posedge in_le)
begin
   // 50MHz
	if(seconds == 30)
		begin
			enable <= 1;
		end
end

endmodule
