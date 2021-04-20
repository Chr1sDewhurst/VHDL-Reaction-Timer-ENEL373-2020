----------------------------------------------------------------------------------
-- Company: UC ECE
-- Engineers: jfa84, gek22, cjd167
-- 
-- Create Date: 20.03.2020 10:55:34
-- Module Name: uptick_3bit - Behavioural
-- Project Name: Reaction_timer
-- Description: When this module is enabled, it counts from zero to eight in 
--              binary then loops back to zero. The count is incremented on the rising edge 
--              of the input clock signal.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uptick_3bit is
    Port ( clk_in : in STD_LOGIC;
           int_out : out STD_LOGIC_VECTOR (2 downto 0));
end uptick_3bit;

architecture Behavioral of uptick_3bit is
signal temp: std_logic_vector(2 downto 0);
begin process(clk_in)
    begin
    if(rising_edge(clk_in)) then
         temp <= temp + 1;
    end if;
end process;
int_out <= temp;
end Behavioral;
