module clock_divider_1hz (
    input wire clk_in,     // 50 MHz input clock
    input wire reset,      // Asynchronous reset
    output reg clk_out     // 1 Hz output clock
);
    parameter DIV_FACTOR = 49_999_999; // Division factor
    reg [25:0] counter;               // 26-bit counter (enough to count up to 50 million)

    always @(posedge clk_in or negedge reset) begin
        if (~reset) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter == (DIV_FACTOR - 1)) begin
                counter <= 0;          // Reset counter
                clk_out <= ~clk_out;   // Toggle output clock
            end else begin
                counter <= counter + 1; // Increment counter
            end
        end
    end
endmodule