module counter_divider(c_clr, c_clk, clk_d);
	parameter N = 6;
	input c_clr;
	input c_clk;
	reg [N-1:0] q;
	output reg clk_d;

	always @ (posedge c_clk or negedge c_clr)
	begin
		if (c_clr == 0)
			q <= 0;
		else
			q <= q+1;
			clk_d <= q[N-1];
	end
endmodule