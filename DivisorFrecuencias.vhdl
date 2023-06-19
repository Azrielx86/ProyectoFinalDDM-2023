library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity DivisorFrecuencias is
  port (
    reloj : std_logic;
    div_clk : out std_logic
  );
end entity;

architecture behavioral of DivisorFrecuencias is
begin
  process (reloj)
    variable cuenta : std_logic_vector(27 downto 0) := X"0000000";
    variable tmp : std_logic := '0';
  begin
    if rising_edge(reloj) then
      if cuenta = X"17D7840" then
        cuenta := X"0000000";
        tmp := not tmp;
      else
        cuenta := cuenta + 1;
      end if;
    end if;
    div_clk <= tmp;
  end process;
end architecture;