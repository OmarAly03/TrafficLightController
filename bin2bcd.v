module bin2bcd(
    input [4:0] binary,
    output reg [3:0] tens,
    output reg [3:0] ones
);
    integer i;
    reg [7:0] bcd;

    always @(binary) 
        begin
            bcd = 8'b0;
            bcd[4:0] = binary;

            for (i = 0; i <= 4; i = i + 1) 
                begin
                    if (bcd[7:4] >= 5)
                        bcd[7:4] = bcd[7:4] + 3;
                    
                    bcd = bcd << 1;
                end
            
            tens = bcd[7:4];
            ones = bcd[3:0];
        end
endmodule