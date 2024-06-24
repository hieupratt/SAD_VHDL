library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity SAD is
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
end SAD;

architecture R of SAD is
    -- Khai báo các tin hieu
    signal LD_i, LD_j : std_logic;
    signal Eni, Enj,EnA,EnPlus : std_logic;
    signal Init, sign : std_logic;
    signal zi, zj, A_gt_B : std_logic;
    signal Re_A, Re_B:std_logic;
    
begin

    -- K?t n?i entity Datapath
    datapath_inst: entity work.Datapath
        generic map (
            M => M,
            N => N,
            DATA_WIDTH => DATA_WIDTH,
            Addr_WIDTH => Addr_WIDTH
        )
        port map (
            CLK => CLK,
            RS => RS,
            Re_A => Re_A,
            Re_B => Re_B,
            DATA_A => DATA_A,
            DATA_B => DATA_B,
            DATA_Out => DATA_Out,
            LD_i => LD_i,
            LD_j => LD_j,
            Eni => Eni,
            Enj => Enj,
            EnA => EnA,
	    Enplus => Enplus,
            Init => Init,
            sign => sign,
            zi => zi,
            zj => zj,
            A_gt_B => A_gt_B
        );

  
    controller_inst: entity work.controller
        port map (
            CLK => CLK,
            RS => RS,
            Start => Start,
            Re_A => Re_A,
            Re_B => Re_B,
            LD_i => LD_i,
            LD_j => LD_j,
            Eni => Eni,
            Enj => Enj,
            EnA => EnA,
	    Enplus => Enplus,
            Init => Init,
            sign => sign,
            zi => zi,
            zj => zj,
            A_gt_B => A_gt_B,
            Done => Done
        );

end R;

