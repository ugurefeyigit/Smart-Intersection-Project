library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity EchoDistanceMeasurement is
    Port (
        clk : in STD_LOGIC; -- 100 MHz internal clock
        echo_in : in STD_LOGIC;
        distance_out : out integer  -- distance in 10^-7 meters
    );
end EchoDistanceMeasurement;

architecture Behavioral of EchoDistanceMeasurement is
    signal microsecond : STD_LOGIC := '0';
    signal counter : integer := 0;
    signal echo_curr : STD_LOGIC := '0';
    signal echo_prev : STD_LOGIC := '0';
    signal microsec_counter : integer := 0;
begin
    -- Process to generate a microsecond pulse
    process(clk)
    variable count0 : integer := 0;  -- Adjust for 100 MHz clock
    begin
        if rising_edge(clk) then
            if count0 = 49 then  -- Create a 1 microsecond tick
                microsecond <= not microsecond;
                count0 := 0;
            else
                count0 := count0 + 1;            
            end if;
        end if;
    end process;

    -- Process to increment counter on every microsecond when echo is high
    process(microsecond)
    begin
        if rising_edge(microsecond) then
            echo_prev <= echo_curr;
            echo_curr <= echo_in;

            if echo_curr = '1' then
                counter <= counter + 1;
            end if;

            -- Falling edge detected on the ECHO signal
            if echo_prev = '1' and echo_curr = '0' then
                -- Calculate the distance based on the counter and the predefined scale factor
                distance_out <= counter * 1715; -- Scale factor to convert to distance
                counter <= 0; -- Reset the counter
            end if;
        end if;
    end process;
end Behavioral;
