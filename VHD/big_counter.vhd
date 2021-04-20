----------------------------------------------------------------------------------
-- Company: UC ECE
-- Engineers: jfa84, gek22, cjd167
-- 
-- Create Date: 13.03.2020 09:23:13
-- Design Name: Reaction Timer
-- Module Name: big_counter - Structural
-- Target Devices: Any
-- Description: The counter is a structural module, which cascades eight BCD uptick modules. 
--              The 1k Hz clock signal from the 1k Hz clock divider is connected to the first 
--              uptick module’s clock in, and the carry out of each module connects to the clock 
--              in of the following module. The counter outputs a BCD representation of the 
--              time in milliseconds that it has been enabled since the last reset.
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Uses code and concepts from ENCE373 Lab 
--                      code - 'four_bit_counter_with_clear'
-- 
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

entity big_counter is
    Port ( clk_in : in STD_LOGIC;
           EN : in STD_LOGIC;
           R : in STD_LOGIC;
           bcd_0 : out STD_LOGIC_VECTOR (3 downto 0);
           bcd_1 : out STD_LOGIC_VECTOR (3 downto 0);
           bcd_2 : out STD_LOGIC_VECTOR (3 downto 0);
           bcd_3 : out STD_LOGIC_VECTOR (3 downto 0);
           bcd_4 : out STD_LOGIC_VECTOR (3 downto 0);
           bcd_5 : out STD_LOGIC_VECTOR (3 downto 0);
           bcd_6 : out STD_LOGIC_VECTOR (3 downto 0);
           bcd_7 : out STD_LOGIC_VECTOR (3 downto 0));
end big_counter;

architecture Structural of big_counter is

signal temp_carry_out : std_logic_vector (7 downto 0);

component uptick
   Port (  clk_in : in STD_LOGIC;
           EN : in STD_LOGIC;
           R : in STD_LOGIC;
           int_out : out STD_LOGIC_VECTOR (3 downto 0);
           carry_out : out std_logic);
end component;

begin
    stage1: uptick port map(clk_in => clk_in, EN => EN, R => R, int_out => bcd_0, carry_out => temp_carry_out(0));
    stage2: uptick port map(clk_in => temp_carry_out(0), EN => EN, R => R, int_out => bcd_1, carry_out => temp_carry_out(1));
    stage3: uptick port map(clk_in => temp_carry_out(1), EN => EN, R => R, int_out => bcd_2, carry_out => temp_carry_out(2));
    stage4: uptick port map(clk_in => temp_carry_out(2), EN => EN, R => R, int_out => bcd_3, carry_out => temp_carry_out(3));
    stage5: uptick port map(clk_in => temp_carry_out(3), EN => EN, R => R, int_out => bcd_4, carry_out => temp_carry_out(4));
    stage6: uptick port map(clk_in => temp_carry_out(4), EN => EN, R => R, int_out => bcd_5, carry_out => temp_carry_out(5));
    stage7: uptick port map(clk_in => temp_carry_out(5), EN => EN, R => R, int_out => bcd_6, carry_out => temp_carry_out(6));
    stage8: uptick port map(clk_in => temp_carry_out(6), EN => EN, R => R, int_out => bcd_7, carry_out => temp_carry_out(7));


end Structural;
