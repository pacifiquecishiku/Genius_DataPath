library ieee;
use ieee.std_logic_1164.all;

entity Register_Shift is
port(
		Clock,Enable,Reset: in std_logic;
		input: in std_logic_vector(3 downto 0);
		output: out std_logic_vector(63 downto 0)
		);
end entity;

architecture arch_Register of Register_Shift is
signal output_Signal: std_logic_vector(63 downto 0);
begin

process(Clock,Enable,Reset) is
begin
	if Reset = '1' then
		output_Signal <= X"0000000000000000";
	elsif rising_edge(Clock) then
		if Enable = '1' then
			output_Signal(63 downto 60) <= input;
			output_Signal(59 downto 56) <= output_Signal(63 downto 60);
			output_Signal(55 downto 52) <= output_Signal(59 downto 56);
			output_Signal(51 downto 48) <= output_Signal(55 downto 52);
			output_Signal(47 downto 44) <= output_Signal(51 downto 48);
			output_Signal(43 downto 40) <= output_Signal(47 downto 44);
			output_Signal(39 downto 36) <= output_Signal(43 downto 40);
			output_Signal(35 downto 32) <= output_Signal(39 downto 36);
			output_Signal(31 downto 28) <= output_Signal(35 downto 32);
			output_Signal(27 downto 24) <= output_Signal(31 downto 28);
			output_Signal(23 downto 20) <= output_Signal(27 downto 24);
			output_Signal(19 downto 16) <= output_Signal(23 downto 20);
			output_Signal(15 downto 12) <= output_Signal(19 downto 16);
			output_Signal(11 downto 8) <= output_Signal(15 downto 12);
			output_Signal(7 downto 4) <= output_Signal(11 downto 8);
			output_Signal(3 downto 0) <= output_Signal(7 downto 4);
		end if;
	end if;
	end process;
	output <= output_Signal;
	end arch_Register;