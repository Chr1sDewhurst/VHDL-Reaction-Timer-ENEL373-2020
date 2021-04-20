----------------------------------------------------------------------------------
-- Company: UC ECE
-- Engineers: jfa84, gek22, cjd167
-- 
-- Create Date: 20.03.2020 10:55:34
-- Module Name: flasher_mux - Behavioral
-- Project Name: Reaction_timer
-- Description: This module flashes the display and activates the 8 
--              active low annodes.
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity flasher_multiplexer is
    port (A, B, C, D, E, F, G, H : in std_logic_vector (3 downto 0);
          annode : out std_logic_vector (7 downto 0);
          S : in std_logic_vector (2 downto 0);
          O : out std_logic_vector (3 downto 0));
end flasher_multiplexer;

architecture archi of flasher_multiplexer is
begin
    process (A, B, C, D, E, F, G, H, S)
    begin
      case S is
         when "000" => O <= A; annode <= "11111110";
         when "001" => O <= B; annode <= "11111101";
         when "010" => O <= C; annode <= "11111011";
         when "011" => O <= D; annode <= "11110111";
         when "100" => O <= E; annode <= "11101111";
         when "101" => O <= F; annode <= "11011111";
         when "110" => O <= G; annode <= "10111111";
         when "111" => O <= H; annode <= "01111111";
         
         when others => O <= A;
      end case;
    end process;
end archi;