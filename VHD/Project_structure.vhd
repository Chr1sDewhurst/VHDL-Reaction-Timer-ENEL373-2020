----------------------------------------------------------------------------------
-- Company: UC ECE
-- Engineers: jfa84, gek22, cjd167
-- 
-- Create Date: 20.03.2020 10:55:34
-- Module Name: Project_structure - Structural
-- Project Name: Reaction_timer
-- Description: This module defines the project structure, through port mapping for
--              the decimal count down and display time annodes.             
----------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Project_structure is
    Port ( CLK100MHZ : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC );
end Project_structure;

architecture Structural of Project_structure is
constant thousand_HZ_clk_limit : std_logic_vector(27 downto 0) := X"000C350"; -- Up-count timer clock
constant hundred_HZ_clk_limit : std_logic_vector(27 downto 0) := X"007A120"; -- Button polling clock
constant one_HZ_clk_limit : std_logic_vector(27 downto 0) := X"2FAF07E"; -- Decimal count-down clock

signal display_mux: std_logic_vector (1 downto 0);

signal decimal_CLK: std_logic;
signal decimal_EN: std_logic;
signal decimal_R: std_logic;
signal decimal_FINISHED: std_logic;
signal decimal_AN: std_logic_vector (7 downto 0);

signal counter_CLK: std_logic;
signal counter_EN: std_logic;
signal counter_R: std_logic;

-- Seven segment display 
signal temp_bcd_0: std_logic_vector (3 downto 0);
signal temp_bcd_1: std_logic_vector (3 downto 0);
signal temp_bcd_2: std_logic_vector (3 downto 0);
signal temp_bcd_3: std_logic_vector (3 downto 0);
signal temp_bcd_4: std_logic_vector (3 downto 0);
signal temp_bcd_5: std_logic_vector (3 downto 0);
signal temp_bcd_6: std_logic_vector (3 downto 0);
signal temp_bcd_7: std_logic_vector (3 downto 0);

signal flasher_select: std_logic_vector (2 downto 0);
signal temp_bcd_counter: std_logic_vector (3 downto 0);
signal temp_counter_cathodes: std_logic_vector (7 downto 1);
signal temp_counter_anodes: std_logic_vector (7 downto 0);

signal polling_CLK: std_logic;
signal button_C: std_logic;


component my_divider
    Port ( Clk_in : in  STD_LOGIC;
           clk_limit: in STD_LOGIC_VECTOR(27 downto 0);
           Clk_out : out  STD_LOGIC);
end component;

component FSM_manager
    Port ( CLK_IN : in STD_LOGIC;
           BUTTON_C : in STD_LOGIC;
           decimal_EN : out STD_LOGIC; -- Enable decimal count-down state
           decimal_R : out STD_LOGIC; -- Reset decimal count-down state
           decimal_FINISHED : in STD_LOGIC; -- Signals the count-down has finishing
           counter_EN : out STD_LOGIC; -- Enable the reaction timing state
           counter_R : out STD_LOGIC; -- Reset the counter 
           display_mux : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component decimal_counter
    Port ( CLK_IN : in STD_LOGIC;
           EN : in STD_LOGIC;
           RESET : in STD_LOGIC;
           FINISHED : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component big_counter 
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
end component;

component uptick_3bit
    Port ( clk_in : in STD_LOGIC;
           int_out : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component flasher_multiplexer
    port (A, B, C, D, E, F, G, H : in std_logic_vector (3 downto 0);
          annode : out std_logic_vector (7 downto 0);
          S : in std_logic_vector (2 downto 0);
          O : out std_logic_vector (3 downto 0));
end component;

component BCD_to_7SEG
		   Port ( bcd_in: in std_logic_vector (3 downto 0);	-- Input BCD vector
    			leds_out: out	std_logic_vector (1 to 7));		-- Output 7-Seg vector 
end component;

component display_multiplexer
    port (A, B, C, D, E, F, G, H : in std_logic_vector (7 downto 0);
          annodeA, annodeB, annodeC, annodeD, annodeE, annodeF, annodeG, annodeH  : in std_logic_vector (7 downto 0);
          S : in std_logic_vector (2 downto 0);
          O : out std_logic_vector (7 downto 0);
          annodeO: out std_logic_vector (7 downto 0));
end component;

component button_polling
    Port ( button : in STD_LOGIC;
           CLK_IN : in STD_LOGIC;
           is_pushed : out STD_LOGIC);
end component;

begin
clock_divide_counter: my_divider port map(Clk_in => CLK100MHZ, clk_limit => thousand_HZ_clk_limit, Clk_out => counter_CLK);
clock_divide_polling: my_divider port map(Clk_in => CLK100MHZ, clk_limit => hundred_HZ_clk_limit, Clk_out => polling_CLK);
clock_divide_decimal: my_divider port map(Clk_in => CLK100MHZ, clk_limit => one_HZ_clk_limit, Clk_out => decimal_CLK);
connect_button_C_polling: button_polling port map(button => BTNC, CLK_IN => polling_CLK, is_pushed => button_C);
connect_decimal: decimal_counter port map(CLK_IN => decimal_CLK, EN => decimal_EN, RESET => decimal_R, FINISHED => decimal_FINISHED, AN => decimal_AN);
connect_counter: big_counter port map(clk_in => counter_clk, EN => counter_EN, R => counter_R,
                                 bcd_0 => temp_bcd_0, 
                                 bcd_1 => temp_bcd_1, 
                                 bcd_2 => temp_bcd_2, 
                                 bcd_3 => temp_bcd_3, 
                                 bcd_4 => temp_bcd_4, 
                                 bcd_5 => temp_bcd_5, 
                                 bcd_6 => temp_bcd_6, 
                                 bcd_7 => temp_bcd_7);
generate_flasher_select: uptick_3bit port map(clk_in => counter_CLK, int_out => flasher_select);
connect_flasher: flasher_multiplexer port map(A => temp_bcd_0, 
                                 B => temp_bcd_1, 
                                 C => temp_bcd_2, 
                                 D => temp_bcd_3, 
                                 E => temp_bcd_4, 
                                 F => temp_bcd_5, 
                                 G => temp_bcd_6, 
                                 H => temp_bcd_7, 
                                 S => flasher_select, 
                                 O => temp_bcd_counter, 
                                 annode => temp_counter_anodes);
connect_BCD_to_7SEG: BCD_to_7SEG port map(bcd_in => temp_bcd_counter, leds_out => temp_counter_cathodes);
connect_FSM: FSM_manager port map(CLK_IN => CLK100MHZ, BUTTON_C => button_C,
                                        decimal_EN => decimal_EN, decimal_R => decimal_R, decimal_FINISHED => decimal_FINISHED,
                                        counter_EN => counter_EN, counter_R => counter_R,
                                        display_mux => display_mux);
connect_display_mux: display_multiplexer port map(A (7 downto 1) => "1111111", A (0) => '0',
                                                  B (7 downto 1) => temp_counter_cathodes, B (0) => '1',
                                                  C (7 downto 1) => temp_counter_cathodes, C (0) => '1',
                                                  D (7 downto 1) => "1111111", D (0) => '1',
                                                  E (7 downto 1) => "1111111", E (0) => '1',
                                                  F (7 downto 1) => "1111111", F (0) => '1',
                                                  G (7 downto 1) => "1111111", G (0) => '1',
                                                  H (7 downto 1) => "1111111", H (0) => '1',
                                                  annodeA => decimal_AN, annodeB => temp_counter_anodes,
                                                  annodeC => temp_counter_anodes, annodeD => "11111111",
                                                  annodeE => "11111111", annodeF => "11111111",
                                                  annodeG => "11111111", annodeH => "11111111",
                                                  S(2) => '0', S (1 downto 0) => display_mux,
                                                  O (0) => DP, O (1) => CA, O (2) => CB, O (3) => CC,
                                                  O (4) => CD, O (5) => CE, O (6) => CF, O (7) => CG,
                                                  annodeO => AN);
end Structural;
