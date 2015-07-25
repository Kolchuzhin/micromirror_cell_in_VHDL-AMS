function [fwv, dfwvx, dfwvy, dfwvz]=spoly_calc(qx, qy, qz,...
                                      s_type, s_inve, s_ord, s_fak, s_data)
%=========================================================================%
% PURPOSE:
%
% This function is used to evaluate the strain energy and the capacities 
% at the operating point (qx, qy, qz). 
%
% INPUT:
%           qx, qy, qz, s_type, s_inve, s_ord, s_fak, s_data
%
%           4 polynomial types:
%                   s_type=1 ==> Lagrange 
%                   s_type=2 ==> Pascal 
%                   s_type=3 ==> Reduced Lagrange 
%                   s_type=4 ==> Reduced Pascal
%
% OUTPUT: 
% Results are the function value itself and the first derivatives 
% with respect to the modal coordinates(qx, qy, qz)
%           fwv         function
%           dfwvx       df/dx
%           dfwvy       df/dy
%           dfwvz       df/dz
%-------------------------------------------------------------------------%
% Kolchuzhin V.A., LMGT, TU Chemnitz, 06.02.2009 22:06
% <vladimir.kolchuzhin@etit.tu-chemnitz.de>
% 26.11.2009 11:01 spoly_calc (VHDL-AMS function)
%
%=========================================================================%
if nargin==0 % test data
    %qx, qy, qz, 
    %s_type, s_inve, s_ord, s_fak, s_data

qx=0.0;
qy=0.0; 
qz=0.0;

s_type=1;
s_inve=2;
s_ord=[6.0, 6.0, 0.0];
s_fak=[0.284900000000, 2.37940000000, 0.00000000000, 122.297526943];

s_data=[...
  0.713592723584    
  0.308112039780    
 -0.632902507786E-01
  0.183048631880E-01
 -0.900145835780E-02
  0.308680644043E-01
 -0.220826756899E-01
  0.168352344167E-01
  0.155818676961E-01
 -0.120231198213E-01
 -0.265957065384E-02
  0.261151957951E-02
  0.284133219400E-01
 -0.237679143635E-01
 -0.269223266971E-02
  0.298339734745E-02
 -0.285000993353E-02
 -0.629556516254E-02
  0.641020742302E-02
  0.181522177493E-01
 -0.171904589607E-01
 -0.143823450360E-04
  0.361120579627E-03
 -0.395962097128E-03
 -0.263893482804E-02
  0.214183173210E-02
  0.638300794597E-02
 -0.579317137128E-02
 -0.222223018018E-04
  0.120256398141E-03
  0.535468006816E-03
 -0.107405314407E-02
 -0.231385251996E-02
  0.174075433080E-02
  0.985743437558E-03
 -0.170764753980E-05
  0.354761967933E-03
 -0.383421969712E-03
 -0.396134431136E-02
  0.400062225823E-02
  0.707460187945E-02
 -0.710668468100E-02
  0.142946329261E-04
  0.252621411358E-03
 -0.801051099802E-03
 -0.272896732082E-02
  0.517088052195E-02
  0.535247030059E-02
 -0.723768810077E-02
];

%fwv   = 0.0115
%dfwvx =-0.0014
%dfwvy =-6.4323e-004
%dfwvz = 0

end
%=========================================================================%
%function spoly_calc(qx, qy, qz: in real:=0.0; s_type,s_inve: integer:=0;
%                    s_ord, s_fak, s_data:real_vector) return ret_type is

%     constant Sx:integer:=integer(s_ord(1))+1;
%     constant Sy:integer:=integer(s_ord(2))+1;
%     constant Sz:integer:=integer(s_ord(3))+1;
%     variable fwx:real_vector(1 to Sx):=(others=>0.0);
%     variable fwy:real_vector(1 to 1):=(others=>0.0);
%     variable fwz:real_vector(1 to 1):=(others=>0.0);
%     variable dfwx:real_vector(1 to Sx):=(others=>0.0);
%     variable dfwy:real_vector(1 to 1):=(others=>0.0);
%     variable dfwz:real_vector(1 to 1):=(others=>0.0);
%     variable res_val:ret_type:=(others=>0.0);
%     variable fwv,dfwvx,dfwvy,dfwvz,fak2:real:=0.0;
%     variable Px_s,Py_s,Px,Py,Lx,Ly,Lz,ii:integer:=0;

fwv=0.0;
dfwx=0.0;
dfwy=0.0;
dfwz=0.0;
dfwvx=0.0;
dfwvy=0.0;
dfwvz=0.0;
             
Sx=(s_ord(1))+1; % integer
Sy=(s_ord(2))+1;
Sz=(s_ord(3))+1;

%  begin 
     Lx=(s_ord(1)); % integer
     Ly=(s_ord(2));
     Lz=(s_ord(3));
     
     for i=1:Lx+1 
       fwx(i)=qx^(i-1)*s_fak(1)^(i-1);
       if i==2 dfwx(i)=s_fak(1)^(i-1); end
       if i >2 dfwx(i)=(i-1)*qx^(i-2)*s_fak(1)^(i-1); end
     end
     for i=1:Ly+1
       fwy(i)=qy^(i-1)*s_fak(2)^(i-1);
      if i==2 dfwy(i)=s_fak(2)^(i-1); end
      if i >2 dfwy(i)=(i-1)*qy^(i-2)*s_fak(2)^(i-1); end
     end
     for i=1:Lz+1
       fwz(i)=qz^(i-1)*s_fak(3)^(i-1);
      if i==2 dfwz(i)=s_fak(3)^(i-1); end
      if i >2 dfwz(i)=(i-1)*qz^(i-2)*s_fak(3)^(i-1); end
     end
%=========================================================================%
     if s_type==1
       ii=1;
       for zi=0:Lz
         for yi=0:Ly
           for xi=0:Lx
             fwv=fwv+s_data(ii)*fwx(xi+1)*fwy(yi+1)*fwz(zi+1);
             dfwvx=dfwvx+s_data(ii)*dfwx(xi+1)*fwy(yi+1)*fwz(zi+1);
             dfwvy=dfwvy+s_data(ii)*fwx(xi+1)*dfwy(yi+1)*fwz(zi+1);
             dfwvz=dfwvz+s_data(ii)*fwx(xi+1)*fwy(yi+1)*dfwz(zi+1);
             ii=ii+1;
           end
         end
       end
     end
%-------------------------------------------------------------------------%
     if s_type==2
       ii=1;
       Px_s=(s_ord(1));
       Py_s=(s_ord(2));
       for zi=0:Lz
         Px=Px_s-zi;
         Py=Py_s;
         for yi=0:Py
           for xi=0:Px
             fwv=fwv+s_data(ii)*fwx(xi+1)*fwy(yi+1)*fwz(zi+1);
             dfwvx=dfwvx+s_data(ii)*dfwx(xi+1)*fwy(yi+1)*fwz(zi+1);
             dfwvy=dfwvy+s_data(ii)*fwx(xi+1)*dfwy(yi+1)*fwz(zi+1);
             dfwvz=dfwvz+s_data(ii)*fwx(xi+1)*fwy(yi+1)*dfwz(zi+1);
             ii=ii+1;
           end
           Px=Px-1;
         end
         Py=Py-1;
       end
     end
%-------------------------------------------------------------------------%
    if s_type==3
       ii=1;
       for yi=0:Ly
         for xi=0:Lx
           fwv=fwv+s_data(ii)*fwx(xi+1)*fwy(yi+1);
           dfwvx=dfwvx+s_data(ii)*dfwx(xi+1)*fwy(yi+1);
           dfwvy=dfwvy+s_data(ii)*fwx(xi+1)*dfwy(yi+1);
           dfwvz=dfwvz+0.0;
           ii=ii+1;
         end
       end
      for zi=1:Lz
         for xi=0:Lx
           fwv=fwv+s_data(ii)*fwx(xi+1)*fwz(zi+1);
           dfwvx=dfwvx+s_data(ii)*dfwx(xi+1)*fwz(zi+1);
           dfwvy=dfwvy+0.0;
           dfwvz=dfwvz+s_data(ii)*fwx(xi+1)*dfwz(zi+1);
           ii=ii+1;
         end
       end
       for zi=1:Lz
         for yi=1:Ly
           fwv=fwv+s_data(ii)*fwy(yi+1)*fwz(zi+1);
           dfwvx=dfwvx+0.0;
           dfwvy=dfwvy+s_data(ii)*dfwy(yi+1)*fwz(zi+1);
           dfwvz=dfwvz+s_data(ii)*fwy(yi+1)*dfwz(zi+1);
           ii=ii+1;
         end
       end
     end
%-------------------------------------------------------------------------%
     if s_type==4
       ii=1;
       Px=integer(s_ord(1));
       Py=integer(s_ord(2));
       for yi=0:Py
         for xi=0:Px
           fwv=fwv+s_data(ii)*fwx(xi+1)*fwy(yi+1);
           dfwvx=dfwvx+s_data(ii)*dfwx(xi+1)*fwy(yi+1);
           dfwvy=dfwvy+s_data(ii)*fwx(xi+1)*dfwy(yi+1);
           dfwvz=dfwvz+0.0;
           ii=ii+1;
         end
         Px=Px-1;
       end
       Px=integer(s_ord(1));
       for zi=1:Lz
         for xi=0:Px-1
           fwv=fwv+s_data(ii)*fwx(xi+1)*fwz(zi+1);
           dfwvx=dfwvx+s_data(ii)*dfwx(xi+1)*fwz(zi+1);
           dfwvy=dfwvy+0.0;
           dfwvz=dfwvz+s_data(ii)*fwx(xi+1)*dfwz(zi+1);
           ii=ii+1;
         end
         Px=Px-1;
       end
       for zi=1:Lz-1
         for yi=1:Py-1
           fwv=fwv+s_data(ii)*fwy(yi+1)*fwz(zi+1);
           dfwvx=dfwvx+0.0;
           dfwvy=dfwvy+s_data(ii)*dfwy(yi+1)*fwz(zi+1);
           dfwvz=dfwvz+s_data(ii)*fwy(yi+1)*dfwz(zi+1);
           ii=ii+1;
         end
         Py=Py-1;
       end
     end
%-------------------------------------------------------------------------%
     if s_inve==1
       fwv=fwv*s_fak(4);
       dfwvx=dfwvx*s_fak(4);
       dfwvy=dfwvy*s_fak(4);
       dfwvz=dfwvz*s_fak(4);
     else
       fak2=1.0/s_fak(4);
       dfwvx=-dfwvx/(fwv^2);
       dfwvy=-dfwvy/(fwv^2);
       dfwvz=-dfwvz/(fwv^2);
       fwv=1.0/fwv;
       fwv=fwv*fak2;
       dfwvx=dfwvx*fak2;
       dfwvy=dfwvy*fak2;
       dfwvz=dfwvz*fak2;
     end     
%-------------------------------------------------------------------------%
%      res_val=(fwv, dfwvx, dfwvy, dfwvz);
%      return res_val;
%end spoly_calc;
%=========================================================================%
return
