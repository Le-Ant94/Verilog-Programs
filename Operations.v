//Module for matrix addition, subtraction, scaling, and multiplication
//Where A, B, C, and Result are 4 by 4 matrices
module Mat_Ops (A, B, Result, C, AT, BB, FinResult);

	//input and output ports
	//The size is 16 signed bits which is 4*4=16 elements, each of which is 16 bits deep
	input signed [255:0] A;
	input signed [255:0] B;
	input choice;
	output signed [255:0] Result;
	output signed [255:0] C;
	output signed [255:0] AT;
	output signed [255:0] BB;
	output signed [255:0] FinResult;

	//internal variables
	reg signed [255:0] Result;
	reg signed [255:0] C;
	reg signed [255:0] AT;
	reg signed [255:0] BB;
	reg signed [255:0] FinResult;
	reg signed [15:0] A1 [0:3][0:3];
	reg signed [15:0] B1 [0:3][0:3];
	reg signed [15:0] Result1 [0:3][0:3];
	reg signed [15:0] C1 [0:3][0:3];
	reg signed [15:0] AT1 [0:3][0:3];
	reg signed [15:0] BB1 [0:3][0:3];
	reg signed [15:0] FinResult1 [0:3][0:3];
	integer i, j, k;

	always @ (A or B)
	begin

	//Initialize the matrices & convert 1D to 3D arrays (since Verilog does not allow multi-dimensional arrays as input or ouput ports)
		{A1 [0][0], A1 [0][1], A1 [0][2], A1 [0][3],
		 A1 [1][0], A1 [1][1], A1 [1][2], A1 [1][3],
		 A1 [2][0], A1 [2][1], A1 [2][2], A1 [2][3],
		 A1 [3][0], A1 [3][1], A1 [3][2], A1 [3][3]} = A;

		{B1 [0][0], B1 [0][1], B1 [0][2], B1 [0][3],
		 B1 [1][0], B1 [1][1], B1 [1][2], B1 [1][3],
		 B1 [2][0], B1 [2][1], B1 [2][2], B1 [2][3],
		 B1 [3][0], B1 [3][1], B1 [3][2], B1 [3][3]} = B;

		i = 0;
		j = 0;
		k = 0;

		{Result1 [0][0], Result1 [0][1], Result1 [0][2], Result1 [0][3],
		 Result1 [1][0], Result1 [1][1], Result1 [1][2], Result1 [1][3],
		 Result1 [2][0], Result1 [2][1], Result1 [2][2], Result1 [2][3],
		 Result1 [3][0], Result1 [3][1], Result1 [3][2], Result1 [3][3]} = 256'd0; //initialize Result to zeros

		{C1 [0][0], C1 [0][1], C1 [0][2], C1 [0][3],
		 C1 [1][0], C1 [1][1], C1 [1][2], C1 [1][3],
		 C1 [2][0], C1 [2][1], C1 [2][2], C1 [2][3],
		 C1 [3][0], C1 [3][1], C1 [3][2], C1 [3][3]} = 256'd0; //initialize C to zeros

		{AT [0][0], AT [0][1], AT [0][2], AT [0][3],
		 AT [1][0], AT [1][1], AT [1][2], AT [1][3],
		 AT [2][0], AT [2][1], AT [2][2], AT [2][3],
		 AT [3][0], AT [3][1], AT [3][2], AT [3][3]} = 256'd0; //initialize AT to zeros

		{BB [0][0], BB [0][1], BB [0][2], BB [0][3],
		 BB [1][0], BB [1][1], BB [1][2], BB [1][3],
		 BB [2][0], BB [2][1], BB [2][2], BB [2][3],
		 BB [3][0], BB [3][1], BB [3][2], BB [3][3]} = 256'd0; //initialize BB to zeros

		{FinResult1 [0][0], FinResult1 [0][1], FinResult1 [0][2], FinResult1 [0][3],
		 FinResult1 [1][0], FinResult1 [1][1], FinResult1 [1][2], FinResult1 [1][3],
		 FinResult1 [2][0], FinResult1 [2][1], FinResult1 [2][2], FinResult1 [2][3],
		 FinResult1 [3][0], FinResult1 [3][1], FinResult1 [3][2], FinResult1 [3][3]} = 256'd0; //initialize to zeros


	case (choice)

	3'b000: //Matrix addition: A + B
	for (i = 0; i < 4; i = i + 1)
	begin
		for (j = 0; j < 4; j = j + 1)
		begin
			Result1 [i][j] = Result1 [i][j] + A1 [i][j] + B1 [i][j];
		end
	end

	//final output assignment: 3D array to 1D array conversion
	Result == {Result1 [0][0], Result1 [0][1], Result1 [0][2], Result1 [0][3],
		   Result1 [1][0], Result1 [1][1], Result1 [1][2], Result1 [1][3],
		   Result1 [2][0], Result1 [2][1], Result1 [2][2], Result1 [2][3],
		   Result1 [3][0], Result1 [3][1], Result1 [3][2], Result1 [3][3]};
	
	3'b001: //Matrix subtraction: Result - B
	for (i = 0; i < 4; i = i + 1)
	begin
		for (j=0; j<4; j=j+1)
		begin
			C1 [i][j] = C1 [i][j] + (Result1 [i][j] - B1 [i][j]);
		end
	end

	//final output assignment: 3D array to 1D array conversion
	C = {C1 [0][0], C1 [0][1], C1 [0][2], C1 [0][3],
	     C1 [1][0], C1 [1][1], C1 [1][2], C1 [1][3],
	     C1 [2][0], C1 [2][1], C1 [2][2], C1 [2][3],
	     C1 [3][0], C1 [3][1], C1 [3][2], C1 [3][3]};

	3'b010: //Matrix transpose: AT
	for (i=0; i<4; i=i+1)
	begin
		for (j = 0; j < 4; j = j + 1)
		begin
			AT [i][j] = AT [i][j] + A [j][i];
		end
	end

	//final output assignment: 3D array to 1D array conversion
	AT = {AT [0][0], AT [0][1], AT [0][2], AT [0][3],
	      AT [1][0], AT [1][1], AT [1][2], AT [1][3],
	      AT [2][0], AT [2][1], AT [2][2], AT [2][3],
	      AT [3][0], AT [3][1], AT [3][2], AT [3][3]};

	3'b011: //Matrix scaling: 2*B
	for (i = 0; i < 4; i = i + 1)
	begin
		for (j = 0; j < 4; j = j + 1)
		begin
			BB1 [i][j] = BB1 [i][j] + B1 [2*i][2*j];
		end
	end

	//final output assignment: 3D array to 1D array conversion
	BB = {BB [0][0], BB [0][1], BB [0][2], BB [0][3],
	      BB [1][0], BB [1][1], BB [1][2], BB [1][3],
	      BB [2][0], BB [2][1], BB [2][2], BB [2][3],
	      BB [3][0], BB [3][1], BB [3][2], BB [3][3]};

	3'b100: //Matrix multiplication: AT * BB
	for (i = 0; i < 4; i = i + 1)
	begin
		for (j = 0; j < 4; j = j + 1)
		begin
			for (k = 0; k < 4; k = k + 1)
			begin
				FinResult [i][j] = FinResult1 [i][j] + (AT1 [i][k] * BB1 [k][j]);
			end
		end
	end

	//final output assignment: 3D array to 1D array conversion
	FinResult = {FinResult1 [0][0], FinResult1 [0][1], FinResult1 [0][2], FinResult1 [0][3],
		     FinResult1 [1][0], FinResult1 [1][1], FinResult1 [1][2], FinResult1 [1][3],
		     FinResult1 [2][0], FinResult1 [2][1], FinResult1 [2][2], FinResult1 [2][3],
		     FinResult1 [3][0], FinResult1 [3][1], FinResult1 [3][2], FinResult1 [3][3]};
	
	default: $display("Invalid choice");

	endcase

	end

endmodule
