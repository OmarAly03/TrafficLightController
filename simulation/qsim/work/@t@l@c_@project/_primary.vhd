library verilog;
use verilog.vl_types.all;
entity TLC_Project is
    port(
        CLOCK_50        : in     vl_logic;
        reset_PB0       : in     vl_logic;
        NorthSensor     : in     vl_logic;
        EastSensor      : in     vl_logic;
        NorthRed        : out    vl_logic;
        NorthYellow     : out    vl_logic;
        NorthGreen      : out    vl_logic;
        EastRed         : out    vl_logic;
        EastYellow      : out    vl_logic;
        EastGreen       : out    vl_logic;
        HEX             : out    vl_logic_vector(6 downto 0);
        EN1             : out    vl_logic;
        EN2             : out    vl_logic;
        EN3             : out    vl_logic;
        EN4             : out    vl_logic
    );
end TLC_Project;
