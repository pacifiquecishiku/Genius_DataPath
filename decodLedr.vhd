library IEEE;
use IEEE.Std_Logic_1164.all;

entity decodLedr is
port (
		Input: in std_logic_vector(3 downto 0);
		Output: out std_logic_vector(9 downto 0)
		);
end entity;

architecture decod of decodLedr is
begin
Output <=	"0000000000" when	Input= "0000" else		--0
				"0000000001" when	Input= "0001" else		--1
				"0000000010" when Input= "0010" else		--2
				"0000000011" when Input= "0011" else  		--3
				"0000000100" when Input= "0100" else		--4
				"0000000101" when Input= "0101" else		--5
				"0000000110" when Input= "0110" else		--6
				"0000000111" when Input= "0111" else		--7
				"0000001000" when Input= "1000" else		--8
				"0000001001" when Input= "1001" else		--9
				"0000001010" when Input= "1010" else		--A
				"0000001011" when Input= "1011" else		--B
				"0000001100" when Input= "1100" else		--C
				"0000001101" when Input= "1101" else		--D
				"0000001110" when Input= "1110" else		--E
				"0000001111";										--F
end decod;