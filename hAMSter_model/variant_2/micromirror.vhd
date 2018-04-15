--*****************************************************************************
--*****************************************************************************
-- Model: micromirror_cell in hAMSter
--
-- Author: Vladimir Kolchuzhin, LMGT, TU Chemnitz
-- <vladimir.kolchuzhin@ieee.org>
-- Date: 21.06.2011
-------------------------------------------------------------------------------
-- VHDL-AMS generated code from ANSYS for hAMSter:
--				initial.vhd
--				s_ams_130.vhd
--				ca12_ams_130.vhd
--				ca13_ams_130.vhd
--				ca23_ams_130.vhd
--				transducer.vhd	==>  micromirror.vhd (single file w/o packages)
-------------------------------------------------------------------------------
-- Reference: Release 11.0 Documentation for ANSYS 
-- 8.6. Sample Micro Mirror Analysis 
--
-- units: uMKSV
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
--     o--------------------o
--     |                    |
--     |                    |
--     o-----o        o-----o
--  o========|        |========o
--     o-----o        o-----o           ^ y
--     |                    |           |
--     |                    |           |
--     o--------------------o           o------>  x
--
-- ASCII-Schematic of the micromirror-component


-- Material properties <110> Si
-- MP,EX,1,169e3			!
-- MP,NUXY,1,0.066			!
-- MP,DENS,1,2.329e-15		!
-- MP,ALPX,1,1e-6			!
--
-- ROM model status:
-- number of basis functions = 2; 2 modes: i=1, j=3, k=0
-- 3 conductors => 3 capacitance C12, C13, C23
-- 3 master nodes
--
-------------------------------------------------------------------------------
-- Euler solver: time=1.5m; step=0.5 us
-------------------------------------------------------------------------------
-- ID: micromirror.vhd

-- Rev. 1.01 18.02.2015  single file w/o packages: 

--*****************************************************************************
--*****************************************************************************
package electromagnetic_system is

    nature electrical is real across real through electrical_ground reference;
    nature translational is real across real through mechanical_ground reference;

end package electromagnetic_system;


use work.electromagnetic_system.all;


entity micromirror is
  generic (delay:time; el_load1, el_load2:real);
  port (terminal struc1,struc2:translational;
        terminal lagrange1,lagrange2,lagrange3:translational;
        terminal master1,master2,master3:translational;
        terminal elec1,elec2,elec3:electrical);
end;

architecture behav of micromirror is

  type ret_type is array(1 to 4) of real;

quantity q1 across fm1 through struc1;
quantity q2 across fm2 through struc2;
quantity p1 across r1 through lagrange1;
quantity p2 across r2 through lagrange2;
quantity p3 across r3 through lagrange3;
quantity u1 across f1 through master1;
quantity u2 across f2 through master2;
quantity u3 across f3 through master3;
quantity v1 across i1 through elec1;
quantity v2 across i2 through elec2;
quantity v3 across i3 through elec3;
-------------------------------------------------------------------------------------
-- model parameters from FE-simulations

constant fm_1:real:=  39008.0;	-- frequency of mode 1
constant fm_2:real:=  59873.0;	-- frequency of mode 2

constant mm_1:real:=  0.288058870532E-08;  -- modal mass for mode 1 --[]
constant mm_2:real:=  0.653087233995E-08;  -- modal mass for mode 2 --[]

-- modal damping factors (Q=10)
constant dm_1:real:=  0.706010261432E-04; -- modal damping constant for mode 1 --[|--
constant dm_2:real:=  0.245685234375E-03; -- modal damping constant for mode 2 --[|--

constant km_1:real:=  173.038;	-- stiffness of mode 1 --^^^--
constant km_2:real:=  924.245;	-- stiffness of mode 2 --^^^--

-- eigenvector at master node 1
constant fi1_1:real:=  0.997970744648    ; -- eigenvector mode 1 at master node 1
constant fi1_2:real:=  0.999999999731    ; -- eigenvector mode 2 at master node 1
-- eigenvector at master node 2
constant fi2_1:real:=  0.569280444689E-10; -- eigenvector mode 1 at master node 2
constant fi2_2:real:=  0.996567701520    ; -- eigenvector mode 2 at master node 2
-- eigenvector at master node 3
constant fi3_1:real:= -0.803900764657    ; -- eigenvector mode 1 at master node 3
constant fi3_2:real:=  0.953682688426    ; -- eigenvector mode 2 at master node 2

-- element load factors
-- acceleration in z-direction 9.8e6 m/s**2
constant el1_1:real:= -0.211089068271E-11; -- element load 1 mode 1
constant el1_2:real:= -0.706066545973E-01; -- element load 1 mode 2
-- uniform 1 MPa pressure load 
constant el2_1:real:=   60748.3863376    ; -- element load 2 mode 1
constant el2_2:real:=   103011.432553    ; -- element load 2 mode 2 
-------------------------------------------------------------------------------------
constant s_type130:integer:=1; -- type of fit function: Lagrange polynomial
constant s_inve130:integer:=1; -- not inverted
signal s_ord130:real_vector(1 to 3):=(4.0, 3.0, 0.0); -- order of polynomial
-- scale factors used for curve fit
signal s_fak130:real_vector(1 to 4):=(0.975294676147E-01, 0.220185632619, 0.0, 18627.65044);
constant s_anz130:integer:=       20;   -- total number of coefficients
signal s_data130:real_vector(1 to 20):= -- polynomial coefficients 
(-0.211963583064E-10,
  0.303852586068E-16,
  0.488293553651    ,
 -0.966803682459E-16,
 -0.289764466026E-10,
 -0.289421473806E-15,
 -0.591831967134E-11,
  0.126983139929E-14,
 -0.828445060518E-10,
 -0.985214016685E-15,
  0.511706446310    ,
 -0.711031743701E-16,
 -0.100354073641E-09,
  0.226237372945E-15,
 -0.847945860260E-10,
  0.321621459155E-15,
  0.467129041343E-09,
 -0.141110824345E-14,
 -0.103557104018E-09,
  0.109482536129E-14);
-------------------------------------------------------------------------------------
constant ca12_type130:integer:=1;
constant ca12_inve130:integer:=2;
signal ca12_ord130:real_vector(1 to 3):=(4.0, 3.0, 0.0);
signal ca12_fak130:real_vector(1 to 4):=(0.975294676147E-01, 0.220185632619, 0.0, 25.6028993526);
constant ca12_anz130:integer:=       20;
signal ca12_data130:real_vector(1 to 20):=
( 0.712086240885    ,
  0.186297166892    ,
 -0.208887154143E-01,
  0.531007092724E-02,
 -0.181480706895E-02,
  0.128558883926    ,
 -0.939139994662E-02,
  0.372136915760E-02,
 -0.259077537559E-02,
  0.104687708202E-02,
 -0.293936530550E-02,
  0.667614364241E-03,
 -0.506853279164E-03,
  0.113773216487E-02,
 -0.947577210652E-03,
  0.196412408079E-03,
  0.637444737511E-04,
 -0.129103797161E-03,
 -0.532315735795E-03,
  0.644951605279E-03);
-------------------------------------------------------------------------------------
constant ca13_type130:integer:=1;
constant ca13_inve130:integer:=2;
signal ca13_ord130:real_vector(1 to 3):=(4.0, 3.0, 0.0);
signal ca13_fak130:real_vector(1 to 4):=(0.975294676147E-01, 0.220185632619, 0.0, 25.6030000457);
constant ca13_anz130:integer:=       20;
signal ca13_data130:real_vector(1 to 20):=
( 0.712094286463    ,
 -0.186347802870    ,
 -0.209412180795E-01,
 -0.523557199207E-02,
 -0.178345484280E-02,
  0.128565735753    ,
  0.931339715905E-02,
  0.363612109234E-02,
  0.264112674223E-02,
  0.111307000174E-02,
 -0.294786738552E-02,
 -0.533796708169E-03,
 -0.463952089322E-03,
 -0.131455480646E-02,
 -0.989450152969E-03,
  0.190516958085E-03,
  0.124293432457E-04,
 -0.498349836548E-04,
  0.494604396684E-03,
  0.599958313911E-03);
-------------------------------------------------------------------------------------
constant ca23_type130:integer:=1;
constant ca23_inve130:integer:=2;
signal ca23_ord130:real_vector(1 to 3):=(4.0, 3.0, 0.0);
signal ca23_fak130:real_vector(1 to 4):=(0.975294676147E-01, 0.220185632619, 0.0, 4353.184903);
constant ca23_anz130:integer:=       20;
signal ca23_data130:real_vector(1 to 20):=
( 0.546111390319    ,
  0.295871790946E-03,
  0.879069075222E-02,
 -0.293891270388E-03,
 -0.641224996279E-03,
 -0.263461122282    ,
 -0.718573965052E-03,
 -0.864593553516E-03,
  0.173269568371E-02,
 -0.516914738996E-02,
  0.125610539761    ,
 -0.128446242254E-02,
  0.499953901998E-02,
  0.127235001362E-02,
 -0.131318972091E-02,
 -0.444623172071E-01,
  0.163315957039E-02,
 -0.909045625811E-02,
 -0.260866762118E-02,
  0.702268147666E-02);
-------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------
-- The following function us used to evaluate the strain energy and the capacities --
-- at the operating point. Results are the function value itself                   --
-- and the first derivatives with respect to the modal coordinates                 --
-------------------------------------------------------------------------------------
function spoly_calc(qx, qy, qz : in real:=0.0; s_type,s_inve : integer :=0;
                    s_ord, s_fak, s_data:real_vector) return ret_type is

    constant Sx:integer:=integer(s_ord(1))+1;
    constant Sy:integer:=integer(s_ord(2))+1;
    constant Sz:integer:=integer(s_ord(3))+1;
    variable fwx:real_vector(1 to Sx):=(others=>0.0);
    variable fwy:real_vector(1 to Sy):=(others=>0.0);
    variable fwz:real_vector(1 to 1):=(others=>0.0);
    variable dfwx:real_vector(1 to Sx):=(others=>0.0);
    variable dfwy:real_vector(1 to Sy):=(others=>0.0);
    variable dfwz:real_vector(1 to 1):=(others=>0.0);
    variable res_val:ret_type:=(others=>0.0);
    variable fwv,dfwvx,dfwvy,dfwvz,fak2:real:=0.0;
    variable Px_s,Py_s,Px,Py,Lx,Ly,Lz,ii:integer:=0;

  begin

     Lx:=integer(s_ord(1));
     Ly:=integer(s_ord(2));
     Lz:=integer(s_ord(3));

     for i in 1 to Lx+1 loop
       fwx(i):=qx**(i-1)*s_fak(1)**(i-1);
       if i=2 then
         dfwx(i):=s_fak(1)**(i-1);
       end if;
       if i>2 then
         dfwx(i):=real(i-1)*qx**(i-2)*s_fak(1)**(i-1);
       end if;
     end loop;
     for i in 1 to Ly+1 loop
       fwy(i):=qy**(i-1)*s_fak(2)**(i-1);
      if i=2 then
         dfwy(i):=s_fak(2)**(i-1);
       end if;
       if i>2 then
         dfwy(i):=real(i-1)*qy**(i-2)*s_fak(2)**(i-1);
       end if;
     end loop;
     for i in 1 to Lz+1 loop
       fwz(i):=qz**(i-1)*s_fak(3)**(i-1);
      if i=2 then
         dfwz(i):=s_fak(3)**(i-1);
       end if;
       if i>2 then
         dfwz(i):=real(i-1)*qz**(i-2)*s_fak(3)**(i-1);
       end if;
     end loop;

     if s_type=1 then -- Lagrange type
       ii:=1;
       for zi in 0 to Lz loop
         for yi in 0 to Ly loop
           for xi in 0 to Lx loop
             fwv:=fwv+s_data(ii)*fwx(xi+1)*fwy(yi+1)*fwz(zi+1);
             dfwvx:=dfwvx+s_data(ii)*dfwx(xi+1)*fwy(yi+1)*fwz(zi+1);
             dfwvy:=dfwvy+s_data(ii)*fwx(xi+1)*dfwy(yi+1)*fwz(zi+1);
             dfwvz:=dfwvz+s_data(ii)*fwx(xi+1)*fwy(yi+1)*dfwz(zi+1);
             ii:=ii+1;
           end loop;
         end loop;
       end loop;
     end if;

     if s_type=2 then
     end if;

     if s_type=3 then
     end if;

     if s_type=4 then
     end if;

     if s_inve=1 then
       fwv:=fwv*s_fak(4);
       dfwvx:=dfwvx*s_fak(4);
       dfwvy:=dfwvy*s_fak(4);
       dfwvz:=dfwvz*s_fak(4);
     else
       fak2:=1.0/s_fak(4);
       dfwvx:=-dfwvx/(fwv**2);
       dfwvy:=-dfwvy/(fwv**2);
       dfwvz:=-dfwvz/(fwv**2);
       fwv:=1.0/fwv;
       fwv:=fwv*fak2;
       dfwvx:=dfwvx*fak2;
       dfwvy:=dfwvy*fak2;
       dfwvz:=dfwvz*fak2;
     end if;

     res_val:=(fwv, dfwvx, dfwvy, dfwvz);
     return res_val;

  end spoly_calc;
-------------------------------------------------------------------------------------
--       end _spoly_calc_ function                                                 --
-------------------------------------------------------------------------------------


signal sene_130:ret_type;
signal ca12_130:ret_type;
signal ca13_130:ret_type;
signal ca23_130:ret_type;


begin

p1:process
begin
  sene_130<= spoly_calc(q1,q2,0.0,s_type130,s_inve130,s_ord130,s_fak130,s_data130);
  ca12_130<= spoly_calc(q1,q2,0.0,ca12_type130,ca12_inve130,ca12_ord130,ca12_fak130,ca12_data130);
  ca13_130<= spoly_calc(q1,q2,0.0,ca13_type130,ca13_inve130,ca13_ord130,ca13_fak130,ca13_data130);
  ca23_130<= spoly_calc(q1,q2,0.0,ca23_type130,ca23_inve130,ca23_ord130,ca23_fak130,ca23_data130);
  wait for delay;
end process;

break on sene_130(2),sene_130(3),sene_130(4),ca12_130(2),ca12_130(3),ca12_130(4),ca13_130(2),ca13_130(3),ca13_130(4),ca23_130(2),ca23_130(3),ca23_130(4);


-- The following lines describe the governing differential equation at each pin:

-- linear model in modal domain w/o electrostatic 
--fm1==mm_1*q1'dot'dot + dm_1*q1'dot + 173.038*q1;
--fm2==mm_2*q2'dot'dot + dm_2*q2'dot + 924.245*q2;

-- non-linear model in modal domain w/o electrostatic
--fm1==mm_1*q1'dot'dot + dm_1*q1'dot +sene_130(2);
--fm2==mm_2*q2'dot'dot + dm_2*q2'dot +sene_130(3);

fm1==mm_1*q1'dot'dot + dm_1*q1'dot +sene_130(2) -ca12_130(2)*(v1-v2)**2/2.0 -ca13_130(2)*(v1-v3)**2/2.0 -ca23_130(2)*(v2-v3)**2/2.0 +fi1_1*p1 +fi2_1*p2 +fi3_1*p3 -el1_1*el_load1 -el2_1*el_load2;
fm2==mm_2*q2'dot'dot + dm_2*q2'dot +sene_130(3) -ca12_130(3)*(v1-v2)**2/2.0 -ca13_130(3)*(v1-v3)**2/2.0 -ca23_130(3)*(v2-v3)**2/2.0 +fi1_2*p1 +fi2_2*p2 +fi3_2*p3 -el1_2*el_load1 -el2_2*el_load2;

r1==fi1_1*q1+fi1_2*q2-u1;
r2==fi2_1*q1+fi2_2*q2-u2;
r3==fi3_1*q1+fi3_2*q2-u3;
f1==-p1;
f2==-p2;
f3==-p3;
i1==+((v1-v2)*(ca12_130(2)*q1'dot+ca12_130(3)*q2'dot)+(v1'dot-v2'dot)*ca12_130(1))+((v1-v3)*(ca13_130(2)*q1'dot+ca13_130(3)*q2'dot)+(v1'dot-v3'dot)*ca13_130(1));
i2==-((v1-v2)*(ca12_130(2)*q1'dot+ca12_130(3)*q2'dot)+(v1'dot-v2'dot)*ca12_130(1))+((v2-v3)*(ca23_130(2)*q1'dot+ca23_130(3)*q2'dot)+(v2'dot-v3'dot)*ca23_130(1));
i3==-((v1-v3)*(ca13_130(2)*q1'dot+ca13_130(3)*q2'dot)+(v1'dot-v3'dot)*ca13_130(1))-((v2-v3)*(ca23_130(2)*q1'dot+ca23_130(3)*q2'dot)+(v2'dot-v3'dot)*ca23_130(1));

end;
