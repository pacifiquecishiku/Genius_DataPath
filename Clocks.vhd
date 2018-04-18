library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Clocks is
port(
		Clock, Reset, Enable : in std_logic;
		CLK1, CLK2, CLK3, CLK4 : out std_logic
		);
end entity;

architecture FSM_Arch of Clocks is
signal CONT1, CONT2, CONT3, CONT4: integer := 0;
	begin

	process (Clock, Enable, Reset)
	
	begin
		if Reset = '1' then
			CONT1 <= 0;
			CONT2 <= 0;
			CONT3 <= 0;
			CONT4 <= 0;
		elsif rising_edge(Clock) and Enable = '1' then
				CONT1 <= CONT1 + 1;
				CONT2 <= CONT2 + 1;
				CONT3 <= CONT3 + 1;
				CONT4 <= CONT4 + 1;
			
			if CONT1 = 500000000 then --1Hz
				CLK1 <= '1';
				CONT1 <= 1;
			else
				CLK1 <= '0';
			end if;
			
			if CONT2 = 250000000 then --0,5Hz
				CLK2 <= '1';
				CONT2 <= 1;
			else
				CLK2 <= '0';
			end if;
			
			if CONT3 = 166666670 then --0,33Hz
				CLK3 <= '1';
				CONT3 <= 1;
			else
				CLK3 <= '0';
			end if;
			
			if CONT4 = 125000000 then --0,25Hz
				CLK4 <= '1';
				CONT4 <= 1;
			else
				CLK4 <= '0';
			end if;
		end if;
	end process;
end FSM_Arch;
