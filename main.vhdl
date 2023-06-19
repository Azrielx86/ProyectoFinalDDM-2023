library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity main is
  port (
    clk : in std_logic;
    reset : in std_logic;
    M, Q, D : in std_logic;
    E : out std_logic_vector(3 downto 0);
    L : out std_logic
  );
end entity;

architecture behavioral of main is
  type Estados is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10);
  signal PS, NS : Estados;
  signal div_clk : std_logic;
begin
  process (reset, div_clk)
  begin
    if reset = '0' then
      PS <= S0;
    elsif rising_edge(div_clk) then
      PS <= NS;
    end if;
  end process;

  process (PS, M, Q, D)
  begin
    case PS is
      when S10 =>
        E <= "1010";
        L <= '1';
        if M = '1' then
          NS <= S10;
        elsif Q = '1' then
          NS <= S5;
        elsif D = '1' then
          NS <= S2;
        else
          NS <= S9;
        end if;

      when S9 =>
        E <= "1001";
        L <= '0';
        if M = '1' then
          NS <= S10;
        elsif Q = '1' then
          NS <= S5;
        elsif D = '1' then
          NS <= S2;
        else
          NS <= S8;
        end if;

      when S8 =>
        E <= "1001";
        L <= '1';
        if M = '1' then
          NS <= S10;
        elsif Q = '1' then
          NS <= S5;
        elsif D = '1' then
          NS <= S2;
        else
          NS <= S7;
        end if;

      when S7 =>
        E <= "0111";
        L <= '0';
        if M = '1' then
          NS <= S10;
        elsif Q = '1' then
          NS <= S5;
        elsif D = '1' then
          NS <= S2;
        else
          NS <= S6;
        end if;

      when S6 =>
        E <= "0110";
        L <= '1';
        if M = '1' then
          NS <= S10;
        elsif Q = '1' then
          NS <= S5;
        elsif D = '1' then
          NS <= S2;
        else
          NS <= S5;
        end if;

      when S5 =>
        E <= "0101";
        L <= '0';
        if M = '1' then
          NS <= S10;
        elsif Q = '1' then
          NS <= S5;
        elsif D = '1' then
          NS <= S2;
        else
          NS <= S4;
        end if;

      when S4 =>
        E <= "0100";
        L <= '1';
        if M = '1' then
          NS <= S10;
        elsif Q = '1' then
          NS <= S5;
        elsif D = '1' then
          NS <= S2;
        else
          NS <= S3;
        end if;

      when S3 =>
        E <= "0011";
        L <= '0';
        if M = '1' then
          NS <= S10;
        elsif Q = '1' then
          NS <= S5;
        elsif D = '1' then
          NS <= S2;
        else
          NS <= S2;
        end if;

      when S2 =>
        E <= "0010";
        L <= '1';
        if M = '1' then
          NS <= S10;
        elsif Q = '1' then
          NS <= S5;
        elsif D = '1' then
          NS <= S2;
        else
          NS <= S1;
        end if;

      when S1 =>
        E <= "0001";
        L <= '0';
        if M = '1' then
          NS <= S10;
        elsif Q = '1' then
          NS <= S5;
        elsif D = '1' then
          NS <= S2;
        else
          NS <= S0;
        end if;

      when S0 =>
        E <= "0000";
        L <= '1';
        if M = '1' then
          NS <= S10;
        elsif Q = '1' then
          NS <= S5;
        elsif D = '1' then
          NS <= S2;
        else
          NS <= S0;
        end if;

      when others =>
        null;
    end case;
  end process;

  freq : entity work.DivisorFrecuencias (behavioral) port map(
    reloj => clk,
    div_clk => div_clk
    );

end architecture;