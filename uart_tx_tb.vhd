--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:08:33 02/26/2025
-- Design Name:   
-- Module Name:   D:/fpga lpcarm/Projects/P12_uart_tx/uart_tx_tb.vhd
-- Project Name:  P12_uart_tx
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: uart_tx
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY uart_tx_tb IS
END uart_tx_tb;
 
ARCHITECTURE behavior OF uart_tx_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT uart_tx
    PORT(
         clk : IN  std_logic;
         txdata : IN  std_logic_vector(7 downto 0);
         txen : IN  std_logic;
         bussy : OUT  std_logic;
         txd : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal txdata : std_logic_vector(7 downto 0) := (others => '0');
   signal txen : std_logic := '0';

 	--Outputs
   signal bussy : std_logic;
   signal txd : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: uart_tx PORT MAP (
          clk => clk,
          txdata => txdata,
          txen => txen,
          bussy => bussy,
          txd => txd
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      txdata <= conv_std_logic_vector(65,8);
		txen <='1';
		wait for 20 ns;
		txen<='0';
		wait for 2 ms;
		
		txdata <= x"EA";
		txen <='1';
		wait for 20 ns;
		txen<='0';
		wait for 2 ms;
		

      -- insert stimulus here 

      wait;
   end process;

END;
