module counter_split(
    input [4:0] counter,     // 5-bit counter input (0-31)
    output reg [3:0] tens,   // tens digit (0-3)
    output reg [3:0] ones    // ones digit (0-9)
);

    always @(*) begin
        tens = counter / 10;  // Integer division for tens
        ones = counter % 10;  // Modulo for ones
    end

endmodule