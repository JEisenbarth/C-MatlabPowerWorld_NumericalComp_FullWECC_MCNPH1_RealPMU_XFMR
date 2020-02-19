function [data] = PowerWorld_WriteDYD_Run_MCNPH1_RealPMU(filenamedyd,gentpj,esst1a,pss1a,ieeeg3,XFMR1,XFMR2,SimAuto,filename_RunAux,filename_PlayInCase,filename_SetupAux,Ipmu,Vpmu)
%PowerWorld_WriteDYD This function uses a series of other functions to write a
%PSLF dyd file which is later used by a PowerWorld simulation which is ran by
%using the SimAuto Add-on. An aux file is written to 

%% Setup PowerWorld Case  
SetupCase_MCNPH1(filename_SetupAux,filename_PlayInCase,Ipmu,Vpmu,XFMR1,XFMR2);

%% Open dyd File
fileID=fopen(filenamedyd,'w+');    %Open/create file for reading and writing.
%Discards previous contents.

%% Call Functions to Add Models to dyd File
fprintf(fileID,'models\n');

gentpj_dyd(fileID,'44101','MCN 01','13.80','01','mva=73.684',num2str(gentpj(1),10),num2str(gentpj(2),10),num2str(gentpj(3),10),num2str(gentpj(4),10),num2str(gentpj(5),10),num2str(gentpj(6),10),num2str(gentpj(7),10),num2str(gentpj(8),10),num2str(gentpj(9),10),num2str(gentpj(10),10),num2str(gentpj(11),10),num2str(gentpj(12),10),num2str(gentpj(13),10),num2str(gentpj(14),10),num2str(gentpj(15),10),num2str(gentpj(16),10),num2str(gentpj(17),10),num2str(gentpj(18),10),num2str(gentpj(19),10),num2str(gentpj(20),10));
esst1a_dyd(fileID,'44101','MCN 01','13.80','01',num2str(esst1a(1),10),num2str(esst1a(2),10),num2str(esst1a(3),10),num2str(esst1a(4),10),num2str(esst1a(5),10),num2str(esst1a(6),10),num2str(esst1a(7),10),num2str(esst1a(8),10),num2str(esst1a(9),10),num2str(esst1a(10),10),num2str(esst1a(11),10),num2str(esst1a(12),10),num2str(esst1a(13),10),num2str(esst1a(14),10),num2str(esst1a(15),10),num2str(esst1a(16),10),num2str(esst1a(17),10),num2str(esst1a(18),10),num2str(esst1a(19),10),num2str(esst1a(20),10));
pss1a_dyd(fileID,'44101','MCN 01','13.80','01',num2str(pss1a(1),10),num2str(pss1a(2),10),num2str(pss1a(3),10),num2str(pss1a(4),10),num2str(pss1a(5),10),num2str(pss1a(6),10),num2str(pss1a(7),10),num2str(pss1a(8),10),num2str(pss1a(9),10),num2str(pss1a(10),10),num2str(pss1a(11),10),num2str(pss1a(12),10),num2str(pss1a(13),10),num2str(pss1a(14),10),num2str(pss1a(15),10));
ieeeg3_dyd(fileID,'44101','MCN 01','13.80','01','mwcap=81.20',num2str(ieeeg3(1),10),	num2str(ieeeg3(2),10),	num2str(ieeeg3(3),10),	num2str(ieeeg3(4),10),	num2str(ieeeg3(5),10),	num2str(ieeeg3(6),10),	num2str(ieeeg3(7),10),	num2str(ieeeg3(8),10),	num2str(ieeeg3(9),10),	num2str(ieeeg3(10),10),	num2str(ieeeg3(11),10),	num2str(ieeeg3(12),10),	num2str(ieeeg3(13),10),	num2str(ieeeg3(14),10),	num2str(ieeeg3(15),10),	num2str(ieeeg3(16),10),	num2str(ieeeg3(17),10),	num2str(ieeeg3(18),10),	num2str(ieeeg3(19),10),	num2str(ieeeg3(20),10),	num2str(ieeeg3(21),10),	num2str(ieeeg3(22),10),	num2str(ieeeg3(23),10),	num2str(ieeeg3(24),10),	num2str(ieeeg3(25),10),	num2str(ieeeg3(26),10),	num2str(ieeeg3(27),10),	num2str(ieeeg3(28),10),	num2str(ieeeg3(29),10));

fclose(fileID);     %Closes file.


%% Run Simulation

%% Process Aux File to Load and Run Simulation
%Setup Aux File to Run Simulation
fileID = fopen(filename_RunAux,'w');
fprintf(fileID,['SCRIPT LoadDYD_RunPlayIn\n']);
fprintf(fileID,['{\n']);
fprintf(fileID,['//Clear Log\n']);
fprintf(fileID,['LogClear;\n'],filename_PlayInCase);

fprintf(fileID,['//Load Case\n']);
fprintf(fileID,['OpenCase("%s",PWB);\n'],filename_PlayInCase);

fprintf(fileID,['//Load SetupAux Aux File\n']);
fprintf(fileID,['LoadAux("SetupAux.aux");\n']);

fprintf(fileID,['//Load Aux File with PlayInData\n']);
fprintf(fileID,['LoadAux("PlayInData.aux");\n']);

fprintf(fileID,['//Enter Edit Mode\n']);
fprintf(fileID,['EnterMode(EDIT);\n']);

fprintf(fileID,['//Load Dyd File\n']);
fprintf(fileID,['TSLoadGE("MCNPH1_PlayIn.dyd", NO, YES);\n']);


fprintf(fileID,['//Enter Run Mode\n']);
fprintf(fileID,['EnterMode(RUN);\n']);

% fprintf(fileID,['//AutoCorrect\n']);
% fprintf(fileID,['TSAutoCorrect;\n']);
% 'Auto Correct On'

fprintf(fileID,['//Solve Dynamic Simulation\n']);
fprintf(fileID,['TSSolveAll;\n']);

fprintf(fileID,['//Save to Log\n']);
fprintf(fileID,['LogSave("Log_PowerWorld.txt");\n']);

fprintf(fileID,['}\n\n']);
fclose(fileID);

 
% Make the processAuxFile call
simOutput = SimAuto.ProcessAuxFile(filename_RunAux);

%% Load Results into Matlab via TSGetContingencyResults
% Here we get the results for all of the angles directly into Matlab via SimAuto
%%
newCtgName = 'My Transient Contingency';
objFieldList = {'"Plot ''PlayInData''"' };
simOutput = SimAuto.TSGetContingencyResults(newCtgName, objFieldList , '0.0', '30.0');
if ~(strcmp(simOutput{1},''))
disp(simOutput{1})
else
% disp('GetTSResultsInSimAuto successful')
 
%Get the results
data.Data = simOutput{3};
 
%Get the header variables to use for plot labels
data.Header = simOutput{2};

% Convert a matrix of strings into a matrix of numbers and plot them
data.Data = str2double(data.Data);
end



end

