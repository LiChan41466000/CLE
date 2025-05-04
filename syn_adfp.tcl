gui_start
read_file -format verilog {/home/UIS113/UIS113a01/icc2016cb/CLE_v4.v}
set cycle  10         ;#clock period defined by designer
create_clock -period $cycle [get_ports  clk]
set_dont_touch_network      [all_clocks]
set_fix_hold                [all_clocks]
set_clock_uncertainty  0.1  [all_clocks]
set_clock_latency      0.5  [all_clocks]
set_ideal_network           [get_ports clk]
#Don't touch the basic env setting as below
set_input_delay  1     -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay 1     -clock clk [all_outputs]
set_load         1     [all_outputs]
set_drive        1     [all_inputs]
set_max_fanout 6 [all_inputs]
compile -exact_map
write -hierarchy -format verilog -output /home/UIS113/UIS113a01/icc2016cb/CLE_v4_syn_ADFP.v
write_sdf -version 1.0 -context verilog CLE_v4_syn_ADFP.sdf