-- =============================================================================
-- Model: testbench for transducer.vhd (micromirror_cell) in hAMSter
--
-- Author: Vladimir Kolchuzhin, LMGT, TU Chemnitz
-- <vladimir.kolchuzhin@etit.tu-chemnitz.de>
-- Date: 21.06.2011
-- =============================================================================
-- VHDL-AMS generated code from ANSYS ROM Tool for hAMSter:
--
--				initial.vhd
--				s_ams_130.vhd
--				ca12_ams_130.vhd
--				ca13_ams_130.vhd
--				ca23_ams_130.vhd
--				transducer.vhd
--
-- units: uMKSV
---------
--
-- Reference: Release 11.0 Documentation for ANSYS 
--            8.6. Sample Micro Mirror Analysis 
--
-- Geometrical parameters of cell:
----------------------------------
-- fe_la= 200                         ! Spring length
-- fe_br=  10                         ! Spring width
-- fe_di=  15                         ! Spring thickness
-- sp_la=1000                         ! Mirror length
-- sp_br= 250                         ! Mirror width
-- mi_la= 520                         ! Length center part
-- mi_br=  35                         ! Width center part
-- po_la=  80                         ! Length of anchor post
-- po_br=  80                         ! Width of anchor post
-- fr_br=  30                         ! Fringing field distance
-- d_ele=  20                         ! Electrode gap  
--
-- 
-- Solver parameters:
---------------------
-- Euler solver: time=1.5m; step=0.5 us
--
-- Load options:
----------------
-- use_pass=0 => external modal forces, uN; fm1_ext=km_1*q1_ext, => q1_ext=1.0 (mechanical test)
-- use_pass=1 => calculation of voltage displacement functions up to pull-in: voltage sweep
-- use_pass=2 => calculation of voltage displacement functions at multiple load steps
-- use_pass=3 => calculation of displacements at acting element loads
-- use_pass=4 => (prestressed) harmonic analysis -> chirp for harmonic response; +DFT
-- use_pass=5 => nonlinear transient analysis 
--------------------------------------------------------------------------------
-- use_pass=1:
-- transducer is driven by a voltage: electrical excitation - > mechanical response
-- The computed pull-in voltage is 
--									859 volts (ANSYS ROM144)
--									875 volts
--
--------------------------------------------------------------------------------
-- ID: testbench.vhd
--
-- Rev. 1.00 13.02.2015
-- Rev. 1.01 18.02.2015 mechanical test passed;
--
-- =============================================================================
library ieee;

use work.electromagnetic_system.all;
use work.all;

use ieee.math_real.all;

                
entity testbench is
end;

architecture behav of testbench is
  terminal struc1_ext,struc2_ext: translational; 					--
  terminal lagrange1_ext,lagrange2_ext,lagrange3_ext:translational; --
  terminal master1_ext,master2_ext,master3_ext:translational;		--
  terminal elec1_ext,elec2_ext,elec3_ext: electrical;				--

  -- Modal displacement
  quantity q1_ext across fm1_ext through struc1_ext;          -- modal amplitude 1
  quantity q2_ext across fm2_ext through struc2_ext;          -- modal amplitude 2
  -- Lagrangian multipler                                               
  quantity p1_ext across r1_ext  through lagrange1_ext;
  quantity p2_ext across r2_ext  through lagrange2_ext;
  quantity p3_ext across r3_ext  through lagrange3_ext;
  -- Nodal displacement
  quantity u1_ext across f1_ext  through master1_ext;
  quantity u2_ext across f2_ext  through master2_ext;
  quantity u3_ext across f3_ext  through master3_ext;
  -- Electrical ports
  quantity v1_ext across i1_ext  through elec1_ext;            -- conductor  1
  quantity v2_ext across i2_ext  through elec2_ext;            -- conductor  2
  quantity v3_ext across i3_ext  through elec3_ext;            -- conductor  3


  constant t_end:real:=1.5e-03;
  constant    dt:real:=0.5e-06;
  
  constant digital_delay:time:=0.5 us;          -- time step size for matrix update:  digital_delay=dt!

  constant el_load1:real:= 0.00;  -- scale factor for element load 1: 1.0==acceleration in Z-direction 9.8e6 m/s**2
  constant el_load2:real:= 0.00;  -- scale factor for element load 2: 1.0==uniform pressure load 1 MPa (-0.01==>10kPa)


  constant dc_value:real:=875.0; -- Vmax for voltage ramp/sweep
  constant ac_value:real:=  1.0;

	-- 1)  NL                     875
	-- 2) LIN               850...878
	-- 3)  NL el_load1= 1.00      875
	-- 4)  NL el_load2=-0.01      640

-- sweep parameters
  constant f_begin:real:=0.0;
  constant f_end:real:= 50.0e+03; -- n=100

-- saw_tooth parameters
  constant cycle_t:real:=500.0e-06; -- cycle time of one saw tooth 500us
  constant rise_t:real:=  50.0e-06; -- rise time
  constant fall_t:real:= 450.0e-06; -- fall time
  constant num_cyc:real:=  3.0;     -- number of cycles

  constant t1:real:= 225.0e-06; -- rise_t/2 225us
  constant t2:real:= 275.0e-06;
  constant t3:real:= 725.0e-06;
  constant t4:real:= 775.0e-06;
  constant t5:real:=1225.0e-06;
  constant t6:real:=1275.0e-06;
  constant t7:real:=1500.0e-06; -- TE=num_cyc*cycle_t

  constant v_max:real:=100.0;
--
-- ^ V
-- |
-- |   o               o               o  v_max
-- |  / \             / \             / \
-- | /   \           /   \           /   \
-- |/     \         /     \         /     \
-- x---+---x---+---x---+---x---+---x---+---x---+---x--------> time
-- |        \     /         \     /         \     /
-- |         \   /           \   /           \   /
-- |          \ /             \ /             \ /
-- |           o               o               o
--
-- t0  t1      t2      t3      t4      t5      t6  t7=TE
-------------------------------------------------------------------------------

  constant   use_pass:integer:=5; -- *** 0/1/2/3/4/5 ***

-- use_pass=0 => external modal forces, uN; fm1_ext=km_1*q1_ext, => q1_ext=1.0 (mechanical test)
-- use_pass=1 => calculation of voltage displacement functions up to pull-in: voltage sweep
-- use_pass=2 => calculation of voltage displacement functions at multiple load steps
-- use_pass=3 => calculation of displacements at acting element loads
-- use_pass=4 => (prestressed) harmonic analysis -> chirp for harmonic response; +DFT
-- use_pass=5 => nonlinear transient analysis 

begin

-- Loads:

if  DOMAIN = quiescent_domain use
		v1_ext ==  0.0;
		v2_ext ==  0.0;
		v3_ext ==  0.0;

		fm1_ext == 0.0;      -- external modal force 1
		fm2_ext == 0.0;      -- external modal force 2
else


if use_pass = 0 use -- step
		v1_ext == 0.0;
		v2_ext == 0.0;
		v3_ext == 0.0;

		fm1_ext == 173.038;    -- external modal force 1, uN; fm1_ext=km_1*q1_ext, => q1_ext=1.0
		fm2_ext == 924.245;    -- external modal force 2, uN; fm2_ext=km_2*q2_ext, => q2_ext=1.0
end use;  

if use_pass = 1 use -- ramp/sweep
		v1_ext == 0.0;
		v2_ext == dc_value/t_end*now;
		v3_ext == 0.0;
		--i3_ext==0.0;

		fm1_ext == 0.0;      -- external modal force 1
		fm2_ext == 0.0;      -- external modal force 2
end use;  

if use_pass = 2 use
		v1_ext ==  220.0/t_end*now-110.0; -- sweep voltage at cond1: (-100...+110) volts
		v2_ext == +700.0;  		  -- fixed polarization voltage +800 volts
		v3_ext == -700.0;                 -- fixed polarization voltage -800 volts

		fm1_ext == 0.0;      -- external modal force 1
		fm2_ext == 0.0;      -- external modal force 2
end use;     

if use_pass = 3 use
	-- Please define the scale factors:
	-- el_load1 and el_load2
		v1_ext == 0.0;
		v2_ext == 0.0;
		v3_ext == 0.0;

		fm1_ext == 0.0;      -- external modal force 1
		fm2_ext == 0.0;      -- external modal force 2
end use;

if use_pass = 4 use
	--
	if now <= 4.0*dt use
		v2_ext==+100.0*(now/dt/4.0);
		v3_ext==-100.0*(now/dt/4.0);
	end use;

	if now > 4.0*dt use
		v2_ext == +100.0;
		v3_ext == -100.0;
	end use;
		v1_ext == ac_value*sin(2.0*3.14*(f_begin + (f_end-f_begin)/t_end*now) * now);
		fm1_ext == 0.0;      -- external modal force 1
		fm2_ext == 0.0;      -- external modal force 2
end use;

if use_pass = 5 use
	if now <= t1 use
		v1_ext==(v_max*(now/t1));  
		--v2_ext== 400.0;
		--v3_ext==-400.0;
		v2_ext==+400.0*(now/t1);
		v3_ext==-400.0*(now/t1);
	end use;

	if now > t1  and now <= t2 use
		v1_ext==(-2.0*v_max*((now-t1)/rise_t)+v_max);
		v2_ext== 400.0;
		v3_ext==-400.0;
	end use;

	if now > t2 and now <=t3 use
		v1_ext==(+2.0*v_max*((now-t2)/fall_t)-v_max);
		v2_ext== 400.0;
		v3_ext==-400.0;
	end use;

	if now > t3 and now <= t4 use
		v1_ext==(-2.0*v_max*((now-t3)/rise_t)+v_max);
		v2_ext== 400.0;
		v3_ext==-400.0;
	end use;

	if now > t4 and now <= t5 use
		v1_ext==(+2.0*v_max*((now-t4)/fall_t)-v_max);
		v2_ext== 400.0;
		v3_ext==-400.0;
	end use;

	if now > t5 and now <= t6 use
		v1_ext==(-2.0*v_max*((now-t5)/rise_t)+v_max);
		v2_ext== 400.0;
		v3_ext==-400.0;
	end use;

	if now > t6 use
		v1_ext==(+2.0*v_max*((now-t6)/fall_t)-v_max);
		v2_ext== 400.0;
		v3_ext==-400.0;
	end use;

		fm1_ext == 0.0;      -- external modal force 1
		fm2_ext == 0.0;      -- external modal force 2 
end use;

end use;
----------------------------------
r1_ext==0.0;       -- must be zero
r2_ext==0.0;       -- must be zero
r3_ext==0.0;       -- must be zero

f1_ext==0.0;       -- external nodal force on master node 1
f2_ext==0.0;       -- external nodal force on master node 2
f3_ext==0.0;       -- external nodal force on master node 3
-------------------------------------------------------------------------------
--
--                              Lagrangian ports
--
--                                     -<<- r_ext2=0
--                               p1   p2   p3
--                 r_ext1=0 ->>- o    o    o -<<- r_ext3=0
--                               |    |    |
--         modal ports   o-------o----o----o-------o     nodal ports
--                       |                         | 
-- fm_ext1=0 ->>- q1 o---o                         o---o u1 -<<- f_ext1=0
--                       |                         |
-- fm_ext2=0 ->>- q2 o---o component1:  transducer o---o u2 -<<- f_ext2=0
--                       |                         |  
--                       |                         o---o u3 -<<- f_ext3=0  
--                       |                         |
--                       o-------o----o----o-------o
--                               |    |    |
--                        v1_ext o    o    o v3_ext
--                      input:      v2_ext
--                              
--                             electrical ports
--
-- ASCII-Schematic of the transducer-component 


--component1:		entity micromirror(behav)
component1:		entity transducer(behav)
 	       generic map (digital_delay,el_load1,el_load2)
	          port map (struc1_ext,struc2_ext,
                        lagrange1_ext,lagrange2_ext,lagrange3_ext,
                        master1_ext,master2_ext,master3_ext,
                        elec1_ext,elec2_ext,elec3_ext);
end;
-- =============================================================================
