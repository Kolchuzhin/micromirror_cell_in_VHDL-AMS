System Level Model of micromirror cell in VHDL-AMS generated by ANSYS ROM Tool
==============================================================================

![micromirror](https://user-images.githubusercontent.com/5137813/132745360-81275711-359b-4739-8dd0-8121eef9f312.png)

The goal of this project is to popularize of Mode Superposition based Reduced Order Modeling technique for MEMS simulations.

Tutorial:
---------
Kolchuzhin, Vladimir and Mehner, Jan (2015, June 30). System level modeling of the micromirror cell. Zenodo. 10.5281/zenodo.19153

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19153.svg)](https://doi.org/10.5281/zenodo.19153)

Simplorer model:
----------------

coming soon ...

Simulink Model:
---------------
  Simulink model of the micromirror cell:
  
   * micromirror_ini.m
   * sene.m
   * cap12.m
   * cap13.m
   * cap23.m
   * micromirror.mdl (in progress)
   
   https://github.com/Kolchuzhin/micromirror_cell_in_VHDL-AMS/blob/master/Simulink_model/readme.md

Geometric model:
----------------
   * 2D layout of the micromiror cell in an SVG format.
   * The CAD geometry of the micromiror cell in an IGES format.

hAMSter model:
--------------
  The vhd-files have been compiled with hAMSter simulation system Version 2.0:
  
   * variant 1: "Original Model" with comments + testbench.vhd;
   * variant 2: micromirror.vhd (single file w/o packages);
   * variant 3: micromirror.vhd (w/o SIGNAL) in progress;

  Testbench:
  * Solver parameters: Euler solver, time=1.5m, step=0.5 us
  * Load options:
    - use_pass=0 => external modal forces, uN; fm1_ext=km_1*q1_ext, => q1_ext=1.0 (mechanical test)
    - use_pass=1 => calculation of voltage displacement functions up to pull-in: voltage sweep
    - use_pass=2 => calculation of voltage displacement functions at multiple load steps
    - use_pass=3 => calculation of displacements at acting element loads
    - use_pass=4 => (prestressed) harmonic analysis -> chirp for harmonic response; + DFT (external)
    - use_pass=5 => nonlinear transient analysis 
  
Original Model:
---------------
  Original Model of micromirror cell generated by ANSYS ROM Tool:
  
   * initial.vhd
   * ca12_ams_130.vhd
   * ca13_ams_130.vhd
   * ca23_ams_130.vhd
   * s_ams_130.vhd
   * transducer.vhd
