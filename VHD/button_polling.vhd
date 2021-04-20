----------------------------------------------------------------------------------
-- Company: UC ECE
-- Engineer: jfa84
-- 
-- Create Date: 21.03.2020 14:48:47
-- Design Name: Reaction Timer 
-- Module Name: button_polling - Behavioral
-- Target Devices: Any
-- Tool Versions: 
-- Description: This module polls a button at 100 Hz.
--              The signal 'is_pushed' goes high if the button input is high
--              on a rising edge of the clock.
-- 
-- Revision:
-- Revision 0.01 - File Created
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

entity button_polling is
    Port ( button : in STD_LOGIC;
           CLK_IN : in STD_LOGIC;
           is_pushed : out STD_LOGIC);
end button_polling;

architecture Behavioral of button_polling is

begin process (CLK_IN)
begin
    if rising_edge(CLK_IN) then
        is_pushed <= button; --Button is pushed if 'button' input is high
    end if;
end process;
    



end Behavioral;
