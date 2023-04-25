module input_selectpr(
	inout in_clk,
	input in_bck_1,
	input in_le_1,
	input in_data_1,
	input in_bck_2,
	input in_le_2,
	input in_data_2,
	input in_button,
	output out_bck,
	output out_le,
	output out_data,
	output out_fixed_1,
	output out_fixed_0
	);

reg [1:0] 	selected_input;
reg [1:0] 	counter_enable;
reg [28:0]  counter;

initial begin
	selected_input <= 0;
	counter_enable <= 0;
	counter <= 0;
end

always @(posedge in_clk) begin
	if(counter_enable == 1 && counter <= 50000000) begin
		counter <= counter + 1;
	end else if(counter_enable == 0) begin
		counter <= 0;
	end
end

always @(posedge in_button) begin
	if(in_button == 1 && counter_enable == 0) begin
		if(selected_input == 0) begin
			selected_input <= 1;
		end else begin
			selected_input <= 0;
		end
		counter_enable <= 1;
	end else begin
		if(counter >= 50000000) begin
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