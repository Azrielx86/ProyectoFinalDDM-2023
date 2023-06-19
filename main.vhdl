library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity main is
  port (
    clk : in std_logic;
    reset : in std_logic;
    C, CC, V : in std_logic;
    E : out std_logic_vector(3 downto 0);
    L : out std_logic;
    monto_1 : out std_logic_vector(6 downto 0);
    monto_2 : out std_logic_vector(6 downto 0);
    monto_3 : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavioral of main is
  type Estados is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10);
  signal PS, NS : Estados;
  signal div_clk : std_logic;
  signal m_state : std_logic_vector(3 downto 0);
begin
  process (reset, div_clk)
  begin
    if reset = '0' then
      PS <= S0;
    elsif rising_edge(div_clk) then
      PS <= NS;
    end if;
  end process;

  process (PS, C, CC, V, m_state)
  begin
    case PS is
      when S10 =>
        E <= "1010";
        m_state <= "1010";
        L <= '1';
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        else
          NS <= S9;
        end if;

      when S9 =>
        E <= "1001";
        m_state <= "1001";
        L <= '0';
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        else
          NS <= S8;
        end if;

      when S8 =>
        E <= "1001";
        m_state <= "1001";
        L <= '1';
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        else
          NS <= S7;
        end if;

      when S7 =>
        E <= "0111";
        m_state <= "0111";
        L <= '0';
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        else
          NS <= S6;
        end if;

      when S6 =>
        E <= "0110";
        m_state <= "0110";
        L <= '1';
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        else
          NS <= S5;
        end if;

      when S5 =>
        E <= "0101";
        m_state <= "0101";
        L <= '0';
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        else
          NS <= S4;
        end if;

      when S4 =>
        E <= "0100";
        m_state <= "0100";
        L <= '1';
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        else
          NS <= S3;
        end if;

      when S3 =>
        E <= "0011";
        m_state <= "0011";
        L <= '0';
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        else
          NS <= S2;
        end if;

      when S2 =>
        E <= "0010";
        m_state <= "0010";
        L <= '1';
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        else
          NS <= S1;
        end if;

      when S1 =>
        E <= "0001";
        m_state <= "0001";
        L <= '0';
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        else
          NS <= S0;
        end if;

      when S0 =>
        E <= "0000";
        m_state <= "0000";
        L <= '1';
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        else
          NS <= S0;
        end if;

      when others =>
        E <= "0000";
        m_state <= "0000";
        L <= '1';
        NS <= S0;
    end case;

    case m_state is
      when "1010" =>
        monto_1 <= "1001111";
        monto_2 <= "1000000";
        monto_3 <= "1000000";
      when "0101" =>
        monto_1 <= "1111111";
        monto_2 <= "0010010";
        monto_3 <= "1000000";
        when "0010" =>
        monto_1 <= "1111111";
        monto_2 <= "0100100";
        monto_3 <= "1000000";
      when others =>
        monto_1 <= "1111111";
        monto_2 <= "1111111";
        monto_3 <= "1111111";
    end case;
  end process;

  -- process (m_state, monto_1, monto_2, monto_3)
  -- begin
  -- end process;

  freq : entity work.DivisorFrecuencias (behavioral) port map(
    reloj => clk,
    div_clk => div_clk
    );

end architecture;