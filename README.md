# FPGA-VHDL-uart-transmitter
--The designed code is for a UART Transmitter with Baud-rate=9600 and cpu clock=50 MHz
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Alireza Eskandari
-- 
-- Create Date:    13:53:16 02/24/2025 
-- Design Name:   UART Transmitter
-- Module Name:    uart_tx - Behavioral 
-- Project Name: 
-- Target Devices:  xc3s4004pq208 - xilinx fpga
-- Tool versions:   Xilinx ISE: p20131013
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_tx is
    Port ( clk : in  STD_LOGIC;
           txdata : in  STD_LOGIC_VECTOR (7 downto 0);
           txen : in  STD_LOGIC;
           bussy : out  STD_LOGIC;
           txd : out  STD_LOGIC);
end uart_tx;

architecture Behavioral of uart_tx is

type state_type is (idle,start,data,stop);
signal state:state_type:=idle;
signal buff_tx:std_logic_vector(7 downto 0);
signal cnt:integer range 0 to 5207:=0;
signal i:integer range 0 to 7:=0;
begin

process(clk)
	begin
	if(rising_edge(clk))then
		case state is
			when idle=>
				txd<='1';
				bussy<='0';
				if(txen='1')then
					state<=start;
					bussy<='1';
					buff_tx<=txdata;
				end if;
				
			when start=>
				txd<='0';
				cnt<=cnt+1;
				if(cnt=5207)then
					cnt<=0;
					i<=0;
					state<=data;
				end if;
				
			when data=>
				txd<=buff_tx(i);
				cnt<=cnt+1;
				if(cnt=5207)then
					cnt<=0;
					i<=i+1;
					if(i=7)then
						state<=stop;
					end if;
				end if;
				
			when stop=>
				txd<='1';
				cnt<=cnt+1;
				if(cnt=5207)then
					cnt<=0;
					state<=idle;
				end if;
		end case;
	end if;
end process;
end Behavioral;


