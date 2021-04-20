----------------------------------------------------------------------------------
-- Company: UC ECE
-- Engineer: cjd167
-- 
-- Create Date: 09.05.2020 12:14:16
-- Project Name: Reaction_timer
-- Module Name: Decimal_Counter_TB - Behavioral
-- Description: This testbench inspects the behaviour of the decimal countdown
--              module. The three AN signals going high represent the decimal
--              points turning off sequentially when EN is high. Turning RESET
--              high turns the AN signals low.
-- 
-- Dependencies: decimal_counter.vhd
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity Decimal_Counter_TB is
end Decimal_Counter_TB;

architecture Behavioral of Decimal_Counter_TB is

    component decimal_counter is
    port ( CLK_IN : in STD_LOGIC;
           EN : in STD_LOGIC;
           RESET : in STD_LOGIC;
           FINISHED : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0));
   end component;
   
   --INPUTS
   signal CLK_IN_SIM : STD_LOGIC;
   signal EN_SIM : STD_LOGIC;
   signal RESET_SIM : STD_LOGIC;
   
   --OUTPUTS
   signal FINISHED_SIM : STD_LOGIC;
   signal AN_SIM : STD_LOGIC_VECTOR (7 downto 0);
   
   constant CLK_PERIOD : time := 20ns;

begin
    UUT: decimal_counter port map (CLK_IN => CLK_IN_SIM, EN => EN_SIM, RESET => RESET_SIM, FINISHED => FINISHED_SIM, AN => AN_SIM);
    
    clk_process : process
    begin
        CLK_IN_SIM <= '0';
        wait for CLK_PERIOD /2;
        CLK_IN_SIM <= '1';
        wait for CLK_PERIOD /2;
    end process;
    
    syimulus_process : process
    variable ctr : integer range 0 to 3 := 0;
    variable i : integer range 0 to 3 := 0;
    --variable complete : boolean := false;
    begin
        
    wait for 100ns;
        --test normal operation
        if(ctr = 0) then
            RESET_SIM <= '0';
            EN_SIM <= '1';
            if(FINISHED_SIM = '1') then
                wait for 10ns;
                RESET_SIM <= '1';
                EN_SIM <= '0';
                ctr := 1;
                end if;
        end if;
        
    end process;
        

end Behavioral;
