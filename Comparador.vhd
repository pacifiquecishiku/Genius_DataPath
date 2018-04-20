library ieee;
use ieee.std_logic_1164.all;

entity Comparador is
generic(N: positive := 10);
port(
		inputA,inputB : in std_logic_vector(N-1 downto 0);
		output: out std_logic
		);
end Comparador;

architecture Arch_Comp of Comparador is
begin

output <= '1' when inputA = inputB else
			 '0';
end Arch_Comp;