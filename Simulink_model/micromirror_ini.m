%=========================================================================%
% PURPOSE:
%           data for syslevel macromodel of the micromirror
%           micromirror_ini.m
%-------------------------------------------------------------------------%
% dependencies:
%
%	micromirror.mdl
%	micromirror_ini.m
%    sene.m
%   cap12.m
%   cap13.m
%	cap23.m
%       polynomial evaluating function:
%       spoly_calc.m (code from vhdl-ams model: transducer.vhd)
%
% uMKSV unit:
% [length]   m-->um
% [energy]   J-->pJ
% [capa]     F-->pF
% [force]    N-->uN
% [pressure]Pa-->MPa
% [current]  A-->pA
% [mass]     kg
% [damping coefficient] N*s/m=uN*s/um
%-------------------------------------------------------------------------%
% written by Kolchuzhin V.A., LMGT, TU Chemnitz, 25.01.2011 10:35
% <vladimir.kolchuzhin@etit.tu-chemnitz.de>
% 24.05.2011 *.vhd --> simulink
%=========================================================================%
clear all;

eps0_MKS  =8.854e-12; % [Free space permittivity]  F/m
eps0_uMKSV=8.854e-06; % [Free space permittivity] pF/um

%-------------------------------------------------------------------------%
% initial.vhd
%------------

mm_1=  0.288058870532E-08; %-- modal mass for mode 1
dm_1=  0.706010261432E-04; %-- modal damping constant for mode 1
mm_2=  0.653087233995E-08; %-- modal mass for mode 2
dm_2=  0.245685234375E-03; %-- modal damping constant for mode 2

%-- eigenvector at master node 1
fi1_1=  0.997970744648    ; %-- eigenvector mode 1 at master node 1
fi1_2=  0.999999999731    ; %-- eigenvector mode 2 at master node 1
%-- eigenvector at master node 2
fi2_1=  0.569280444689E-10; %-- eigenvector mode 1 at master node 2
fi2_2=  0.996567701520    ; %-- eigenvector mode 2 at master node 2
%-- eigenvector at master node 3
fi3_1= -0.803900764657    ; %-- eigenvector mode 1 at master node 3
fi3_2=  0.953682688426    ; %-- eigenvector mode 2 at master node 3

%-- element load vectors
%-- acceleration in z-direction 9.8e6 m/s**2
el1_1= -0.211089068271E-11; %-- element load 1 for mode 1
el1_2= -0.706066545973E-01; %-- element load 1 for mode 2
%-- uniform 1 MPa pressure load 
el2_1=   60748.3863376    ; %-- element load 2 for mode 1
el2_2=   103011.432553    ; %-- element load 2 for mode 2 
%-------------------------------------------------------------------------%
%  o------------------o
%  |        1         | plate
%  o------------------o
%
%  o-----o      o-----o
%  |  2  |      |  3  | electrodes
%  o-----o      o-----o

n_mode=2;   % modes number
n_node=3;   % master nodes number

mode=[1 3]; % eigenfrequency: 1 3 (Torsion mode and Transversal mode)

gap=20.0;    % electrode gap
area=200*20; % electrode area

% master nodes
%-------------
% mn1=node(0.0,125.0,7.5)     Upper node on center line
% mn2=node(0.0,0.0,7.5)       Middle node on center line
% mn3=node(169.0,-104.29,0.0) Lower node on center line ???

% up_edge    Node on the upper edge
% center_n   Node at plate center
% lo_edge    Node at the lower edge
%=========================================================================%
