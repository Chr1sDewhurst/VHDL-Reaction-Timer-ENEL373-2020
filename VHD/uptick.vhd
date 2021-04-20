----------------------------------------------------------------------------------
-- Company: UC ECE
-- Engineers: jfa84, gek22, cjd167
-- 
-- Create Date: 20.03.2020 10:55:34
-- Module Name: uptick - Behavourial 
-- Project Name: Reaction_timer
-- Description: When this module is enabled, it counts from zero to nine in binary then loops 
--              back to zero - acting as the BCD uptick. It increments on the rising edge of 
--              the input clock signal. The BCD upticks have an extra output, carry out, 
--              which goes high when the counter loops back to zero. The BCD upticks can 
--              also be reset, which puts the counter back to zero without setting carry out to high. 
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

entity uptick is
    Port ( clk_in : in STD_LOGIC;
           EN : in STD_LOGIC;
           R : in STD_LOGIC;
           int_out : out STD_LOGIC_VECTOR (3 downto 0);
           carry_out: out std_logic);
end uptick;

architecture Behavioral of uptick is
signal temp: std_logic_vector(0 to 3);
begin process(clk_in, R)
    begin
    carry_out<='0';
    if R = '1' then
        temp <= "0000";
    elsif(rising_edge(clk_in) AND EN = '1') then
        if temp="1001" then
            temp<="0000";
            carry_out<='1';
        else
            temp <= temp + 1;
        end if;
    end if;
end process;
int_out <= temp;
end Behavioral;
