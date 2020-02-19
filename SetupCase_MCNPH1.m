function [] = SetupCase_MCNPH1(filename_SetupAux,filename_PlayInCase,Ipmu,Vpmu,XFMR1,XFMR2)
%SetupCase_MCNPH1 This funciton will be used to write and run an Aux file
% to setup a case file from PMU Data. It takes the PMU voltage at the
% PlayIn bus then performs a calcuation to find the voltage and power at
% the generator bus so that the P,Q, and V measurements for the PMU match
% match the setup case.

%% Calculate Vm and Pm for Bus with MCNPH1 Generator

% Known Quantities
Sbase=100e6;
Vbase=230e3/sqrt(3);
Ibase=Sbase/(Vbase);
XfmrTap1=1.05;
XfmrTap2=1.04548;

Vt=Vpmu/Vbase;
I=-Ipmu*3/Ibase;

% abs(Vt)
% 
% real(Vt*conj(I))*Sbase/1e6
% imag(Vt*conj(I))*Sbase/1e6

%% Voltage over Xfmr1
ZXfmr1=XFMR1(1)+j*XFMR1(2);
Vm1=I*ZXfmr1*XfmrTap1+Vt/XfmrTap1; %Solve Vm then plug in for I.

Pm1=real(Vm1*conj(I))*XfmrTap1*Sbase/1e6;
Qm1=imag(Vm1*conj(I))*XfmrTap1*Sbase/1e6;
% abs(Vm)

%% Voltage over Xfmr2
I=I*XfmrTap1;
ZXfmr2=XFMR2(1)+j*XFMR2(2);
Vm2=I*ZXfmr2*XfmrTap2+Vm1/XfmrTap2; %Solve Vm then plug in for I.

Pm2=real(Vm2*conj(I))*XfmrTap2*Sbase/1e6;
Qm2=imag(Vm2*conj(I))*XfmrTap2*Sbase/1e6;



fileID = fopen(filename_SetupAux,'w');
fprintf(fileID,['SCRIPT\n']);
fprintf(fileID,['{\n']);
% fprintf(fileID,['//Load Case\n']);

fprintf(fileID,['OpenCase("%s",PWB);\n'],filename_PlayInCase);
% fprintf(fileID,['//Enter Edit Mode\n']);
fprintf(fileID,['EnterMode(EDIT);\n']);
fprintf(fileID,['}\n\n']);

% fprintf(fileID,['//Add Transformer 1 Parameters for PlayIn\n']);
fprintf(fileID,['DATA (Branch, [BusNum,BusName,BusNum:1,BusName:1,LineCircuit,LineR,LineX])\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['44122 "MCN PH1" 44115 "MCN TX1" 1 ',num2str(XFMR1(1),12),' ',num2str(XFMR1(2),12),'\n']);
fprintf(fileID,['}\n\n']);

% fprintf(fileID,['//Add Transformer 2 Parameters for PlayIn\n']);
fprintf(fileID,['DATA (Branch, [BusNum,BusName,BusNum:1,BusName:1,LineCircuit,LineR,LineX])\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['44115 "MCN TX1" 44101 "MCN 01" 1 ',num2str(XFMR2(1),12),' ',num2str(XFMR2(2),12),'\n']);
fprintf(fileID,['}\n\n']);

% fprintf(fileID,['//Add Generator Voltage for PlayIn Gen\n']);
fprintf(fileID,['DATA (GEN, [BusNum,BusName,GenID,VoltSet])\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['44122 "MCN PH1" 1 ',num2str(abs(Vt),12),'\n']);
fprintf(fileID,['}\n\n']);

% fprintf(fileID,['//Add Bus Voltage and Angle for PlayIn Bus\n']);
fprintf(fileID,['DATA (Bus, [BusNum,BusName,BusPUVolt,BusAngle])\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['44122 "MCN PH1" ',num2str(abs(Vt),12),' 0\n']);
fprintf(fileID,['}\n\n']);

% fprintf(fileID,['//Add Generator Real Power and Voltage for Gen\n']);
fprintf(fileID,['DATA (GEN, [BusNum,BusName,GenID,VoltSet,GenMW])\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['44101 "MCN 01" 01 ',num2str(abs(Vm2),12),' ',num2str(Pm2,12),'\n']);
fprintf(fileID,['}\n\n']);

fprintf(fileID,['SCRIPT\n']);
fprintf(fileID,['{\n']);
% fprintf(fileID,['//Enter Run Mode\n']);
fprintf(fileID,['EnterMode(RUN);\n']);
% fprintf(fileID,['//Solve Power Flow\n']);
fprintf(fileID,['SolvePowerFlow (RECTNEWT,"","");\n']);
% fprintf(fileID,['SaveCase("%s");\n'],filename_PlayInCase);
fprintf(fileID,['}\n\n']);
fclose(fileID);



end

