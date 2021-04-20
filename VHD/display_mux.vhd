----------------------------------------------------------------------------------
-- Company: UC ECE
-- Engineers: jfa84, gek22, cjd167
-- 
-- Create Date: 20.03.2020 10:55:34
-- Module Name: display_mux - Behavioral
-- Project Name: Reaction_timer
-- Description: This module multiplexes the display. Both the decimal count-down 
--              and timer state are connected to the two least significant bits of the select 
--              inputs of an eight input multiplexer, and the most significant select bit is set to 0. 
--              The output is connected to the anodes and cathodes of the display. The decimal countdown,
--              which is displayed only in state “00”, is connected to the 0th input. The counter, which is 
--              displayed in states “01” and “10”, is connected to the 1st and 2nd inputs (see FSM_Manager
--              for this state encoding). The remaining inputs are unused. 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity display_multiplexer is
    port (A, B, C, D, E, F, G, H : in std_logic_vector (7 downto 0);
          annodeA, annodeB, annodeC, annodeD, annodeE, annodeF, annodeG, annodeH  : in std_logic_vector (7 downto 0);
          S : in std_logic_vector (2 downto 0);
          O : out std_logic_vector (7 downto 0);
          annodeO: out std_logic_vector (7 downto 0));
end display_multiplexer;

architecture archi of display_multiplexer is
begin
    process (A, B, C, D, E, F, G, H, S)
    begin
      case S is
         when "000" => O <= A; annodeO <= annodeA;
         when "001" => O <= B; annodeO <= annodeB;
         when "010" => O <= C; annodeO <= annodeC;
         when "011" => O <= D; annodeO <= annodeD;
         when "100" => O <= E; annodeO <= annodeE;
         when "101" => O <= F; annodeO <= annodeF;
         when "110" => O <= G; annodeO <= annodeG;
         when "111" => O <= H; annodeO <= annodeH;
         
         when others => O <= A;  annodeO <= annodeA;
      end case;
    end process;
end archi;