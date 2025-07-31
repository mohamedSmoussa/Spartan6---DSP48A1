vlib work
vlog DSP48A1.v DSP48A1_Tb.v
vsim -voptargs=+acc work.DSP48A1_Tb
add wave *
run -all