-------------------------------------------------------------------------------
-- Model: testbench for transducer.vhd (micromirror_cell) in hAMSter
--
-- Author: Vladimir Kolchuzhin, LMGT, TU Chemnitz
-- <vladimir.kolchuzhin@etit.tu-chemnitz.de>
-- Date: 21.06.2011
--
-- Library: VHDL-AMS generated code from ANSYS ROM Tool for hAMSter    
--
--				initial.vhd
--				s_ams_130.vhd
--				ca12_ams_130.vhd
--				ca13_ams_130.vhd
--				ca23_ams_130.vhd
--				transducer.vhd
--
-- uMKSV  units  
--
-- Reference: Release 11.0 Documentation for ANSYS 
--            8.6. Sample Micro Mirror Analysis
--
--
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
--
-- Euler solver: time=0.2m; step=0.4u
--
--
--					0. mechanical test: fm1_ext=km_1*q1_ext
--					1. sweep computing the pull-in voltage
--					2. 
--					3.
--					4. chirp for harmonic response
--					5.  
--
-- The computed pull-in voltage is 859 volts (ANSYS ROM144)
-- electrical excitation - > mechanical response
-- transducer is driven by a voltage
-------------------------------------------------------------------------------
-- ID: testbench_pi.vhd
-- ver. 1.0  13.02.2015
-- ver. 1.01 18.02.2015 mechanical test passed
-------------------------------------------------------------------------------
use work.electromagnetic_system.all;
use work.all;
library ieee;

use ieee.math_real.all;
                
entity testbench is
end;

architecture behav of testbench is
  terminal struc1_ext,struc2_ext: translational; 		    --
  terminal lagrange1_ext,lagrange2_ext,lagrange3_ext:translational; --
  terminal master1_ext,master2_ext,master3_ext:translational;	    --
  terminal elec1_ext,elec2_ext,elec3_ext: electrical;		    --

  -- Modal displacement
  quantity q1_ext across fm1_ext through struc1_ext;          -- modal amplitude 1
  quantity q2_ext across fm2_ext through struc2_ext;          -- modal amplitude 2
  -- Lagrangian multipler                                               
  quantity p1_ext across r1_ext  through lagrange1_ext;
  quantity p2_ext across r2_ext  through lagrange2_ext;
  quantity p3_ext across r3_ext  through lagrange3_ext;
  -- Nodal displacement
  quantity u1_ext across f1_ext  through master1_ext;
  quantity u2_ext across f2_ext  through master1_ext;
  quantity u3_ext across f3_ext  through master1_ext;
  -- Electrical ports
  quantity v1_ext across i1_ext  through elec1_ext;            -- conductor voltage 1
  quantity v2_ext across i2_ext  through elec2_ext;            -- conductor voltage 2
  quantity v3_ext across i3_ext  through elec3_ext;            -- conductor voltage 3

  constant t_end:real:=0.2e-03;
  constant    dt:real:=0.4e-06;
  constant ac_value:real:=10.0;
  constant dc_value:real:=930.0;

  constant f_begin:real:=1.0;
  constant f_end:real:=5.0e+03;

  constant digital_delay:time:=0.4 us;          -- time step size for matrix update:  dt

  constant el_load1:real:=0.0;	-- element load 1 (scale factor): acceleration in Z-direction 9.8e6 m/s**2
  constant el_load2:real:=0.0;  -- element load 2 (scale factor): uniform pressure load 1 MPa


  constant   key_load:integer:=1; -- 0/1/2/3/4/5 == ramp/chirp/puls  

-- key_load=0 => calculation of voltage displacement functions up to pull-in
-- key_load=1 => calculation of voltage displacement functions up to pull-in
-- key_load=2 => calculation of voltage displacement functions at multiple load steps
-- key_load=3 => calculation of displacements at acting element loads
-- key_load=4 => prestressed harmonic analysis
-- key_load=5 => nonlinear transient analysis
                                     
begin

-- Loads:

if key_load = 0 use -- step
    v1_ext == 0.0;
    v2_ext == 0.0;
    v3_ext == 0.0;

  	fm1_ext == 173.038;    -- external modal force 1, uN; fm1_ext=km_1*q1_ext, => q1_ext=1.0
	fm2_ext == 924.245;    -- external modal force 2, uN
end use;  

if key_load = 1 use -- ramp/sweep
    v1_ext == 0.0;
    v2_ext == dc_value/t_end*now;
	--v3_ext == 0.0;
	i3_ext==0.0;

	fm1_ext == 0.0;      -- external modal force 1
	fm2_ext == 0.0;      -- external modal force 2
end use;  

if key_load = 2 use
    v1_ext == 5.0/t_end*now-110.0; -- sweep voltage at cond1
    v2_ext == +800.0; 			   -- fixed polarization voltage
    v3_ext == -800.0;              -- fixed polarization voltage

	fm1_ext == 0.0;      -- external modal force 1
	fm2_ext == 0.0;      -- external modal force 2
end use;     

if key_load = 3 use
    v1_ext == 0.0;
    v2_ext == dc_value/t_end*now;
    v3_ext == 0.0;

	fm1_ext == 0.0;      -- external modal force 1
	fm2_ext == 0.0;      -- external modal force 2
end use;

if key_load = 4 use
    v1_ext == 0.0;
    v2_ext == dc_value*0.1 + ac_value*sin(2.0*3.14*(f_begin + (f_end-f_begin)/t_end*now) * now);
    v3_ext == 0.0;

	fm1_ext == 0.0;      -- external modal force 1
	fm2_ext == 0.0;      -- external modal force 2
end use;

if key_load = 5 use
    v1_ext == 0.0;
    v2_ext == dc_value/t_end*now;
    v3_ext == 0.0;

	fm1_ext == 0.0;      -- external modal force 1
	fm2_ext == 0.0;      -- external modal force 2
end use;
-------------------------------------------------------------------------------
-- BCs:

r1_ext==0.0;       -- must be zero
r2_ext==0.0;       -- must be zero
r3_ext==0.0;       -- must be zero

f1_ext==0.0;       -- external nodal force on master node 1
f2_ext==0.0;       -- external nodal force on master node 2
f3_ext==0.0;       -- external nodal force on master node 3
-------------------------------------------------------------------------------
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
--                               o    o    o v3_ext=0
--                      input: v1_ext v2_ext=0
--                              
--                             electrical ports
--
-- ASCII-Schematic of the transducer-component 

component1:	entity transducer(behav)
 	       generic map (digital_delay, el_load1, el_load2)
	          port map (struc1_ext,struc2_ext,
                            lagrange1_ext,lagrange2_ext,lagrange3_ext,
                            master1_ext,master2_ext,master3_ext,
                            elec1_ext,elec2_ext,elec3_ext);
end;
-------------------------------------------------------------------------------
