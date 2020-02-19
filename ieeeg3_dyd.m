function [flag] = ieee3g_dyd(fileID,n,name,kv,id,mva,Tg,Tp,Uo,Uc,Pmax,...
    Pmin,Rperm,Rtemp,Tr,Tw,Kturb,Aturb,Bturb,Spare,db1,eps,db2,Gv1,Pgv1,...
    Gv2,Pgv2,Gv3,Pgv3,Gv4,Pgv4,Gv5,Pgv5,Gv6,Pgv6)
%ieee3g_dyd This function will write the PSLF ieee3g model to a dyd file.
%   fileID must be created before calling function.
%   All input arguments must be strings besides fileID.
%   flag=0 if complete, flag=1 if not complete 
%   Parameters:
%   Variable: Default Data:   Description:
% Tg	0.5	Gate	servo	time	constant,	sec.	
% Tp	0.03	Pilot	servo	valve	time	constant,	sec.
% Uo	0.1	Maximum	gate	opening	velocity,	p.u./sec.	
% Uc	-0.1	Maximum	gate	closing	velocity,	p.u./sec.	(<
% Pmax	1	Maximum	gate	opening,	p.u.	of	mwcap
% Pmin	0	Minimum	gate	opening,	p.u.	of	mwcap
% Rperm	0.05	Permanent	droop,	p.u.			
% Rtemp	0.5	Temporary	droop,	p.u.			
% Tr	12	Dashpot	time	constant,	sec.		
% Tw	2	Water	inertia	time	constant,	sec.	
% Kturb	1	Turbine	gain,	p.u.			
% Aturb	-1	Turbine	numerator	multiplier			
% Bturb	0.5	Turbine	denominator	multiplier			
% Spare	0	Unused	parameter				
% db1	0	Intentional	deadband	width,	Hz.		
% eps	0	Intentional	db	hysteresis,	Hz.		
% db2	0	Unintentional	deadband,	MW			
% Gv1	0	Nonlinear	gain	point	1,	p.u.	gv
% Pgv1	0	Nonlinear	gain	point	1,	p.u.	power
% Gv2	0	Nonlinear	gain	point	2,	p.u.	gv
% Pgv2	0	Nonlinear	gain	point	2,	p.u.	power
% Gv3	0	Nonlinear	gain	point	3,	p.u.	gv
% Pgv3	0	Nonlinear	gain	point	3,	p.u.	power
% Gv4	0	Nonlinear	gain	point	4,	p.u.	gv
% Pgv4	0	Nonlinear	gain	point	4,	p.u.	power
% Gv5	0	Nonlinear	gain	point	5,	p.u.	gv
% Pgv5	0	Nonlinear	gain	point	5,	p.u.	power
% Gv6	0	Nonlinear	gain	point	6,	p.u.	gv
% Pgv6	0	Nonlinear	gain	point	6,	p.u.	power

flag=1;
fprintf(fileID,'IEEEG3_GE     %s "%s" %s "%s" : #0 %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n',...
    n,name,kv,id,mva,Tg,Tp,Uo,Uc,Pmax,Pmin,Rperm,Rtemp,Tr,Tw,Kturb,Aturb,...
    Bturb,Spare,db1,eps,db2,Gv1,Pgv1,Gv2,Pgv2,Gv3,Pgv3,Gv4,Pgv4,Gv5,Pgv5,Gv6,Pgv6);
flag=0;
end