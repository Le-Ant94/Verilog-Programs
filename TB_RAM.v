module TB_RAM;

reg Enable, ReadWrite, Clock;
reg [7:0] DataIn;
reg [7:0] Address;

wire [7:0] DataOut;

memory Test_Memory (DataOut, DataIn, Address, Enable, ReadWrite, Clock);

initial // Clock generator

	begin
	Clock = 0;
	forever #10 Clock = !Clock;
	end

initial // Test stimulus

	begin
	Enable = 0;
	#11 Enable = 1;
		Address = 6'h0; // write to address location 0
			DataIn = 8'h55;
			ReadWrite = 0;

	#20 Address = 6'h0; // read it back
		ReadWrite = 1;

	#5 Enable = 0;

end

initial
	$monitor($stime, DataOut, DataIn, Address, Enable, ReadWrite);

endmodule
