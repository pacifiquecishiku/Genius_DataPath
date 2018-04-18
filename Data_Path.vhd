library ieee;
use ieee.std_logic_1164.all;

entity Data_Path is
port(
	Clock_50: in std_logic;
	Reset : in std_logic_vector(8 downto 0);
	Enable : in std_logic_vector(6 downto 0)
	);
end Data_Path;

architecture Arch_Data_Path of Data_Path is
begin
----------------------------------------------------ROM
component ROM is
  port ( address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(3 downto 0) );
end component;
------------------------------------------------------CLOCKS
component Clocks is
port(
		Clock, Reset, Enable : in std_logic;
		CLK1, CLK2, CLK3, CLK4 : out std_logic
		);
end component;
------------------------------------------------------Mux2_1_10bits
component Mux2_1_10bits is
port(
		Input1, Input2: in std_logic_vector(9 downto 0);
		Selector : in std_logic;
		Output : out std_logic_vector(9 downto 0)
		);
end component;
-------------------------------------------------------Mux4_1_N_bit
component Mux4_1_N_bit is
generic(N: positive := 10);
port(
		Input1, Input2, Input3, Input4 : in std_logic_vector(N-1 downto 0);
		Selector : in std_logic_vector(1 downto 0);
		Output : out std_logic_vector(N-1 downto 0)
		);
end component;
--------------------------------------------------------Register_N_bits
component Register_N_bits is
generic(N : positive := 10);
port(
		Clock,Enable,Reset: in std_logic;
		input: in std_logic_vector(N-1 downto 0);
		output: out std_logic_vector(N-1 downto 0)
		);
end component;
-------------------------------------------------------Register_Shift
component Register_Shift is
port(
		Clock,Enable,Reset: in std_logic;
		input: in std_logic_vector(3 downto 0);
		output: out std_logic_vector(63 downto 0)
		);
end component;
---------------------------------------------------Counter
component Counter is
port(
		Enable, Clock, Reset : in std_logic;
		End_Time : out std_logic;
		Output : out std_logic_vector(3 downto 0)
		);
end component;
-----------------------------------------------------Counter_Signal_out
component Counter_Signal_out is
port(
		Enable, Clock, Reset : in std_logic;
		End_Time : out std_logic;
		Output : out std_logic_vector(3 downto 0)
		);
end component;
----------------------------------------------------------Comparador_N_Bits
component Comparador is
generic(N: positive := 10);
port(
		inputA,inputB : in std_logic_vector(N-1 downto 0);
		output: out std_logic;
		);
end component;
----------------------------------------------------------decod7SEG
component decod7seg is
port (
		Input: in std_logic_vector(3 downto 0);
		Output: out std_logic_vector(6 downto 0)
		);
end component;
-----------------------------------------------------------decodLEDR
component decodLedr is
port (
		Input: in std_logic_vector(3 downto 0);
		Output: out std_logic_vector(9 downto 0)
		);
end component;