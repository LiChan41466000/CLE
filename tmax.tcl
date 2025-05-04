read_netlist /home/UIS113/UIS113a01/icc2016cb/CLE_dft_test.v
read_netlist /home/UIS113/UIS113a01/icc2016cb/N16ADFP_StdCell.v
run_build_model CLE
set_drc /home/UIS113/UIS113a01/icc2016cb/CLE_test.spf
run_drc
set_atpg -full_seq_time { 3 }
run_atpg -auto_compression -ndetects 1
run_atpg full_sequential_only
report_faults -all