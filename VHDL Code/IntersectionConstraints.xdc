set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# Reset pin
set_property PACKAGE_PIN U18 [get_ports {reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]

# Green LEDs
set_property PACKAGE_PIN J3 [get_ports {L1[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {L1[0]}]
set_property PACKAGE_PIN L3 [get_ports {L2[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {L2[0]}]
set_property PACKAGE_PIN M2 [get_ports {L3[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {L3[0]}]
set_property PACKAGE_PIN N2 [get_ports {L4[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {L4[0]}]

# Red LEDs
set_property PACKAGE_PIN J1 [get_ports {L1[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {L1[2]}]
set_property PACKAGE_PIN L2 [get_ports {L2[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {L2[2]}]
set_property PACKAGE_PIN J2 [get_ports {L3[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {L3[2]}]
set_property PACKAGE_PIN G2 [get_ports {L4[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {L4[2]}]

# Yellow LEDs
set_property PACKAGE_PIN K3 [get_ports {L1[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {L1[1]}]
set_property PACKAGE_PIN M3 [get_ports {L2[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {L2[1]}]
set_property PACKAGE_PIN M1 [get_ports {L3[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {L3[1]}]
set_property PACKAGE_PIN N1 [get_ports {L4[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {L4[1]}]

# Triggers
set_property PACKAGE_PIN A14 [get_ports u2trigger]
set_property IOSTANDARD LVCMOS33 [get_ports u2trigger]

set_property PACKAGE_PIN A16 [get_ports u4trigger]
set_property IOSTANDARD LVCMOS33 [get_ports u4trigger]

# Echoes
set_property PACKAGE_PIN A15 [get_ports u2echo]
set_property IOSTANDARD LVCMOS33 [get_ports u2echo]

set_property PACKAGE_PIN A17 [get_ports u4echo]
set_property IOSTANDARD LVCMOS33 [get_ports u4echo]

#Distance LEDs
set_property PACKAGE_PIN L1 [get_ports carL2]
set_property IOSTANDARD LVCMOS33 [get_ports carL2]

set_property PACKAGE_PIN P1 [get_ports carL4]
set_property IOSTANDARD LVCMOS33 [get_ports carL4]

#Error switch
set_property PACKAGE_PIN U17 [get_ports error_switch]
set_property IOSTANDARD LVCMOS33 [get_ports error_switch]




# Reset
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]


