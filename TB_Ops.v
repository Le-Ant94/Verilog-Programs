module TB_Ops;

//Inputs
reg [255:0] A;
reg [255:0] B;

//Outputs
wire [255:0] Result;
wire [255:0] C;
wire [255:0] AT;
wire [255:0] BB;
wire [255:0] FinResult;

//Instantiate the ALU (Mat_Ops)

Mat_Ops ALU (
	.A (A),
	.B (B),
	.Result (Result),
	.C (C),
	.AT (AT),
	.BB (BB),
	.FinResult (FinResult1)
	);

	initial begin // Apply inputs

		A = 0; B = 0; #100;

		A = {16'd2, 16'd2, 16'd2, 16'd2,
		     16'd2, 16'd2, 16'd2, 16'd2,
		     16'd2, 16'd2, 16'd2, 16'd2,
		     16'd2, 16'd2, 16'd2, 16'd2};

		B = {16'd4, 16'd4, 16'd4, 16'd4,
		     16'd4, 16'd4, 16'd4, 16'd4,
		     16'd4, 16'd4, 16'd4, 16'd4,
		     16'd4, 16'd4, 16'd4, 16'd4};
	end

endmodule
