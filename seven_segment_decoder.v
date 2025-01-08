module seven_segment_decoder(BIN, SSD);
	input [3:0] BIN;
	output reg [6:0] SSD;

	always @(*) begin
		case (BIN)
		0 :SSD=7'b1000000;
		1 :SSD=7'b1111001;
		2 :SSD=7'b0100100;
		3 :SSD=7'b0110000;
		4 :SSD=7'b0011001;
		5 :SSD=7'b0010010;
		6 :SSD=7'b0000010;
		7 :SSD=7'b1111000;
		8 :SSD=7'b0000000;
		9 :SSD=7'b0011000;
		endcase
	end
endmodule