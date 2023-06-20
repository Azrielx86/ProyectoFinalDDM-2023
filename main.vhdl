library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity main is
  port (
    clk : in std_logic;
    reset, btn_start : in std_logic;
    C, CC, V : in std_logic;
    E : out std_logic_vector(3 downto 0);
    L : out std_logic;
    monto_1 : out std_logic_vector(6 downto 0);
    monto_2 : out std_logic_vector(6 downto 0);
    monto_3 : out std_logic_vector(6 downto 0);
    conteo : out std_logic_vector(6 downto 0);
    conteo_2 : out std_logic_vector(6 downto 0)
  );
end entity;

architecture behavioral of main is
  type Estados is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10);
  signal PS, NS : Estados;
  signal div_clk : std_logic;
  signal m_state : std_logic_vector(3 downto 0);
  signal sig_conteo_1 : std_logic_vector(3 downto 0);
  signal sig_conteo_2 : std_logic_vector(3 downto 0);
  signal btn_presionado : std_logic := '0';
begin
  process (reset, div_clk)
  begin
    if reset = '0' then
      PS <= S0;
    elsif rising_edge(div_clk) then
      PS <= NS;
    end if;
  end process;

  process (PS, C, CC, V, m_state, btn_start, btn_presionado)
  begin
    case PS is
      when S10 =>
        E <= "1010";
        m_state <= "1010";
        L <= '1';
        sig_conteo_1 <= "0001";
        sig_conteo_2 <= "0000";
        btn_presionado <= btn_start;
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        elsif btn_start = '0' then
          NS <= S9;
        else
          NS <= S10;
        end if;

      when S9 =>
        E <= "1001";
        m_state <= "1001";
        L <= '1';
        sig_conteo_1 <= "1001";
        sig_conteo_2 <= "1111";
        btn_presionado <= '0';
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
        E <= "1000";
        m_state <= "1000";
        L <= '1';
        sig_conteo_1 <= "1000";
        sig_conteo_2 <= "1111";
        btn_presionado <= '0';
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
        L <= '1';
        sig_conteo_1 <= "0111";
        sig_conteo_2 <= "1111";
        btn_presionado <= '0';
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
        sig_conteo_1 <= "0110";
        sig_conteo_2 <= "1111";
        btn_presionado <= '0';
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
        m_state <= "0101" or not btn_presionado & "1" & not btn_presionado & "1";
        L <= '1';
        sig_conteo_1 <= "0101";
        sig_conteo_2 <= "1111";
        btn_presionado <= btn_presionado and btn_start;
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        elsif btn_presionado = '0' then
          NS <= S4;
        else
          NS <= S5;
        end if;

      when S4 =>
        E <= "0100";
        m_state <= "0100";
        L <= '1';
        sig_conteo_1 <= "0100";
        sig_conteo_2 <= "1111";
        btn_presionado <= '0';
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
        L <= '1';
        sig_conteo_1 <= "0011";
        sig_conteo_2 <= "1111";
        btn_presionado <= '0';
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
        m_state <= "0010" or not btn_presionado & not btn_presionado & "1" & not btn_presionado;
        L <= '1';
        sig_conteo_1 <= "0010";
        sig_conteo_2 <= "1111";
        btn_presionado <= btn_presionado and btn_start;
        if C = '1' then
          NS <= S10;
        elsif CC = '1' then
          NS <= S5;
        elsif V = '1' then
          NS <= S2;
        elsif btn_presionado = '0' then
          NS <= S1;
        else
          NS <= S2;
        end if;

      when S1 =>
        E <= "0001";
        m_state <= "0001";
        L <= '1';
        sig_conteo_1 <= "0001";
        sig_conteo_2 <= "1111";
        btn_presionado <= '0';
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
        L <= '0';
        sig_conteo_1 <= "1111";
        sig_conteo_2 <= "1111";
        btn_presionado <= btn_start;
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
        L <= '0';
        sig_conteo_1 <= "1111";
        sig_conteo_2 <= "1111";
        btn_presionado <= '0';
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

  freq : entity work.DivisorFrecuencias (behavioral) port map(
    reloj => clk,
    div_clk => div_clk
    );

  cont_1 : entity work.decoder (behavioral) port map(
    input => sig_conteo_1,
    output => conteo
    );

  cont_2 : entity work.decoder (behavioral) port map(
    input => sig_conteo_2,
    output => conteo_2
    );

end architecture;