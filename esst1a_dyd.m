function [flag] = esst1a_dyd(fileID,n,name,kv,id,Tr,Vimax,Vimin,Tc,Tb,Ka,Ta,Vrmax,Vrmin,Kc,Kf,Tf,Tc1,Tb1,Vamax,Vamin,Ilr,Klr,UELin,PSSin)
%esst1a_dyd This function will write the PSLF esst1a model to a dyd file.
%   fileID must be created before calling function.
%   All input arguments must be strings besides fileID.
%   flag=0 if complete, flag=1 if not complete 
%   Parameters:
%   Variable: Default Data:   Description:
% Tr	0	Voltage	transducer	time	constant,	sec.						
% Vimax	999	Maximum	error,	p.u.								
% Vimin	-999	Minimum	error,	p.u.								
% Tc	1	Lead	time	constant,	sec.							
% Tb	10	Lag	time	constant,	sec.							
% Ka	190	Gain,	p.u.	(>	0.)							
% Ta	0.02	Time	constant,	sec.								
% Vrmax	7.8	Excitation	voltage	upper	limit,	p.u.						
% Vrmin	-6.7	Excitation	voltage	lower	limit,	p.u.						
% Kc	0.05	Excitation	system	regulation	factor,	p.u.						
% Kf	0	Rate	feedback	gain								
% Tf	1	Rate	feedback	time	constant,	sec.						
% Tc1	0	Lead	time	constant,	sec.							
% Tb1	0	Lag	time	constant,	sec.							
% Vamax	999	Maximum	control	element	output,	p.u.						
% Vamin	-999	Minimum	control	element	output,	p.u						
% Ilr	0	Maximum	field	current,	p.u.	(note	b)					
% Klr	0	Gain	on	field	current	limit	(note	b)				
% UELin	0	=	2	–	UEL	input	added	to	error	signal		
% 		=	1	–	UEL	input	HV	gate	with	error	signal	
% 		=	-1	–	UEL	input	HV	gate	with	volt.	reg.	output
% 		=	0	–	ignore	UEL	signal					
% PSSin	0	=	0	–	PSS	input	(Vs)	added	to	error	signal	
% 		¹	0	–	PSS	input	(Vs)	added	to	voltage	regulator	output

flag=1;
fprintf(fileID,'esst1a     %s "%s" %s "%s" : #0 %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s \n',...
    n,name,kv,id,Tr,Vimax,Vimin,Tc,Tb,Ka,Ta,Vrmax,Vrmin,Kc,Kf,Tf,Tc1,Tb1,Vamax,Vamin,Ilr,Klr,UELin,PSSin);
flag=0;
end
