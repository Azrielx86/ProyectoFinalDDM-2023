library IEEE;
use IEEE.std_logic_1164.all;

entity decoder is
  port (
    input : in std_logic_vector(3 downto 0);
    output : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavioral of decoder is
begin
  with input select
    output <= "0000001" when "0000", -- 0
    "1001111" when "0001", -- 1
    "0010010" when "0010", -- 2
    "0000110" when "0011", -- 3
    "1001100" when "0100", -- 4
    "0100100" when "0101", -- 5
    "0100000" when "0110", -- 6
    "0001111" when "0111", -- 7
    "0000000" when "1000", -- 8
    "0001100" when "1001", -- 9
    "0001000" when "1010", -- A
    "1100000" when "1011", -- B
    "1111111" when others;
end behavioral;