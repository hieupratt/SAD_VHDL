library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity SAD_tb is
end SAD_tb;

architecture R of SAD_tb is
    constant CLK_PERIOD : time := 10 ns;
    signal TB_CLK : std_logic := '0'; 
    signal TB_RS : std_logic := '0';   
    signal TB_Start : std_logic := '0';  
    signal TB_DATA_A : std_logic_vector(2*2*8-1 downto 0) := (others => '0'); 
    signal TB_DATA_B : std_logic_vector(2*2*8-1 downto 0) := (others => '0');  
    signal TB_DATA_Out : std_logic_vector(8-1 downto 0);  
    signal TB_Done : std_logic; 
   
begin

    uut: entity work.SAD
        generic map (
            M => 2,
            N => 2,
            DATA_WIDTH => 8,
            Addr_WIDTH => 8
        )
        port map (
            CLK => TB_CLK,  
            RS => TB_RS,    
            Start => TB_Start,  
            DATA_A => TB_DATA_A,  
            DATA_B => TB_DATA_B,  
            DATA_Out => TB_DATA_Out,  
            Done => TB_Done   
        );

    -- clock
    clk_process : process
    begin
        TB_CLK <= '0';
        wait for 1 ns;
        TB_CLK <= '1';
        wait for 0 ns;
    end process;

    -- mo phong
    stim_proc: process
    begin
	TB_start <= '0';
        -- Reset 
        TB_RS <= '1';
        wait for 1 ns;
        TB_RS <= '0';
	
       

        -- xet input
        TB_DATA_A(7 downto 0) <= "00010001"; 
        TB_DATA_A(15 downto 8) <= "00000101"; 
        TB_DATA_A(23 downto 16) <= "00001001";
        TB_DATA_A(31 downto 24) <= "00010001"; 
        
        TB_DATA_B(7 downto 0) <= "00000101";
        TB_DATA_B(15 downto 8) <= "00000001";
        TB_DATA_B(23 downto 16)  <= "00000001";
        TB_DATA_B(31 downto 24)  <= "00000010";
	TB_start <= '1';
        -- cho cho done = 1
        wait until TB_Done = '1';
	TB_start <= '0';
        
	wait for 300 ns;
        
        wait;
    end process;

end R;

