library ieee;
use ieee.std_logic_1164.all;

entity Mux2_1_10bits is
port(
		Input1, Input2: in std_logic_vector(9 downto 0);
		Selector : in std_logic;
		Output : out std_logic_vector(9 downto 0)
		);
end entity;

architecture MUX_arch of Mux2_1_10bits is
begin

Output <= Input1 when Selector = '0' else
			 Input2;
end MUX_arch;