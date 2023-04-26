/*

Module for I2S input selection. 
After every change we are waiting ca. 1s to allow the next change.

Author: drhl
Year: 2023

*/

module input_selectpr(
	inout in_clk,		// system clock, 50 MHz
	input in_bck_1,	// I2S SCK/BCK input 1
	input in_le_1,		// I2S LE input 1
	input in_data_1,	// I2S DATA input 1
	input in_bck_2,	// I2S SCK/BCK input 2
	input in_le_2,		// I2S LE input 2
	input in_data_2,	// I2S DATA input 2
	input in_button,	// push button input
	output out_bck,	// I2S SCK/BCK output
	output out_le,		// I2S LE output
	output out_data,	// I2S DATA output
	output out_fixed_1,	// output with high state - helper for push button
	output out_fixed_0	// output wit low state - helper for push button
);

reg [1:0] 	selected_input; // flag indicating which input is selected
reg [1:0] 	counter_enable; // flag asserted when counter is active - right after input selection change
reg [28:0]  counter;			 // counter to hold next input change for ca. 1s

initial begin
	selected_input <= 0;
	counter_enable <= 0;
	counter <= 0;
end

always @(posedge in_clk) begin
	// in_clk - 50MHz
	if(counter_enable == 1 && counter <= 50000000) begin
		counter <= counter + 1;
	end else if(counter_enable == 0) begin
		counter <= 0;
	end
end

always @(posedge in_button) begin
	// push button pressed and input change is allowed
	if(in_button == 1 && counter_enable == 0) begin
	   // change input
		if(selected_input == 0) begin
			selected_input <= 1;
		end else begin
			selected_input <= 0;
		end
		// lock next input change for ca. 1s
		counter_enable <= 1;
	end else begin
		if(counter >= 50000000) begin
			// unlock next input change
			counter_enable <= 0;
		end
	end
end

assign out_bck = (selected_input == 0 ? in_bck_1 : in_bck_2);
assign out_le = (selected_input == 0 ? in_le_1 : in_le_2);
assign out_data = (selected_input == 0 ? in_data_1 : in_data_2);

assign out_fixed_1 = 1;
assign out_fixed_0 = 0;

endmodule