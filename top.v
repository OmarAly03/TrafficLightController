//`include "bin2bcd.v"
//`include "Control.v"
//`include "counter_divider.v"
//`include "seven_segment_decoder.v"

module TLC_Project(
    input CLOCK_50,
	input reset_PB0,
    input NorthSensor,
    input EastSensor,
    output NorthRed,
    output NorthYellow,
    output NorthGreen,
    output EastRed,
    output EastYellow,
    output EastGreen,
    output reg [6:0] HEX,
    output reg EN1,
    output reg EN2,
    output reg EN3,
    output reg EN4
);
    wire clk_d;
    wire clk_1hz;
    wire [2:0] state;
    wire [4:0] counter;
    wire [3:0] north_tens, north_ones;
    wire [3:0] east_tens, east_ones;
    wire [6:0] HEX0, HEX1, HEX2, HEX3;
    reg [1:0] count;

    // Clock divider instantiation
    counter_divider div(.c_clr(reset_PB0), .c_clk(CLOCK_50), .clk_d(clk_d));
	 
	clock_divider_1hz (
		.clk_in(CLOCK_50),     // 50 MHz input clock
		.reset(reset_PB0),      // Asynchronous reset
		.clk_out(clk_1hz)     // 1 Hz output clock
	);

    // Main controller instantiation
    Control controller(
        .clk(clk_1hz),
        .NorthSensor(NorthSensor),
        .EastSensor(EastSensor),
        .NorthRed(NorthRed),
        .NorthYellow(NorthYellow),
        .NorthGreen(NorthGreen),
        .EastRed(EastRed),
        .EastYellow(EastYellow),
        .EastGreen(EastGreen),
        .state(state),
        .counter(counter)
    );

    // // Binary to BCD converter for counter
    // // Binary to BCD converters for both directions
    // bin2bcd north_converter(
    //     .binary(counter),
    //     .tens(north_tens),
    //     .ones(north_ones)
    // );

    // bin2bcd east_converter(
    //     .binary(counter),
    //     .tens(east_tens),
    //     .ones(east_ones)
    // );

    // // Seven segment decoders


    counter_split north_split(
        .counter(counter),
        .tens(north_tens),
        .ones(north_ones)
    );

    seven_segment_decoder ssd0(.BIN(north_ones), .SSD(HEX0));
    seven_segment_decoder ssd1(.BIN(north_tens), .SSD(HEX1));
    seven_segment_decoder ssd2(.BIN(north_ones), .SSD(HEX2));
    seven_segment_decoder ssd3(.BIN(north_tens), .SSD(HEX3));

    // Display multiplexing logic (your existing code)
    always @(posedge clk_d) begin
        case (count)
            2'b00: begin
                EN1 <= 0;
                EN2 <= 0;
                EN3 <= 0;
                EN4 <= 1;
                HEX <= HEX0;
                count <= 2'b01;
            end
            2'b01: begin
                EN1 <= 0;
                EN2 <= 0;
                EN3 <= 1;
                EN4 <= 0;
                HEX <= HEX1;
                count <= 2'b10;
            end
            2'b10: begin
                EN1 <= 0;
                EN2 <= 1;
                EN3 <= 0;
                EN4 <= 0;
                HEX <= HEX2;
                count <= 2'b11;
            end
            2'b11: begin
                EN1 <= 1;
                EN2 <= 0;
                EN3 <= 0;
                EN4 <= 0;
                HEX <= HEX3;
                count <= 2'b00;
            end
            default: count <= 2'b00;
        endcase
    end
endmodule