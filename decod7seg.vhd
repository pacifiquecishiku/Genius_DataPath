library IEEE;
use IEEE.Std_Logic_1164.all;

entity decod7seg is
port (
		Input: in std_logic_vector(3 downto 0);
		Output: out std_logic_vector(6 downto 0)
		);
end entity;

architecture decod of decod7seg is
begin
Output <=	"1000000" when	Input= "0000" else		--0
				"1111001" when	Input= "0001" else		--1
				"0100100" when Input= "0010" else		--2
				"0110000" when Input= "0011" else  		--3
				"0011001" when Input= "0100" else		--4
				"0010010" when Input= "0101" else		--5
				"0000010" when Input= "0110" else		--6
				"1111000" when Input= "0111" else		--7
				"0000000" when Input= "1000" else		--8
				"0011000" when Input= "1001" else		--9
				"0001000" when Input= "1010" else		--A
				"0000011" when Input= "1011" else		--B
				"1000110" when Input= "1100" else		--C
				"0100001" when Input= "1101" else		--D
				"0000110" when Input= "1110" else		--E
				"0001110";										--F
end decod;