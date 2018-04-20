library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity Data_Path is
port(
	Clock_50: in std_logic;
	Reset : in std_logic_vector(1 downto 0);
	Ea, Eb, Ec, Ed,Sel_Led : in std_logic;
	btn0,btn1,btn2,btn3 : in std_logic;
	SW: in std_logic_vector(1 downto 0);
	HEX00,HEX01,HEX02,HEX03,HEX04,HEX05 : out std_logic_vector(6 downto 0);
	LED: out std_logic_vector(9 downto 0);
	End_Time,End_Game,End_Round : out std_logic
	);
end Data_Path;

architecture Arch_Data_Path of Data_Path is

signal BTN,comp : std_logic_vector(3 downto 0);
signal CLK1, CLK2, CLK3, CLK4,CLK, Erro,Enable: std_logic;
signal Time_Output,Game_Output,Counter_Rom_Output,ROM_data,Ponctuation: std_logic_vector(3 downto 0);
signal ROM_data_64b,User_Data_64b : std_logic_vector(63 downto 0);
signal Out_Led,Out_Led_reg : std_logic_vector(9 downto 0);
signal Out_Ponctuation : std_logic_vector(7 downto 0);
signal In_Ponc_reg,Out_Ponc_reg : std_logic_vector(13 downto 0);


				--Components--
----------------------------------------------------ROM
component ROM
  port ( address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(3 downto 0) );
end component;
------------------------------------------------------CLOCKS
component Clocks
port(
		Clock, Reset, Enable : in std_logic;
		CLK1, CLK2, CLK3, CLK4: out std_logic
		);
end component;
------------------------------------------------------Mux2_1_10bits
component Mux2_1_10bits
port(
		Input1, Input2: in std_logic_vector(9 downto 0);
		Selector : in std_logic;
		Output : out std_logic_vector(9 downto 0)
		);
end component;
------------------------------------------------------Mux2_1_4bits
component Mux2_1_4bits
port(
		Input1, Input2: in std_logic_vector(3 downto 0);
		Selector : in std_logic;
		Output : out std_logic_vector(3 downto 0)
		);
end component;
-------------------------------------------------------Mux4_1_8_bit
component Mux4_1_8_bit
port(
		Input1, Input2, Input3, Input4 : in std_logic_vector(7 downto 0);
		Selector : in std_logic_vector(1 downto 0);
		Output : out std_logic_vector(7 downto 0)
		);
end component;
-------------------------------------------------------Mux4_1_1_bit
component Mux4_1_1_bit
port(
		Input1, Input2, Input3, Input4 : in std_logic;
		Selector : in std_logic_vector(1 downto 0);
		Output : out std_logic
		);
end component;
--------------------------------------------------------Register_N_bits
component Register_N_bits
generic(N : positive := 10);
port(
		Clock,Enable,Reset: in std_logic;
		input: in std_logic_vector(N-1 downto 0);
		output: out std_logic_vector(N-1 downto 0)
		);
end component;
-------------------------------------------------------Register_Shift
component Register_Shift
port(
		Clock,Enable,Reset: in std_logic;
		input: in std_logic_vector(3 downto 0);
		output: out std_logic_vector(63 downto 0)
		);
end component;
---------------------------------------------------Counter
component Counter
port(
		Enable, Clock, Reset : in std_logic;
		Output : out std_logic_vector(3 downto 0)
		);
end component;
-----------------------------------------------------Counter_Signal_out
component Counter_Signal_out
port(
		Enable, Clock, Reset : in std_logic;
		End_Time : out std_logic;
		Output : out std_logic_vector(3 downto 0)
		);
end component;
----------------------------------------------------------Comparador_N_Bits
component Comparador
generic(N: positive := 10);
port(
		inputA,inputB : in std_logic_vector(N-1 downto 0);
		output: out std_logic
		);
end component;
----------------------------------------------------------decod7SEG
component decod7seg
port (
		Input: in std_logic_vector(3 downto 0);
		Output: out std_logic_vector(6 downto 0)
		);
end component;
-----------------------------------------------------------decodLEDR
component decodLedr
port (
		Input: in std_logic_vector(3 downto 0);
		Output: out std_logic_vector(9 downto 0)
		);
end component;

				--PORT MAP--
begin

BTN <= btn3 & btn2 & btn1 & btn0;
Enable <= BTN(0) or BTN(1) or BTN(2) or BTN(3);
comp <= (Game_Output + "0001") ;

Clocks_Source		: Clocks port map (Clock_50, Reset(1),'1',CLK1, CLK2, CLK3, CLK4);
Mux_Clocks			: Mux4_1_1_bit port map (CLK1, CLK2, CLK3, CLK4,SW,CLK);
Counter_Time		: Counter_Signal_out port map (Ea, CLK, Reset(0),End_Time,Time_Output);
Counter_Stage		: Counter_Signal_out port map (Ed,CLK, Reset(0),End_Game,Game_Output);
Counter_Rom 		: Counter port map (Eb,CLK, Reset(0),Counter_Rom_Output);
Comparador_4_bit	: Comparador generic map (N => 4) port map (comp,Counter_Rom_Output,End_Round);
ROM_mem 				: ROM port map (Counter_Rom_Output,ROM_data);
Reg_Shift_Rom		: Register_Shift port map (CLK,Eb,Reset(0),ROM_data,ROM_data_64b);
--Mux_input_User		: Mux2_1_4bits port map ("0000", BTN,seletor,User_Data);--completar (seletor)
Reg_Shift_User		: Register_Shift port map (CLK,Enable,Reset(0),BTN,User_Data_64b);
Comparador_64_bit	: Comparador generic map (N => 64) port map (User_Data_64b,ROM_data_64b,Erro);
Counter_Ponct 		: Counter port map (Erro,CLK, Reset(0),Ponctuation);
decod_Ponct_led	: decodLedr port map (Ponctuation, Out_Led);
Reg_Ledr				: Register_N_bits generic map (N => 10) port map (CLK,Ec,Reset(0),Out_Led,Out_Led_reg);
Mux_led				: Mux2_1_10bits port map ("0000000000", Out_Led_reg,Sel_Led,LED);
Mux_ponctuation	: Mux4_1_8_bit port map("0000"& Ponctuation, "000"& Ponctuation & '0', "00"& Ponctuation & "00",'0' & Ponctuation & "000",SW,Out_Ponctuation);
decod_Ponct_7seg0	: decod7seg port map (Out_Ponctuation(3 downto 0),In_Ponc_reg(6 downto 0));
decod_Ponct_7seg1	: decod7seg port map (Out_Ponctuation(7 downto 4),In_Ponc_reg(13 downto 7 ));
Reg_7seg				: Register_N_bits generic map (N => 14) port map (CLK,Ec,Reset(0),In_Ponc_reg,Out_Ponc_reg);

HEX05 <= "1000111";
dec_HEX4 : decod7seg port map ("00"& SW,HEX04);
HEX03 <= "0000111";
dec_HEX2 : decod7seg port map (Time_Output,HEX02);
HEX01 <= Out_Ponc_reg(13 downto 7);
HEX00 <= Out_Ponc_reg(6 downto 0);

end Arch_Data_Path;