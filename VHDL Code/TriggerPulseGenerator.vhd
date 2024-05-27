library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TriggerGenerator is
    Port (
        clk : in STD_LOGIC; -- 100 MHz internal clock
        trigger_out : out STD_LOGIC
    );
end TriggerGenerator;

architecture Behavioral of TriggerGenerator is
    signal count : integer := 0;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if count = 0 then
                trigger_out <= '1';
            elsif count = 1000 then  -- 10 microseconds at 100 MHz
                trigger_out <= '0';
            end if;

            if count = 6000000 then  -- 60 milliseconds at 100 MHz
                count <= 0;
            else
                count <= count + 1;
            end if;
        end if;
    end process;
end Behavioral;
