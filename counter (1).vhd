library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
    GENERIC ( M ,N : Integer := 2;
	DATA_WIDTH : integer := 8;
	Addr_WIDTH : integer := 8) ;
    Port (
        reset : in  STD_LOGIC;
        clock : in  STD_LOGIC;
        Ld  : in  STD_LOGIC;
        En  : in  STD_LOGIC;
        dout   : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) 
    );
end counter;

architecture Behavioral of counter is
    signal counter_value : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) := (others => '0');
begin
    process (clock, reset)
    begin
        if reset = '1' then
            counter_value <= (others => '0');  -- reset ve 0
        elsif rising_edge(clock) then
            if Ld = '1' then
                counter_value <= (others => '0');  -- reset ve 0
            elsif En = '1' then
                counter_value <= counter_value + 1;  -- tang counter len 1
            end if;
        end if;
    end process;

    dout <= counter_value;  -- gan gia tri ra ngoai
end Behavioral;

