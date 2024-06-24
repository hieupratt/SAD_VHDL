library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Mylib.all;


entity Datapath is
    generic (
        M : Integer := 2;
        N : Integer := 2;
        DATA_WIDTH : integer := 8;
        Addr_WIDTH : integer := 8
    );
    port (
        CLK, RS : in STD_LOGIC;
        Re_A, Re_B : in STD_LOGIC;
        DATA_A : in std_logic_vector(N*M*DATA_WIDTH-1 downto 0);
        DATA_B : in std_logic_vector(N*M*DATA_WIDTH-1 downto 0);
        DATA_Out : out std_logic_vector(DATA_WIDTH-1 downto 0);
        LD_i, LD_j : in STD_LOGIC;
        Eni, Enj, EnA,EnPlus : in STD_LOGIC;
        Init, sign : in STD_LOGIC;
        zi, zj, A_gt_B : out STD_LOGIC
    );
end Datapath;

architecture R of Datapath is
    signal i, j : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) := (others => '0');
    signal addr : integer := -2;
    signal temp_i, temp_j: unsigned(DATA_WIDTH - 1 downto 0);
    signal diff : signed(DATA_WIDTH -1 downto 0);
    signal A_value : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0):= (others => '0');
    signal B_value : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0):= (others => '0');
    signal C_value : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0):= (others => '0');
    signal D : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) := (others => '0');
    signal Q : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) := (others => '0');
    signal output : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) := (others => '0');
begin
    -- bo dem i
    counter_i : entity work.counter
        generic map( 
            M,
            N,
            DATA_WIDTH,
            Addr_WIDTH 
        )
        port map(
            RS,
            CLK,
            LD_i,
            Eni,
            i
        );
    -- bo dem j
    counter_j : entity work.counter
        generic map( 
            M,
            N,
            DATA_WIDTH,
            Addr_WIDTH 
        )
        port map(
            RS,
            CLK,
            LD_j,
            Enj,
            j
        );
    -- so sanh i va j
    process(CLK,i,j)
    begin
        if rising_edge(CLK) then
	    -- do tin hieu zi duoc tinh sau khi i tang -> tinh zi truoc mot vong lap
            if to_integer(unsigned(i)) >= M-1 then
                zi <= '1';
            else
                zi <= '0';
            end if;
            if to_integer(unsigned(j)) >= N-1 then
                zj <= '1';
            else
                zj <= '0';
            
            end if;
        end if;
    end process;
    -- tinh dia chi
    process(j)
    begin
        -- doi i va j thanh dia chi
        temp_i <= unsigned(i);
        temp_j <= unsigned(j);
	-- do i va j van len duoc 2 trong 1 vai state truoc khi bi reset -> su dung addr nhu mot bo dem
	-- addr tinh nhu vay van dung vi dang duyet tung phan tu cua mang theo dung thu tu
        if (to_integer(temp_j) < N and to_integer(temp_i) < M) then
            addr <= addr + 1;
        end if;
        
    end process;

    -- lay gia tri tai vi tri addr cua mang a va b
    process(CLK)
    begin
        if rising_edge(CLK) then
            if Re_A = '1' then
                A_value <= DATA_A((addr+1)*DATA_WIDTH-1 downto addr*DATA_WIDTH);
            end if;
            if Re_B = '1' then
                B_value <= DATA_B((addr+1)*DATA_WIDTH-1 downto addr*DATA_WIDTH);
            end if;
        end if;
    end process;
    process(CLK)
    begin
        if rising_edge(CLK) then
            if A_value >= B_value then  -- so xem con nao to hon
		A_gt_B <= '1';
                C_value <= std_logic_vector(signed(A_value) - signed(B_value)); 
            else
		A_gt_B <= '0';
                C_value <=  std_logic_vector(signed(B_value) - signed(A_value));
            end if;
        end if;
    end process;
    regC : reg
    GENERIC map( 
        M ,
        N ,
        DATA_WIDTH ,
        Addr_WIDTH
    )
    Port map(
        RS,
        CLK ,
        EnA ,
        D ,
        Q 
    );
    process(CLK,addr)
    begin
        if rising_edge(CLK) then
            D <= std_logic_vector(unsigned(Q) + unsigned(C_value));
        end if;
    end process;
   
    Data_out <= Q;
end R;
