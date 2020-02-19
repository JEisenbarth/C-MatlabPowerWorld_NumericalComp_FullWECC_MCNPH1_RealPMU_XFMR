function [flag] = pss1a_dyd(fileID,n,name,kv,id,J,k,A1,A2,T1,T2,T3,T4,T5,...
    T6,Ks,Vrmax,Vrmin,Vcu,Vcl)
%pss1a_dyd This function will write the PSLF pss1a model to a dyd file.
%   fileID must be created before calling function.
%   All input arguments must be strings besides fileID.
%   flag=0 if complete, flag=1 if not complete 
%   Parameters:
%   Variable: Default Data:   Description:
% J	0	Input	signal	code		
% k	0	Remote	signal	bus	number	
% A1	0	Notch	filter	parameter		
% A2	0	Notch	filter	parameter		
% T1	0	Lead/lag	time	constant,	sec.	
% T2	0	Lead/lag	time	constant,	sec.	
% T3	0	Lead/lag	time	constant,	sec.	
% T4	0	Lead/lag	time	constant,	sec.	
% T5	0	Washout	time	constant,	sec.	
% T6	0	Transducer	time	constant,	sec.	
% Ks	0	Stabilizer	gain			
% Vrmax	0	Maximum	stabilizer	output,	p.u.	
% Vrmin	0	Minimum	stabilizer	output,	p.u.	
% Vcu	0	Stabilizer	input	cutoff	threshold,	p.u.
% Vcl	0	Stabilizer	input	cutoff	threshold,	p.u.
flag=1;
fprintf(fileID,'pss1a     %s "%s" %s "%s" : #9 %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s \n',...
    n,name,kv,id,J,k,A1,A2,T1,T2,T3,T4,T5,T6,Ks,Vrmax,Vrmin,Vcu,Vcl);
flag=0;
end