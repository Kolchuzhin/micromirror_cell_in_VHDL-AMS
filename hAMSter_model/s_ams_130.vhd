package s_dat_130 is

constant s_type130:integer:=1; -- type of fit function: Lagrange polynomial
constant s_inve130:integer:=1; -- not inverted
signal s_ord130:real_vector(1 to 3):=(4.0, 3.0, 0.0); -- order of polynomial
-- scale factors used for curve fit
signal s_fak130:real_vector(1 to 4):=(0.975294676147E-01, 0.220185632619, 0.00000000000, 18627.6504400);
constant s_anz130:integer:=       20; -- total number of coefficients
signal s_data130:real_vector(1 to 20):=
(-- polynomial coefficients 
 -0.211963583064E-10,
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
  0.109482536129E-14
);

end;
