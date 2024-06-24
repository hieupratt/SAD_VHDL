library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg is
    GENERIC ( 
        M : Integer := 2;
        N : Integer := 2;
        DATA_WIDTH : integer := 8;
        Addr_WIDTH : integer := 8
    );
    Port (
        Rst, CLK  : in  STD_LOGIC;
        En   : in  STD_LOGIC;
        D  : in  STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0); 
        Q : out STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0)  
    );
end Reg;

architecture Behavioral of Reg is
begin
    process(CLK, RST)
    begin
	if (RST = '1') THEN
		Q <= (others => '0');
        elsif CLK'EVENT and CLK = '1' then
        	IF (EN = '1') then
			Q <= D;
      		end if;
        end if;
    end process;
end Behavioral;

