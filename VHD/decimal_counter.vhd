----------------------------------------------------------------------------------
-- Company: UC ECE
-- Engineers: jfa84, gek22, cjd167
-- 
-- Create Date: 20.03.2020 10:55:34
-- Module Name: decimal_counter - Behavioral
-- Project Name: Reaction_timer
-- Description: This module uses a finite state machine to cycle through the
--              decimal count-down state. 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decimal_counter is
    Port ( CLK_IN : in STD_LOGIC;
           EN : in STD_LOGIC;
           RESET : in STD_LOGIC;
           FINISHED : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end decimal_counter;

architecture Behavioral of decimal_counter is
signal temp_AN: STD_LOGIC_VECTOR (7 downto 0) := "11111000";

begin process (CLK_IN, RESET)
begin
if temp_AN = "11111000" then
    FINISHED <= '0';
end if;

-- Button C press in the display time state triggers the reset of the 
-- count down, which here sets the three active low decimal points to be ON
if RESET = '1' then
    temp_AN <= "11111000";
    FINISHED <= '0';
    
-- Turn decimal points off on rising clock edge each second
elsif rising_edge(CLK_IN) AND EN = '1' then
    case  temp_AN is
    when "11111000" => temp_AN <= "11111100"; FINISHED <= '0';
    when "11111100" => temp_AN <= "11111110"; FINISHED <= '0';
    when others => temp_AN <= "11111111"; FINISHED <= '1';
    end case;
    
end if;
end process;

-- Annode value is set concurrently with the changes made
-- to temp_AN inside the FSM 
AN <= temp_AN;


end Behavioral;
