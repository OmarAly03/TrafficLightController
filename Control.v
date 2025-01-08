module Control(
    input clk,
	 input reset,
    input NorthSensor,
    input EastSensor,
    output reg NorthRed,
    output reg NorthYellow,
    output reg NorthGreen,
    output reg EastRed,
    output reg EastYellow,
    output reg EastGreen,
    output reg [2:0] state,
    output reg [4:0] counter
);

    wire [4:0] counter_next;
    reg turn,    // North --> 0, East --> 1
        current; // North --> 0, East --> 1

    parameter S0_North_G_East_R = 3'd0;
    parameter S1_Check = 3'd1;
    parameter S2_East_Y_North_Y = 3'd2;
    parameter S3_East_G_North_R = 3'd3;
    parameter S4_North_Y_East_Y = 3'd4;

    assign counter_next = counter + 1;

    initial 
        begin
            state = S0_North_G_East_R;
            turn = 0;
            current = 0;
            counter = 0;
            NorthRed = 1;
            NorthYellow = 1;
            NorthGreen = 1;
            EastRed = 1;
            EastYellow = 1;
            EastGreen = 1;
        end
    
    always @(posedge clk)
        begin
           case(state)
            S2_East_Y_North_Y:
                begin
                    if(counter == 5)
                        begin
                            counter <= 0;
                            state <= S3_East_G_North_R;
                        end
                    else
                        begin
                            counter <= counter_next;
                            state <= S2_East_Y_North_Y; // keep state
                        end
                end
            S3_East_G_North_R:
                begin
                    if(counter == 30)
                        begin
                            counter <= 0;
                            state <= S1_Check;
                        end
                    else
                        begin
                            counter <= counter_next;
                            state <= S3_East_G_North_R; // keep state
                        end
                end
            S4_North_Y_East_Y:
                begin
                    if(counter == 5)
                        begin
                            counter <= 0;
                            state <= S0_North_G_East_R;
                        end
                    else
                        begin
                            counter <= counter_next;
                            state <= S4_North_Y_East_Y; // keep state
                        end
                end
            S0_North_G_East_R:
                begin
                    if(counter == 30)
                        begin
                            counter <= 0;
                            state <= S1_Check;
                        end
                    else
                        begin
                            counter <= counter_next;
                            state <= S0_North_G_East_R; // keep state
                        end
                end
            S1_Check:
                begin
                    if((NorthSensor == 0) & (EastSensor == 0))
                        state <= S1_Check;
                    else if((NorthSensor == 1) & (EastSensor == 0))
                        if(current == 0)
                            state <= S1_Check;
                        else
                            begin
                                current <= 1;
                                state <= S4_North_Y_East_Y;
                            end
                    else if((NorthSensor == 0) & (EastSensor == 1))
                        if(current == 1)
                            state <= S1_Check;
                        else
                            begin
                                current <= 0;
                                state <= S2_East_Y_North_Y;
                            end
                    else if((NorthSensor == 1) & (EastSensor == 1))
                        if(turn == 0)
                            begin
                                turn <= 1;
                                state <= S4_North_Y_East_Y;
                            end
                        else
                            begin 
                                turn <= 0;
                                state <= S2_East_Y_North_Y;
                            end
                end
            default: state <= S0_North_G_East_R;
           endcase
        end
    
    always @(*)
        begin
            case(state)
                S0_North_G_East_R:
                    begin
                        NorthRed = 1;
                        NorthYellow = 1;
                        NorthGreen = 0;
                        EastRed = 0;
                        EastYellow = 1;
                        EastGreen = 1;
                    end 
                S2_East_Y_North_Y:
                    begin
                        NorthRed = 1;
                        NorthYellow = 0;
                        NorthGreen = 1;
                        EastRed = 1;
                        EastYellow = 0;
                        EastGreen = 1;
                    end 
                S4_North_Y_East_Y:
                    begin
                        NorthRed = 1;
                        NorthYellow = 0;
                        NorthGreen = 1;
                        EastRed = 1;
                        EastYellow = 0;
                        EastGreen = 1;
                    end
                S3_East_G_North_R:
                    begin
                        NorthRed = 0;
                        NorthYellow = 1;
                        NorthGreen = 1;
                        EastRed = 1;
                        EastYellow = 1;
                        EastGreen = 0;
                    end
            endcase
        end
endmodule