----------------------------------------------------------------------------------
-- Company: UC ECE
-- Engineers: jfa84, gek22, cjd167
-- 
-- Create Date: 20.03.2020 10:55:34
-- Module Name: FSM_manager - Behavioral
-- Project Name: Reaction_timer
-- Description: This module acts as an FSM for the count down prompt, counting up, 
--              display time, and reset states. The enable and reset pins are modified.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FSM_manager is
    Port ( CLK_IN : in STD_LOGIC;
           BUTTON_C : in STD_LOGIC;
           decimal_EN : out STD_LOGIC;
           decimal_R : out STD_LOGIC;
           decimal_FINISHED : in STD_LOGIC;
           counter_EN : out STD_LOGIC;
           counter_R : out STD_LOGIC;
           display_mux : out STD_LOGIC_VECTOR (1 downto 0));
end FSM_manager;

architecture Behavioral of FSM_manager is
-- Preset encoded state to decimal count-down
signal state: std_logic_vector (1 downto 0) := "00"; 
-- A signal is used to check button C has been read and pressed
signal button_C_high_and_read: std_logic := '0';
begin process (CLK_IN)
begin
if BUTTON_C = '0' then
    button_C_high_and_read <= '0';
end if;
if rising_edge(CLK_IN) then
    case state is
    -- Decimal count-down state, state is changed if count down finishes
    when "00" =>
        if (decimal_FINISHED = '1') then
            decimal_EN <= '0';
            decimal_R <= '0';
            counter_EN <= '1';
            counter_R <= '0';
            state <= "01";
        else
        decimal_EN <= '1';
        decimal_R <= '0';
        counter_EN <= '0';
        counter_R <= '1';
        end if;
    -- Counting up state, counting stops if button C input
    -- is pressed and unread
    when "01" =>
        if BUTTON_C = '1' AND button_C_high_and_read = '0' then
            button_C_high_and_read <= '1';
            decimal_EN <= '0';
            decimal_R <= '1';
            counter_EN <= '0';
            counter_R <= '0';
            state <= "10";
        else
            decimal_EN <= '0';
            decimal_R <= '1';
            counter_EN <= '1';
            counter_R <= '0';
        end if;
    -- Display time state, state is reset to decimal countdown if button C
    -- is pressed and unread
    when "10" =>
        if (BUTTON_C = '1') AND (button_C_high_and_read = '0') then
            button_C_high_and_read <= '1';
            decimal_EN <= '0';
            decimal_R <= '0';
            counter_EN <= '0';
            counter_R <= '1';
            state <= "00";
        else        
            decimal_EN <= '0';
            decimal_R <= '1';
            counter_EN <= '0';
            counter_R <= '0';
        end if;
    when others => state <= "00";
end case;
end if;
end process;
display_mux <= state;
end Behavioral;
