library ieee;
use ieee.std_logic_1164.all;

entity Data_Path is
port(
	Clock_50: in std_logic;
	Reset : in std_logic_vector(1 downto 0);
	Ea, Eb, Ec, Ed : in std_logic
	);
end Data_Path;

architecture Arch_Data_Path of Data_Path is

signal CLK1, CLK2, CLK3, CLK4: std_logic;

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
		CLK1, CLK2, CLK3, CLK4 : out std_logic
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
		End_Time : out std_logic;
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
		output: out std_logic;
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

Clocks_Source: Clocks port map (Clock_50, Reset(1),'1',CLK1, CLK2, CLK3, CLK4);
Mux_Clocks: 	Mux4_1_N_bit port map (generic N:= 1)