Simulink model of the micromirror cell:
---------------------------------------

   * micromirror_ini.m  data for syslevel macromodel of the micromirror
   * sene.m             to evaluate the strain energy at the operating point (q1,q2,q3), uMKSV units
   * cap12.m            to evaluate the capacitance at the operating point (q1,q2,q3), uMKSV units
   * cap13.m
   * cap23.m

   * micromirror.mdl <-- work in progress

 dependencies: 
     
  * spoly_calc.m - this function is used to evaluate the strain energy and the capacities at the operating point (qx, qy, qz) (code from vhdl-ams model: transducer.vhd)


 ## uMKSV unit:

[length]   m-->um

[energy]   J-->pJ

[capa]     F-->pF

[force]    N-->uN

[pressure]Pa-->MPa

[current]  A-->pA

[mass]     kg

[damping coefficient] N*s/m=uN*s/um
