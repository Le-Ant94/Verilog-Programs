module RAM (Enable, ReadWrite, Clock, DataIn, DataOut, Result, C, AT, BB, FinResult);

input Enable, ReadWrite, Clock;
input [15:0] DataIn;
input [255:0] Result;
input [255:0] C;
input [255:0] AT;
input [255:0] BB;
input [255:0] FinResult;
output [15:0] DataOut;

reg [15:0] DataOut;
reg [15:0] MemArray[0:255];

always @ (posedge Clock)
	
	if (Enable)
		begin

			if(ReadWrite) DataOut = MemArray[Result];
			else MemArray[Result] = DataIn;

			if (ReadWrite) DataOut = MemArray[C];
			else MemArray[C] = DataIn;

			if (ReadWrite) DataOut = MemArray[AT];
			else MemArray[AT] = DataIn;

			if (ReadWrite) DataOut = MemArray[BB];
			else MemArray[BB] = DataIn;

			if (ReadWrite) DataOut = MemArray[FinResult];
			else MemArray[FinResult] = DataIn;

		end
	else
		DataOut = 256'bz;
endmodule
