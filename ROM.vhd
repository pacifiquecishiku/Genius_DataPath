library ieee;
use ieee.std_logic_1164.all;

entity ROM is
  port ( address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(3 downto 0) );
end entity;

architecture behavioral of ROM is
  type mem is array (00 to 15) of std_logic_vector(3 downto 0);
  constant my_Rom : mem := (
	00 => "0100",
	01 => "0001",
   02 => "1000",
	03 => "0100",
	04 => "0001",
	05 => "0100",
	06 => "0010",
	07 => "0100",
	08 => "0001",
	09 => "1000",
	10 => "0010",
	11 => "0100",
	12 => "1000",
	13 => "0010",
	14 => "0100",
	15 => "0001");
begin
   process (address)
   begin
     case address is
       when "0000" => data <= my_rom(00);
       when "0001" => data <= my_rom(01);
       when "0010" => data <= my_rom(02);
       when "0011" => data <= my_rom(03);
       when "0100" => data <= my_rom(04);
       when "0101" => data <= my_rom(05);
       when "0110" => data <= my_rom(06);
       when "0111" => data <= my_rom(07);
       when "1000" => data <= my_rom(08);
       when "1001" => data <= my_rom(09);
		 when "1010" => data <= my_rom(10);
		 when "1011" => data <= my_rom(11);
		 when "1100" => data <= my_rom(12);
		 when "1101" => data <= my_rom(13);
		 when "1110" => data <= my_rom(14);
		 when "1111" => data <= my_rom(15);
       when others => data <= "0000";
       end case;
  end process;
end architecture behavioral;
