LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


entity Clock_Divider is
port ( clk_in : in std_logic;
       clk_out : out std_logic
     );
end Clock_Divider;

architecture Behavioral of Clock_Divider is

signal count : integer :=0;
signal b : std_logic :='0';
begin

 --clk generation.For 100 MHz clock this generates 1 Hz clock.
process(clk_in) 
begin
if(rising_edge(clk_in)) then
count <=count+1;
if(count = 50000000-1) then
b <= not b;
count <=0;

end if;
end if;
clk_out<=b;
end process;
end;
