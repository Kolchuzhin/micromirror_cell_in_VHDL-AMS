package initial is

constant mm_1:real:=  0.288058870532E-08; -- modal mass for mode 1
constant dm_1:real:=  0.706010261432E-04; -- modal damping constant for mode 1
constant mm_2:real:=  0.653087233995E-08; -- modal mass for mode 2
constant dm_2:real:=  0.245685234375E-03; -- modal damping constant for mode 2

-- eigenvector at master node 1
constant fi1_1:real:=  0.997970744648    ; -- eigenvector mode 1 at master node 1
constant fi1_2:real:=  0.999999999731    ; -- eigenvector mode 2 at master node 1
-- eigenvector at master node 2
constant fi2_1:real:=  0.569280444689E-10;
constant fi2_2:real:=  0.996567701520    ;
-- eigenvector at master node 3
constant fi3_1:real:= -0.803900764657    ;
constant fi3_2:real:=  0.953682688426    ;

-- element loads
-- acceleration in z-direction 9.8e6 m/s**2
constant el1_1:real:= -0.211089068271E-11; -- element load 1 mode 1
constant el1_2:real:= -0.706066545973E-01; -- element load 1 mode 2
-- uniform 1 MPa pressure load 
constant el2_1:real:=   60748.3863376    ; -- element load 2 mode 1
constant el2_2:real:=   103011.432553    ; -- element load 2 mode 2 

end;
