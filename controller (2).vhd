LIBRARY ieee;
USE ieee.STD_logic_1164.all;

ENTITY controller IS
    PORT (
        CLK : IN STD_LOGIC;
        RS : IN STD_LOGIC;
        Start : IN STD_LOGIC;
        
        Re_A, Re_B : out STD_LOGIC;
	LD_i, LD_j : out STD_LOGIC;
        Eni, Enj, EnA,EnPlus : out STD_LOGIC;
        Init, sign : out STD_LOGIC;
        zi, zj, A_gt_B : in STD_LOGIC;
        Done : OUT STD_LOGIC
    );
END controller ;

ARCHITECTURE R OF controller  IS
type state_type IS (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12);
signal state : state_type;
BEGIN
process (CLK,RS)
begin

if rs = '1' then
 state <= s0;
Elsif (CLK'EVENT and CLK = '1') then
case state is
	when S0 => 
	state <= S1;
	when S1 =>
	if start = '1' then
	state <= S2;
	else
	state <= S1;
	end if;
	when S2 =>
	if zi = '0' then
	state <= S3;
	else
	state <= S11;
	end if;
	when S3 =>
	if zj = '0' then
	state <= S4;
	else
	state <= S10;
	end if;
	when S4 =>
	state <= S5;
	when S5 =>
	if A_gt_B = '0' then
	state <= S7;
	else
	state <= S6;
	end if;
	when S6 =>
	state <= S8;
	when S7 =>
	state <= S8;
	when S8 =>
	state <= S9;
	when S9 =>
	state <= S3;
	when S10 =>
	state <= S2;
	when S11 =>
	state <= S12;
	when S12 =>
	if start = '0' then
	state <= S0;
	else
	state <= S12;
	end if;
	when others => state <= s0;
end case;
	
	
end if;


end process;
Ld_i <= '1' when (state = S0 or state = S11)  else '0';
Ld_j <= '1' when (state = S0 or state = s10) else '0';
eni <= '1' when state = S10 else '0';
enj <= '1' when state = S9 else '0';
init <= '0' when state = S0 else '1';
RE_A <= '1' when state = S4 else '0';
RE_B <= '1' when state = S4 else '0';
sign <= '1' when state = S6 else '0';
EnA <= '1' when state = S8 else '0';
Done <= '1' when state = S11 else '0'; 
EnPlus <= '1' when state = S8 else '0';
END R;

