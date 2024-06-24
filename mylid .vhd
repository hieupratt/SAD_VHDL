LIBRARY ieee;
USE ieee.STD_logic_1164.all;

Package Mylib IS

-- counter
Component counter IS
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
End component;

-- memory block 
Component memory IS
GENERIC ( 
        M : Integer := 2;
        N : Integer := 2;
        DATA_WIDTH : integer := 8;
        Addr_WIDTH : integer := 8
    );
    Port (
        CLK  : in  STD_LOGIC;
        WE   : in  STD_LOGIC;
        RE   : in  STD_LOGIC;
        Din  : in  STD_LOGIC_VECTOR(DATA_WIDTH*N*M - 1 downto 0); 
        ADDR : in  STD_LOGIC_VECTOR(Addr_WIDTH - 1 downto 0);  
        Dout : out STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0)   
    );
End component;

-- Reg
Component Reg is
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
end component;

component datapath is
    generic (
        M : Integer := 2;
        N : Integer := 2;
        DATA_WIDTH : integer := 8;
        Addr_WIDTH : integer := 8
    );
    port (
        CLK, RS : in STD_LOGIC;
        
        Re_A, Re_B : in STD_LOGIC;
        DATA_A : in  std_logic_vector(N*M*DATA_WIDTH-1 downto 0);
        DATA_B : in  std_logic_vector(N*M*DATA_WIDTH-1 downto 0);
        DATA_Out : out std_logic_vector(DATA_WIDTH-1 downto 0);
        LD_i, LD_j : in STD_LOGIC;
        Eni, Enj, EnA,enPlus : in STD_LOGIC;
        Init, sign : in STD_LOGIC;
        zi, zj, A_gt_B : out STD_LOGIC
    );
end component;


component controller is
PORT (
        CLK : IN STD_LOGIC;
        RS : IN STD_LOGIC;
        Start : IN STD_LOGIC;
       
        Re_A, Re_B : out STD_LOGIC;
	LD_i, LD_j : out STD_LOGIC;
        Eni, Enj, EnA,Enplus : out STD_LOGIC;
        Init, sign : out STD_LOGIC;
        zi, zj, A_gt_B : in STD_LOGIC;
        Done : OUT STD_LOGIC
    );
end component;

component SAD is 
generic ( 
        M : Integer := 2;
        N : Integer := 2;
        DATA_WIDTH : integer := 8;
        Addr_WIDTH : integer := 8
    );
    port (
        CLK : in std_logic;
        RS : in std_logic;
        Start : in std_logic;
        DATA_A : in std_logic_vector(N*M*DATA_WIDTH-1 downto 0);
        DATA_B : in std_logic_vector(N*M*DATA_WIDTH-1 downto 0);
        DATA_Out : out std_logic_vector(DATA_WIDTH-1 downto 0);
        Done : out std_logic
    );
end component;
End Mylib;


