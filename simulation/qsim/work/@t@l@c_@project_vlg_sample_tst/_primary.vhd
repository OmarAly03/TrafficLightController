library verilog;
use verilog.vl_types.all;
entity TLC_Project_vlg_sample_tst is
    port(
        CLOCK_50        : in     vl_logic;
        EastSensor      : in     vl_logic;
        NorthSensor     : in     vl_logic;
        reset_PB0       : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end TLC_Project_vlg_sample_tst;
