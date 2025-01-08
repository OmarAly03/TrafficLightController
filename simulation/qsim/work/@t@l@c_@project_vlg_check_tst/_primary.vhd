library verilog;
use verilog.vl_types.all;
entity TLC_Project_vlg_check_tst is
    port(
        EN1             : in     vl_logic;
        EN2             : in     vl_logic;
        EN3             : in     vl_logic;
        EN4             : in     vl_logic;
        EastGreen       : in     vl_logic;
        EastRed         : in     vl_logic;
        EastYellow      : in     vl_logic;
        HEX             : in     vl_logic_vector(6 downto 0);
        NorthGreen      : in     vl_logic;
        NorthRed        : in     vl_logic;
        NorthYellow     : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end TLC_Project_vlg_check_tst;
