library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  
-- em khong port map cai nay
entity memory_block is
    GENERIC ( 
        M : Integer := 2;
        N : Integer := 2;
        DATA_WIDTH : integer := 8;
        Addr_WIDTH : integer := 8
    );
    Port (
        CLK  : in  STD_LOGIC;
        RE   : in  STD_LOGIC;
        Din  : in  STD_LOGIC_VECTOR(DATA_WIDTH*N*M - 1 downto 0); 
        ADDR : in  STD_LOGIC_VECTOR(Addr_WIDTH - 1 downto 0);  
        Dout : out STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0)   
    );
end memory_block;

architecture Behavioral of memory_block is
    begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if RE = '1' then
                Dout <= Din(to_integer(unsigned(ADDR)+1)*8-1 downto to_integer(unsigned(ADDR))*8);  
            
                
            end if;
        end if;
    end process;
end Behavioral;

