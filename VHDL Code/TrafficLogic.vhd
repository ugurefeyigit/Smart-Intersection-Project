library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TrafficLights is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        u2echo : in std_logic;
        u4echo : in std_logic;
        u2trigger : out std_logic;
        u4trigger : out std_logic;
        error_switch : in std_logic;
        carL2 : out std_logic;
        carL4 : out std_logic;
        
        L1, L2, L3, L4 : out STD_LOGIC_VECTOR(2 downto 0)
    );
end TrafficLights;

architecture Behavioral of TrafficLights is
    type State_Type is (ALL_RED_INIT,
                        RY1, GREEN1, YELLOW1, 
                        RY2, GREEN2, YELLOW2, 
                        RY3, GREEN3, YELLOW3, 
                        RY4, GREEN4, YELLOW4);
    signal state : State_Type := ALL_RED_INIT;
    signal count : INTEGER range 0 to 12; -- Maximum cycles for the longest phase
    signal clk_1hz : STD_LOGIC;
    signal DistanceL2, DistanceL4 : integer := 0;
    signal car_at_L2, car_at_L4 : boolean := false;
    constant CAR_DETECTION_THRESHOLD : integer := 1500000;  -- Equivalent to 15 cm        
    

begin

    Clock_Divider_inst : entity work.Clock_Divider
        port map (
            clk_in => clk,
            clk_out => clk_1hz
        );
    -- Trigger generator for L2
    TriggerGenL2 : entity work.TriggerGenerator
        port map (
            clk => clk,
            trigger_out => u2trigger
        );

    -- Trigger generator for L4
    TriggerGenL4 : entity work.TriggerGenerator
        port map (
            clk => clk,
            trigger_out => u4trigger
        );

    -- Distance measurement for L2
    EchoDistL2 : entity work.EchoDistanceMeasurement
        port map (
            clk => clk,
            echo_in => u2echo,
            distance_out => DistanceL2
        );

    -- Distance measurement for L4
    EchoDistL4 : entity work.EchoDistanceMeasurement
        port map (
            clk => clk,
            echo_in => u4echo,
            distance_out => DistanceL4
        );

    -- Car detection process
    CarDetectionProcess: process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                car_at_L2 <= false;
                car_at_L4 <= false;
            else
                -- Update car_at_L2 based on DistanceL2
                if DistanceL2 <= CAR_DETECTION_THRESHOLD then
                    car_at_L2 <= true;
                else
                    car_at_L2 <= false;
                end if;

                -- Update car_at_L4 based on DistanceL4
                if DistanceL4 <= CAR_DETECTION_THRESHOLD then
                    car_at_L4 <= true;
                else
                    car_at_L4 <= false;
                end if;
            end if;
        end if;
    end process CarDetectionProcess;

       process(clk_1hz, reset)
    begin
        if reset = '1' then
            state <= ALL_RED_INIT;
            count <= 0;
        elsif rising_edge(clk_1hz) then
            case state is
                when ALL_RED_INIT =>
                    if count < 2 then
                    state <= ALL_RED_INIT;
                    count <= count + 1; 
                    else
                    state <= RY1;
                    count <= 0;
                    end if;
                    
                when RY1 =>
                    if count < 2 then
                    state <= RY1;
                    count <= count + 1; 
                    else
                    state <= GREEN1;
                    count <= 0;
                    end if;
                    
                when GREEN1 =>
                    if count < 12 then
                    state <= GREEN1;
                    count <= count + 1; 
                    else
                    state <= YELLOW1;
                    count <= 0;
                    end if;
                    
                when YELLOW1 =>
                    if count < 2 then
                    state <= YELLOW1;
                    count <= count + 1; 
                    else
                    state <= RY2;
                    count <= 0;
                    end if;                    
                when RY2 =>
                    if count < 2 then
                    state <= RY2;
                    count <= count + 1; 
                    else
                    state <= GREEN2;
                    count <= 0;
                    end if;
                    
                when GREEN2 =>
                    if car_at_L2 and count < 8 then
                    state <= GREEN2;
                    count <= count + 1;
                    elsif not car_at_L2 and count < 4 then
                    state <= GREEN2;
                    count <= count + 1;                     
                    else
                    state <= YELLOW2;
                    count <= 0;
                    end if;
                 when YELLOW2 =>
                    if count < 2 then
                    state <= YELLOW2;
                    count <= count + 1; 
                    else
                    state <= RY3;
                    count <= 0;
                    end if;
                    
                when RY3 =>
                    if count < 2 then
                    state <= RY3;
                    count <= count + 1; 
                    else
                    state <= GREEN3;
                    count <= 0;
                    end if;     
                when GREEN3 =>
                    if count < 12 then
                    state <= GREEN3;
                    count <= count + 1; 
                    else
                    state <= YELLOW3;
                    count <= 0;
                    end if;
                 when YELLOW3 =>
                    if count < 2 then
                    state <= YELLOW3;
                    count <= count + 1; 
                    else
                    state <= RY4;
                    count <= 0;
                    end if;
                    
                when RY4 =>
                    if count < 2 then
                    state <= RY4;
                    count <= count + 1; 
                    else
                    state <= GREEN4;
                    count <= 0;
                    end if;
                when GREEN4 =>
                    if car_at_L4 and count < 8 then
                    state <= GREEN4;
                    count <= count + 1;
                    elsif not car_at_L4 and count < 4 then
                    state <= GREEN4;
                    count <= count + 1;  
                    else
                    state <= YELLOW4;
                    count <= 0;
                    end if;
                 when YELLOW4 =>
                    if count < 2 then
                    state <= YELLOW4;
                    count <= count + 1; 
                    else
                    state <= RY1;
                    count <= 0;
                    end if;                  
        end case;                                                                    
        end if;
    end process;


    -- LED Control Logic
    process(state)
    begin

        -- Control each LED based on the current state
        case state is
            when ALL_RED_INIT =>
                L1 <= "100";
                L2 <= "100";
                L3 <= "100";
                L4 <= "100";
            when RY1 =>
                L1 <= "110";
                L2 <= "100";
                L3 <= "100";
                L4 <= "100";
            when YELLOW1 =>
                L1 <= "010";
                L2 <= "100";
                L3 <= "100";
                L4 <= "100";    
            when GREEN1 =>
                L1 <= "001";
                L2 <= "100";
                L3 <= "100";
                L4 <= "100";
            when RY2 =>
                L1 <= "100";
                L2 <= "110";
                L3 <= "100";
                L4 <= "100";
            when YELLOW2 =>
                L1 <= "100";
                L2 <= "010";
                L3 <= "100";
                L4 <= "100";                   
            when GREEN2 =>
                L1 <= "100";
                L2 <= "001";
                L3 <= "100";
                L4 <= "100";
            when RY3 =>
                L1 <= "100";
                L2 <= "100";
                L3 <= "110";
                L4 <= "100";
            when YELLOW3 =>
                L1 <= "100";
                L2 <= "100";
                L3 <= "010";
                L4 <= "100";                 
            when GREEN3 =>
                L1 <= "100";
                L2 <= "100";
                L3 <= "001";
                L4 <= "100";
            when RY4 =>
                L1 <= "100";
                L2 <= "100";
                L3 <= "100";
                L4 <= "110";
            when YELLOW4 =>
                L1 <= "100";
                L2 <= "100";
                L3 <= "100";
                L4 <= "010";  
            when GREEN4 =>
                L1 <= "100";
                L2 <= "100";
                L3 <= "100";
                L4 <= "001";
        end case;
        
    end process;
    
process(car_at_L2, car_at_L4)
    begin
          if car_at_L2 then
            carL2 <= '1';
          else
            carL2 <= '0';
          end if;
          if car_at_L4 then
            carL4 <= '1';
          else
            carL4 <= '0';
          end if;
 end process;

end Behavioral;
