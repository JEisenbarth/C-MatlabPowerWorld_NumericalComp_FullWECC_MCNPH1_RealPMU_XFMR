% Jacob Eisenbarth
% This script will be used to run multiple different PowerWorld cases within
% Matlab. First, the script writes a  .dyd file from Matlab using a
% series of functions. NEED to finish Description.....

%% Initialize Matlab
clc,clear all, format longG,format compact
% close all
tic

%% Establish a connection with PowerWorld / SimAuto
disp('>> Connecting to PowerWorld Simulator / SimAuto...')
SimAuto = actxserver('pwrworld.SimulatorAuto');
disp('Connection established')

%% Data to be Entered into dyd File
%Model gentpj
gentpj(1)=5.4; %Tpdo
gentpj(2)=0.022; %Tppdo
gentpj(3)=0; %Tpqo
gentpj(4)=0.022; %Tppqo
gentpj(5)=5.4; %H
gentpj(6)=0; %D
gentpj(7)=0.57; %Ld
gentpj(8)=0.32; %Lq            %Avoid fitting because when Tpqo=0 Lq must = Lpq
gentpj(9)=0.25; %Lpd
gentpj(10)=0.32; %Lpq           %Avoid fitting because when Tpqo=0 Lq must = Lpq
gentpj(11)=0.18; %Lppd
gentpj(12)=0.18; %Lppq
gentpj(13)=0.13; %Ll
gentpj(14)=0.17; %S1
gentpj(15)=0.62; %S12
gentpj(16)=0.0031; %Ra
gentpj(17)=0; %Rcomp
gentpj(18)=0; %Xcomp
gentpj(19)=0.5; %accel
gentpj(20)=0; %Kis

index_gentpj=[1,2,4,5,7,9,11:16,19];     %Index for numerical parameters to edit

%Model esst1a
esst1a(1)=0.012; %Tr
esst1a(2)=0.1; %Vimax
esst1a(3)=-0.1; %Vimin
esst1a(4)=1.13; %Tc
esst1a(5)=3.75; %Tb
esst1a(6)=124; %Ka
esst1a(7)=0.05; %Ta
esst1a(8)=3.78; %Vrmax
esst1a(9)=0.04; %Vrmin
esst1a(10)=0.07; %Kc
esst1a(11)=0; %Kf
esst1a(12)=0; %Tf
esst1a(13)=0; %Tc1
esst1a(14)=0; %Tb1
esst1a(15)=999; %Vamax
esst1a(16)=-999; %Vamin
esst1a(17)=0; %Ilr
esst1a(18)=0; %Klr
esst1a(19)=0; %UELin
esst1a(20)=0; %PSSin


index_esst1a=[1:10,15,16];     %Index for numerical parameters to edit

%Model pss1a
pss1a(1)=2; %J
pss1a(2)=0; %k
pss1a(3)=0.035; %A1
pss1a(4)=0; %A2
pss1a(5)=0.15; %T1
pss1a(6)=0.015; %T2
pss1a(7)=0.15; %T3
pss1a(8)=0.015; %T4
pss1a(9)=10; %T5
pss1a(10)=0.035; %T6
pss1a(11)=20; %Ks
pss1a(12)=0.1; %Vrmax
pss1a(13)=-0.1; %Vrmin
pss1a(14)=999; %Vcu
pss1a(15)=-999; %Vcl

index_pss1a=[5:15];       %Index for numerical parameters to edit

%Model ieeeg3
ieeeg3(1)=0.1; %Tg
ieeeg3(2)=0.1; %Tp
ieeeg3(3)=0.14; %Uo
ieeeg3(4)=-0.14; %Uc
ieeeg3(5)=1; %Pmax
ieeeg3(6)=0; %Pmin
ieeeg3(7)=0.19; %Rperm
ieeeg3(8)=0.85; %Rtemp
ieeeg3(9)=2; %Tr
ieeeg3(10)=0.864; %Tw
ieeeg3(11)=1; %Kturb
ieeeg3(12)=-1; %Aturb
ieeeg3(13)=0.5; %Bturb
ieeeg3(14)=0; %Spare
ieeeg3(15)=0; %db1
ieeeg3(16)=0; %eps
ieeeg3(17)=0; %db2
ieeeg3(18)=0; %Gv1
ieeeg3(19)=0; %Pgv1
ieeeg3(20)=0; %Gv2
ieeeg3(21)=0; %Pgv2
ieeeg3(22)=0; %Gv3
ieeeg3(23)=0; %Pgv3
ieeeg3(24)=0; %Gv4
ieeeg3(25)=0; %Pgv4
ieeeg3(26)=0; %Gv5
ieeeg3(27)=0; %Pgv5
ieeeg3(28)=0; %Gv6
ieeeg3(29)=0; %Pgv6

index_ieeeg3=[1:5,7:13];     %Index for numerical parameters to edit

%Model XFMR1
XFMR1(1)= 0.000000;  %XFMR1 R
XFMR1(2)= -0.001210; %XFMR1 X
XFMR1(3)= 0.001590;  %XFMR1 Mag Conductance
XFMR1(4)= -0.005850; %XFMR1 Mag Susceptance


index_XFMR1=[2:4];  %Index for numerical parameters to edit

%Model XFMR2
XFMR2(1)= 0.0041541; %XFMR2 R
XFMR2(2)= 0.080986; %XFMR2 X

index_XFMR2=[1:2];  %Index for numerical parameters to edit

gentpj_original=gentpj;
esst1a_original=esst1a;
pss1a_original=pss1a;
ieeeg3_original=ieeeg3;
XFMR1_original=XFMR1;
XFMR2_original=XFMR2;

index=struct('gentpj',index_gentpj,'esst1a',index_esst1a,'pss1a',index_pss1a,'ieeeg3',index_ieeeg3,'XFMR1',index_XFMR1,'XFMR2',index_XFMR2);

clear index_gentpj index_esst1a index_pss1a index_ieeeg3 index_XFMR1 index_XFMR2

%% File Names for Different Years of Data
list2016=[...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_5092_2to5122_2.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_5399_75to5429_75.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_5992_4to6022_4.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_6291_05to6321_05.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_8699_1to8729_1.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_9231_1to9261_1.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_9712_8to9742_8.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_10056_55to10086_55.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_12598_35to12628_35.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_13190_1to13220_1.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_13498_4to13528_4.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_19492to19522.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_19799_8to19829_8.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_20390_5to20420_5.mat";...
    "MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_20694_15to20724_15.mat";...
    ];

list2017=[...
    %     "MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_4790to4820.mat";...
    %     "MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_5090to5120.mat";...
    %     "MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_5698to5728.mat";...
    %     "MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_5990to6020.mat";...
    
    "MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_8393_85to8423_85.mat";...
    "MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_8697_5to8727_5.mat";...
    "MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_9304_65to9334_65.mat";...
    "MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_9692_25to9722_25.mat";...
    "MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_19494_45to19524_45.mat";...
    "MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_19647_2to19677_2.mat";...
    "MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_26691_05to26721_05.mat";...
    "MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_27300_4to27330_4.mat";...
    
    
    
    
%         "MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_8393_85to8433_85.mat";... %% Noise Jacobian Test

    ];

%
% numbers=[...
% % [5102-10:.05:5102]',[5132-10:.05:5132]';...
% %     [5400-10:.05:5400]',[5430-10:.05:5430]';...
% %     [5990:.05:6000]',[6020:.05:6030]';...
% %     [6301-10:.05:6301]',[6321:.05:6331]';...
% %     [8701-10:.05:8701]',[8731-10:.05:8731]';...
% %     [9241-10:.05:9241]',[9271-10:.05:9271]';...
% %     [9721-10:.05:9721]',[9751-10:.05:9751]';...
% %     [10060-10:.05:10060]',[10080:.05:10090]';...
% %     [12600-10:.05:12600]',[12630-10:.05:12630]';...
% %     [13200-10:.05:13200]',[13230-10:.05:13230]';...
% %     [13500-10:.05:13500]',[13530-10:.05:13530]';...
% %     [19500-10:.05:19500]',[19530-10:.05:19530]';...
% %     [19800-10:.05:19800]',[19830-10:.05:19830]';...
% %     [20400-10:.05:20400]',[20430-10:.05:20430]';...
% %     [20700-10:.05:20700]',[20730-10:.05:20730]';...
% ];
%
% for y=1:size(numbers,1)
%     t1name=num2str(round(min(numbers(y,:)),3));
%     t2name=num2str(round(max(numbers(y,:)),3));
%
%     t1name(find(t1name=='.'))='_';
%     t2name(find(t2name=='.'))='_';
%     list2016(y,:)=['MCNPH1 Real PMU Data from 2016\MCNPH1_2016Event_',t1name,'to',t2name,'.mat'];
% end
%
% numbers=[...
%     [8401-10:.05:8401]',[8431-10:.05:8431]';...
%     [8701-10:.05:8701]',[8731-10:.05:8731]';...
% %     [9306-10:.05:9306]',[9336-10:.05:9336]';...
% %     [9693-10:.05:9693]',[9723-10:.05:9723]';...
% %     [19503-10:.05:19503]',[19533-10:.05:19533]';...
% %     [19650-10:.05:19650]',[19680-10:.05:19680]';...
% %     [26701-10:.05:26701]',[26731-10:.05:26731]';...
% %     [27301-10:.05:27301]',[27331-10:.05:27331]';...
% ];
%
% for y=1:size(numbers,1)
%     t1name=num2str(round(min(numbers(y,:)),3));
%     t2name=num2str(round(max(numbers(y,:)),3));
%
%     t1name(find(t1name=='.'))='_';
%     t2name(find(t2name=='.'))='_';
%     list2017(y,:)=['MCNPH1 Real PMU Data from 2017\MCNPH1_2017Event_',t1name,'to',t2name,'.mat'];
% end




for m=1:1
    m
    if m==1
        list=list2016;
    elseif m==2
        list=list2017;
    end
    
    
    % list_noisemult=[.0043] %2017 data
    % list_noisemult=[.0014] %2018 data
    list_noisemult=[.0008] %2018 data
%     list_noisemult=[.0006] %2016 data
    
    
%     for k=1:length(list_noisemult)
        
    % for k=1:100
    
%     for k=1:size(list,1)
%         clear final_theta output resnorm
%         paramlist=[4];
        
        %         paramlist=[4,19,51];
%                     paramlist=[4,5,17,37,45,51];
%                     paramlist=[18,19,32];
paramlist=[4,32];
% paramlist=[1:51];
%          paramlist=[46]
        %         paramlist=[4,32,51]
        %     paramlist=[1:100];
        
        
                for k=1:length(paramlist)
        % for k=1:length(noisemultiplierlist)
        %File Names to Be Used In Script
        filename_SetupAux=[pwd,'\SetupAux.aux'];
        filename_PlayInCase='MCNPH1_PlayIn_RealPMU.PWB';
        filename_DataAux=[pwd,'\PlayInData.aux'];
        filenamedyd=[pwd,'\MCNPH1_PlayIn.dyd'];
        filename_RunAux = [pwd,'\LoadDYD_RunPlayIn_RealPMU.aux'];
        
%                 noisemultstr=num2str(list_noisemult(k));
        noisemultstr=num2str(list_noisemult(1));
        
        noisemultstr=noisemultstr(find(noisemultstr=='.')+1:end);
        
%             filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2017\2017 Fittings\MCNPH1_2017_SingleParameterH_Ld_XfmrX_Event',num2str(k),'_VNoiseMult_',noisemultstr,'PQoffset_01_NoiseAfterEventStart_100runs.mat'];
        
        if m==1
%                         filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2017\Jacobian Tests\MCNPH1_2016_Event',num2str(k),'_Jacobian_Residual.mat'];
            %             filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2016\2016 Fittings\MCNPH1_2016_PlayInOriginal.mat'];
%             filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2016\2016 Fittings\MCNPH1_2016_MultiParameterH_XfmrX_NoNoise.mat'];
%                         filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2016\2016 Fittings\MCNPH1_2016_SingleParameterH_NoNoise_ZeroMean.mat'];
            % filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2016\2016 Fittings\MCNPH1_2016_2017_PlayInBestInitialization_missing2017events.mat'];
%                         filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2016\2016 Fittings\MCNPH1_2016_SingleParameterH_Event',num2str(k),'_VNoiseMult_',noisemultstr,'PQoffset_00_NoiseAfterEventStart.mat'];
%                         filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2016\2016 Fittings\MCNPH1_2016_SingleParameterAllParameter_NoNoise_ZeroMean.mat'];
                        filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2016\2016 Fittings\MCNPH1_2016_SingleParameterH_Ks_Event1_VNoiseMult_',noisemultstr,'PQoffset_00_NoiseAfterEventStart.mat'];

            
        elseif m==2
%                         filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2017\Jacobian Tests\MCNPH1_2017_Event',num2str(k),'_Jacobian_Residual.mat'];
            %             filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2017\2017 Fittings\MCNPH1_2017_PlayInOriginal.mat'];
%             filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2017\2017 Fittings\MCNPH1_2017_MultiParameterH_XfmrX_NoNoise.mat'];
%                         filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2017\2017 Fittings\MCNPH1_2017_SingleParameterH_NoNoise_ZeroMean.mat'];
            % filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2016\2016 Fittings\MCNPH1_2016_2017_PlayInBestInitialization_missing2017events.mat'];
%                                     filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2017\2017 Fittings\MCNPH1_2017_SingleParameterH_Event',num2str(k),'_VNoiseMult_',noisemultstr,'PQoffset_00_NoiseAfterEventStart_50runs.mat'];
%                                     filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2017\2017 Fittings\MCNPH1_2017_SingleParameterAllParameter_NoNoise.mat'];
%                                     filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2017\2017 Fittings\MCNPH1_2017_SingleParameterAllParameter_NoNoise_ZeroMean.mat'];

%                         filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2017\Jacobian Tests\MCNPH1_2017_Event1_Jacobian_Residual_NOISEAFTEREVENT.mat'];
%                                     filename_SaveLocation=['D:\Users\JEisenbarth\Desktop\PowerWorld Files\MCNPH1 Real PMU Data from 2017\2017 Fittings\MCNPH1_2017_SingleParameterAllParameter_NoNoise.mat'];


            
        end
        
        
        
        numericalsims=1250;
        %     clear final_theta resnorm output
        %         clear data data_orig;
        for x=1:numericalsims
            %     for x=1:length(paramlist)
            
            %% Setup PlayIn PowerWorld Case for PMU Data
            %Load datacsv
%                     load(['D:\Users\JEisenbarth\Desktop\PowerWorld Files\',char(list(k))]);
['D:\Users\JEisenbarth\Desktop\PowerWorld Files\',char(list(1))]            
load(['D:\Users\JEisenbarth\Desktop\PowerWorld Files\',char(list(1))]);
            
            
            %% Write Data Aux File for Centralia Event PlayIn
            datacsv.t1=datacsv.t1-datacsv.t1(1);
            t1=datacsv.t1;
            Vt=datacsv.Vt;
            I=datacsv.I;
            f1=datacsv.f1;
            
            %% ADD Filtered Measurement Noise to V and F
            %Noise Multipliers
            %                 Vtnoisemultiplier=.0006;
%             Vtnoisemultiplier=list_noisemult(k);
            Vtnoisemultiplier=list_noisemult(1);
            
            %         Vtnoisemultiplier=0;
            
            
            %Voltage and current Noise
            Iavg=131.196915502056;       %A
            Vtavg=139123.319373353;      %Volts
            [b,a]=butter(3,5/30); %LP filter with cutoff of 5Hz
            
            
            
            %Find Start Time Event
            indexstartevent=find(round(t1,8)==datacsv.tevent);
            
            Vtnoisemag=Vtnoisemultiplier*Vtavg*randn(length(Vt(indexstartevent:end)),1);
            Vtnoiseang=Vtnoisemultiplier*pi*randn(length(Vt(indexstartevent:end)),1);
            Inoisemag=Vtnoisemultiplier*Iavg*randn(length(I(indexstartevent:end)),1);
            Inoiseang=Vtnoisemultiplier*pi*randn(length(I(indexstartevent:end)),1);
            
            Vtnoisemag=filter(b,a,Vtnoisemag);
            Vtnoiseang=filter(b,a,Vtnoiseang);
            Inoisemag=filter(b,a,Inoisemag);
            Inoiseang=filter(b,a,Inoiseang);
            
            Vtnoisemag(1)=0;
            Vtnoiseang(1)=0;
            Inoisemag(1)=0;
            Inoiseang(1)=0;
            
            Vtnoise=[Vt(1:indexstartevent-1);(abs(Vt(indexstartevent:end))+Vtnoisemag).*exp(1i*(angle(Vt(indexstartevent:end))+Vtnoiseang))];
            Inoise=[I(1:indexstartevent-1);(abs(I(indexstartevent:end))+Inoisemag).*exp(1i*(angle(I(indexstartevent:end))+Inoiseang))];
            
            %Calculate P and Q
            P=real(3*Vtnoise.*conj(Inoise)/1e6);
            Q=imag(3*Vtnoise.*conj(Inoise)/1e6);
            
            %Frequency
            anglenoise=[zeros(indexstartevent-1,1);Vtnoiseang;];
            
            
            fmeasnoise = (30/pi)*angle(exp(1i*anglenoise(2:end))./exp(1i*anglenoise(1:end-1))); %freq error mHz
            fmeasnoise = [fmeasnoise(1);fmeasnoise]/sqrt(6);
            
            fmeasnoise=filter(b,a,fmeasnoise);
            f1(2:end)=f1(2:end)+fmeasnoise(2:end);
            
            %         f1=[f1(1:index10sec);f1(index10sec+1:end)+fmeasnoise];
            
            %Add P and Q Offset Noise
            Pavg=mean(datacsv.P);
            Qavg=mean(datacsv.Q);
            %         PQ_offsetMult=.01;
            PQ_offsetMult=0;
            
            
            
            %         P(2:end)=P(2:end)+Pavg*PQ_offsetMult*(rand(1)-.5);
            %         Q(2:end)=Q(2:end)+Qavg*PQ_offsetMult*(rand(1)-.5);
            
            P(1)=P(1)+Pavg*PQ_offsetMult/10*(rand(1)-.5);
            Q(1)=Q(1)+Qavg*PQ_offsetMult/10*(rand(1)-.5);
            
%             %         %Filter Plot Check
%                     figure
%                     subplot(3,1,1)
%                     plot(t1,real(Vtnoise*sqrt(3)/230e3),t1,real(Vt*sqrt(3)/230e3),'LineWidth',1)
%                     legend('Added Measurement Noise','Original')
%                     title(['MCNPH1 Event: Voltage PlayIn Noise Mult=',num2str(Vtnoisemultiplier)])
%                     ylabel('Real Voltage ')
%                     xlabel('Time(s)')
%                     grid
%                     xlim([0,30])
%             
%                     subplot(3,1,2)
%                     plot(t1,imag(Vtnoise*sqrt(3)/230e3),t1,imag(Vt*sqrt(3)/230e3),'LineWidth',1)
%                     legend('Added Measurement Noise','Original')
%                     ylabel('Imag Voltage ')
%                     xlabel('Time(s)')
%                     grid
%                     xlim([0,30])
%             
%                     subplot(3,1,3)
%                     plot(t1,abs(Vtnoise*sqrt(3)/230e3),t1,abs(Vt*sqrt(3)/230e3),'LineWidth',1)
%                     legend('Added Measurement Noise','Original')
%                     ylabel('Voltage Magnitude(pu)')
%                     xlabel('Time(s)')
%                     grid
%                     xlim([0,30])
%             
%                     figure
%                     subplot(3,1,1)
%                     plot(t1,real(Inoise),t1,real(I),'LineWidth',1)
%                     legend('Added Measurement Noise','Original')
%                     title(['MCNPH1 Event: Current PlayIn Noise Mult=',num2str(Vtnoisemultiplier)])
%                     ylabel('Real Current(A)')
%                     xlabel('Time(s)')
%                     grid
%                     xlim([0,30])
%             
%                     subplot(3,1,2)
%                     plot(t1,imag(Inoise),t1,imag(I),'LineWidth',1)
%                     legend('Added Measurement Noise','Original')
%                     ylabel('Imag Current (A)')
%                     xlabel('Time(s)')
%                     grid
%                     xlim([0,30])
%             
%                     subplot(3,1,3)
%                     plot(t1,abs(Inoise),t1,abs(I),'LineWidth',1)
%                     legend('Added Measurement Noise','Original')
%                     ylabel('Current Magnitude(A)')
%                     xlabel('Time(s)')
%                     grid
%                     xlim([0,30])
%             
%                     figure
%                     plot(t1,(f1),t1,(f1-fmeasnoise),'LineWidth',1)
%             
%                     legend('Added Measurement Noise','Original')
%                     title(['MCNPH1 Event: Frequency PlayIn Noise Mult=',num2str(Vtnoisemultiplier)])
%                     xlabel('Time(s)')
%                     ylabel('Frequency (Hz)')
%                     grid
%                     xlim([0,30])
%             
%                     figure
%                     subplot(2,1,1)
%                     plot(t1,P,t1,datacsv.P,'LineWidth',1)
%                     legend('Added Measurement Noise','Original')
%                     title(['MCNPH1 Event: Real Power PlayIn Noise Mult=',num2str(Vtnoisemultiplier)])
%                     ylabel('Real Power (MW)')
%                     xlabel('Time(s)')
%                     grid
%                     xlim([0,30])
%             
%                     subplot(2,1,2)
%                     plot(t1,Q,t1,datacsv.Q,'LineWidth',1)
%                     legend('Added Measurement Noise','Original')
%                     title(['MCNPH1 Event: Reactive Power PlayIn Noise Mult=',num2str(Vtnoisemultiplier)])
%                     ylabel('Reactive Power (MVAR)')
%                     xlabel('Time(s)')
%                     grid
%                     xlim([0,30])
            
            datacsv.Pnonoise=datacsv.P;
            datacsv.Qnonoise=datacsv.Q;
            datacsv.P=P;
            datacsv.Q=Q;
            
            datacsv.Vtnoise=Vtnoise;
            datacsv.Inoise=Inoise;
            datacsv.f1noise=f1;
            
            
            %           WritePlayInAux(filename_DataAux,t1,ones(size(t1))*abs(Vtnoise(1)*sqrt(3)/230e3),ones(size(t1))*f1(1)/60)
            
            WritePlayInAux(filename_DataAux,t1,abs(Vtnoise*sqrt(3)/230e3),f1/60)
            
            
            %% Setup PowerWorld Case Based on Starting Point for Real PMU Data
            Vpmu=datacsv.Vtnoise(1);
            Ipmu=datacsv.Inoise(1);
            SetupCase_MCNPH1(filename_SetupAux,filename_PlayInCase,Ipmu,Vpmu,XFMR1,XFMR2)
            
            %% Setup to Run to Minimize Cost Function
            %Setup Column Vector of Parameter to Adjust
            theta_indicies=[ones(length(index.gentpj),1),[1:length(index.gentpj)]';...
                2*ones(length(index.esst1a),1),[1:length(index.esst1a)]';...
                3*ones(length(index.pss1a),1),[1:length(index.pss1a)]';...
                4*ones(length(index.ieeeg3),1),[1:length(index.ieeeg3)]';...
                5*ones(length(index.XFMR1),1),[1:length(index.XFMR1)]';...
                6*ones(length(index.XFMR2),1),[1:length(index.XFMR2)]';];
            
            %Setup Lower Bound Vector for Timeconstants >4*Timestep
            lb_list=-Inf*ones(size(theta_indicies,1),1);
            lb_list([1,2,3])=4*1/300; %Tpdo,Tppdo,Tppqo>4*Ts
            lb_list([5])=.25; %Ld>Lpd
            lb_list([6])=.18; %Lpd>Lppd
%             lb_list([7])=.05; %Lppd>0.05
            lb_list([7])=.18/2.5; %Lppd<Lppq/2.5
            lb_list([8])=.5*.18; %Lppq>.5*Lppd
            
            %         lb_list([8])=.32; %Lppq>
            %         lb_list([14,18,20])=4*1/300; %Tr,Tb,Ta>4*Ts
            lb_list([14])=2*1/300; %Tra>2*Ts
            lb_list([18,20])=4*1/300; %Tb,Ta>4*Ts
            lb_list([27,29,31])=4*1/300; %T2,T4,T6>4*Ts
            lb_list([30])=4*1/300; %T5>4*Ts
            lb_list([37,38,44,45,46,48])=4*1/300; %Tg,Tp,Tr,Tw,Kturb,Bturb>4*Ts
            
            
            ub_list=Inf*ones(size(theta_indicies,1),1);
            ub_list([6])=.57; %Lpd<Ld
            ub_list([7])=.248; %Lppd<Lpd
            ub_list([8])=1.5*.18; %Lppq<1.5*Lppd
            ub_list([9])=1; %Having problems if L1 got too high
            ub_list([22])=3.78; %Vrmin<Vrmax
            
                    lb=[lb_list(paramlist(k));];
                    ub=[ub_list(paramlist(k));];
                    theta_indicies=theta_indicies([paramlist(k)],:)
            %
%                     lb=[lb_list(paramlist(x));];
%                     ub=[ub_list(paramlist(x));];
%                     theta_indicies=theta_indicies([paramlist(x)],:);
            %
            %
%             theta_indicies=theta_indicies([paramlist],:);
%             lb=[lb_list(paramlist);];
%             ub=[ub_list(paramlist);];
            
            % theta_indicies=[1,4];    %1st column is model,2nd column is numerical parameter
            %Ex. [1,4]->model=H, parameter=H
            
            %Setup theta Vectors
            theta=zeros(size(theta_indicies,1),1);
            for b=1:length(theta)
                if theta_indicies(b,1)==1
                    theta(b)= gentpj_original(index.gentpj(theta_indicies(b,2)));
                elseif theta_indicies(b,1)==2
                    theta(b)= esst1a_original(index.esst1a(theta_indicies(b,2)));
                elseif theta_indicies(b,1)==3
                    theta(b)= pss1a_original(index.pss1a(theta_indicies(b,2)));
                elseif theta_indicies(b,1)==4
                    theta(b)= ieeeg3_original(index.ieeeg3(theta_indicies(b,2)));
                elseif theta_indicies(b,1)==5
                    theta(b)= XFMR1_original(index.XFMR1(theta_indicies(b,2)));
                elseif theta_indicies(b,1)==6
                    theta(b)= XFMR2_original(index.XFMR2(theta_indicies(b,2)));
                end
            end
            
            percentnominal=abs(.01*theta);
            
            %% Run Simulation w Original theta in model
            % Run Original Simulation w/ Nominal dyd file.
%             [data_orig(k,x)] = PowerWorld_WriteDYD_Run_MCNPH1_RealPMU(filenamedyd,gentpj_original,esst1a_original,pss1a_original,ieeeg3_original,XFMR1_original,XFMR2_original,SimAuto,filename_RunAux,filename_PlayInCase,filename_SetupAux,Ipmu,Vpmu) ;
            
            %% Run Minimizing Cost Function
            PQ_Flag=2; %When PQ_Flag is 2 then that means to use P and Q for residual calculations.
            k
            opts=optimoptions(@lsqnonlin,'TolFun',1e-12,'Display','iter','Diagnostics','off','Tolx',1e-3,'MaxFunEvals',50,'SpecifyObjectiveGradient',true);
%                                     opts=optimoptions(@lsqnonlin,'TolFun',1e-12,'Display','iter','Diagnostics','off','Tolx',1e-12,'MaxFunEvals',0,'MaxIterations',0,'SpecifyObjectiveGradient',true);
            
            residual = @(theta) residual_Jacobian_PowerWorld_RealPMU_MCNPH1(theta,theta_indicies,index,datacsv,filenamedyd,gentpj,esst1a,pss1a,ieeeg3,XFMR1,XFMR2,PQ_Flag,SimAuto,percentnominal,filename_RunAux,filename_PlayInCase,filename_SetupAux,Ipmu,Vpmu);
            
                            [final_theta(k,x),resnorm(k,x),residualout,exitflag,output(k,x),lambda,Jacobian] = lsqnonlin(residual,theta,lb,ub,opts);
%             [final_theta(k,:),resnorm(k,:),residualout,exitflag,output(k,:),lambda,Jacobian] = lsqnonlin(residual,theta,lb,ub,opts);
%             rtest(m,k)=mean(abs(residualout));
            
            
            x
            
%             %% Run Simulation with newly found theta
%             
%             %Put thetas into model
%             for g=1:size(theta_indicies,1)
%                 if theta_indicies(g,1)==1
%                     gentpj(index.gentpj(theta_indicies(g,2)))=final_theta(k,g);
%                 elseif theta_indicies(g,1)==2
%                     esst1a(index.esst1a(theta_indicies(g,2)))=final_theta(k,g);
%                 elseif theta_indicies(g,1)==3
%                     pss1a(index.pss1a(theta_indicies(g,2)))=final_theta(k,g);
%                 elseif theta_indicies(g,1)==4
%                     ieeeg3(index.ieeeg3(theta_indicies(g,2)))=final_theta(k,g);
%                 elseif theta_indicies(g,1)==5
%                     XFMR1(index.XFMR1(theta_indicies(g,2)))=final_theta(k,g);
%                 elseif theta_indicies(g,1)==6
%                     XFMR2(index.XFMR2(theta_indicies(g,2)))=final_theta(k,g);
%                 end
%             end
%             %Run Simulation w final theta in model
%             [data(k,x)] = PowerWorld_WriteDYD_Run_MCNPH1_RealPMU(filenamedyd,gentpj,esst1a,pss1a,ieeeg3,XFMR1,XFMR2,SimAuto,filename_RunAux,filename_PlayInCase,filename_SetupAux,Ipmu,Vpmu);
%             
%             %Set Models to Original
%             gentpj=gentpj_original;
%             esst1a=esst1a_original;
%             pss1a=pss1a_original;
%             ieeeg3=ieeeg3_original;
%             XFMR1=XFMR1_original;
%             XFMR2=XFMR2_original;
            
            toc
            %% Save Fitting Data
%                     save(filename_SaveLocation,'residualout','theta','Jacobian')
%                     clear residualout Jacobian
            %         %         %         %         %save(filename_SaveLocation,'final_theta','resnorm','output','list')
            %         %         %         %         %save(filename_SaveLocation,'final_theta','resnorm','output','list','data')
            %         %         %         %
%             datacsv_save(k,x)=datacsv;
            %
            %
%             save(filename_SaveLocation,'final_theta','resnorm','output','list','data','data_orig','datacsv','datacsv_save')
            %                         save(filename_SaveLocation,'list','data_orig','datacsv','datacsv_save')
            %
                    save(filename_SaveLocation,'final_theta','resnorm','output','list')
                    
            
            %         save(filename_SaveLocation,'rtest','listsave')
            
        end
        
        %% Plot Check
        list_title2017=[...
            %         "2017 125 MW Square-wave Pulse";...
            %         "2017 CJ Brake Pulse";...
            %         "2017 CJ Brake Pulse";...
            %         "2017 125 MW Square-wave Pulse";...
            "2017 125 MW Square-wave Pulse";...
            "2017 CJ Brake Pulse";...
            "2017 CJ Brake Pulse";...
            "2017 125 MW Square-wave Pulse";...
            "2017 125 MW Square-wave Pulse";...
            "2017 125 MW Square-wave Pulse";...
            "2017 125 MW Square-wave Pulse";...
            "2017 125 MW Square-wave Pulse";...
            ];
        
        list_title2018=[...
            "2018 125 MW Square-wave Pulse";...
            "2018 CJ Brake Pulse";...
            "2018 CJ Brake Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 CJ Brake Pulse";...
            "2018 CJ Brake Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 125 MW Square-wave Pulse";...
            "2018 125 MW Square-wave Pulse";...
            ];
        
        
        
%                         figure
%                         ndxP=PWFind(data_orig(k),'Branch ',' 44122 44115 1 ','MW From');
%                         ndxQ=PWFind(data_orig(k),'Branch ',' 44122 44115 1 ','Mvar From');
%                         subplot(3,1,1)
%                         hold on
%                         plot(datacsv.t1,datacsv.P,'LineWidth',1,'DisplayName','Event')
%                         plot(data_orig(k,1).Data(:,1),data_orig(k,1).Data(:,ndxP),'LineWidth',1,'DisplayName','PlayIn Orig')
%                         plot(data(k,1).Data(:,1),data(k,1).Data(:,ndxP),'LineWidth',1,'DisplayName','PlayIn Fitted')
%                         hold off
%         %                 if size(list2017,1)==size(list,1)
%         %                     title(['k=',num2str(k),' ',char(list_title2017(k,:)),' P Plot'])
%         %                 elseif size(list2018,1)==size(list,1)
%         %                     title(['k=',num2str(k),' ',char(list_title2018(k,:)),' P Plot'])
%         %                 end
%                         title(list(k,:))
%                         legend('Location','Best')
%                         grid
%                         xlabel('Seconds')
%                         ylabel('MW')
%                         %     xlim([10,30])
%         
%                         subplot(3,1,2)
%                         hold on
%                         plot(datacsv.t1,datacsv.Q,'LineWidth',1,'DisplayName','Event')
%                         plot(data_orig(k,1).Data(:,1),data_orig(k,1).Data(:,ndxQ),'LineWidth',1,'DisplayName','PlayIn Orig')
%                         plot(data(k,1).Data(:,1),data(k,1).Data(:,ndxQ),'LineWidth',1,'DisplayName','PlayIn Fitted')
%                         hold off
%         %                 if size(list2017,1)==size(list,1)
%         %                     title(['k=',num2str(k),' ',char(list_title2017(k,:)),' Q Plot'])
%         %                 elseif size(list2018,1)==size(list,1)
%         %                     title(['k=',num2str(k),' ',char(list_title2018(k,:)),' Q Plot'])
%         %                 end
%                     title(list(k,:))
%                         legend('Location','Best')
%                         grid
%                         xlabel('Seconds')
%                         ylabel('MVAR')
%                         %         xlim([10,30])
%                         %         savefig(['F:\Grad School Research\State Plots\PQ Plots\PQPlot_Event',num2str(k),'.fig'])
%         
%                         % subplot(3,1,3)
%                         %     hold on
%                         %     plot(data_orig(k).Data(:,1),data_orig(k).Data(:,11),'LineWidth',1,'DisplayName','PlayIn Orig')
%                         %     hold off
%                         %     if size(list2017,1)==size(list,1)
%                         %         title(['k=',num2str(k),' ',char(list_title2017(k,:)),' Vref State Plot'])
%                         %     elseif size(list2018,1)==size(list,1)
%                         %         title(['k=',num2str(k),' ',char(list_title2018(k,:)),' Vref Plot'])
%                         %     end
%                         %     legend();
%                         %     ylim([1,1.01])
%                         %     yticks([1:.001:1.01])
%                         %     grid
%                         %     xlabel('Seconds')
%                         %     ylabel('Pu')
%         
%                         % subplot(3,1,3)
%                         %     hold on
%                         %     plot(data_orig(k).Data(:,1),data_orig(k).Data(:,21),'LineWidth',1,'DisplayName','PlayIn Orig')
%                         %     hold off
%                         %     if size(list2017,1)==size(list,1)
%                         %         title(['k=',num2str(k),' ',char(list_title2017(k,:)),' ',data_orig(k).Header{21-1,6}])
%                         %     elseif size(list2018,1)==size(list,1)
%                         %         title(['k=',num2str(k),' ',char(list_title2018(k,:)),' ',data_orig(k).Header{21-1,6}])
%                         %     end
%                         %     legend();
%                         %     grid
%                         %     xlabel('Seconds')
%                         %     ylabel('Pu')
%                         %
%                         %
%                         %         subplot(3,1,3)
%                         %         hold on
%                         %         % plot(residual,'DisplayName',['Parameter=',num2str(theta)])
%                         %         plot(residual,'DisplayName',['Parameter='])
%                         %         hold off
%                         %         title('Residual')
%                         %         legend();
%                         %
%                         subplot(3,1,3)
%                         hold on
%                         plot(abs([data_orig(k,1).Data([1:5:9002],ndxP)-datacsv.P;data_orig(k,1).Data([1:5:9002],ndxQ)-datacsv.Q]),'DisplayName','PlayIn Orig')
%             %             plot(abs([data(k,1).Data([1:5:9002],ndxP)-datacsv.P;data(k,1).Data([1:5:9002],ndxQ)-datacsv.Q]),'DisplayName','PlayIn Fitted')
%                         hold off
%                         title('Residual (whole signal)')
%                         %     xlim([10,30])
%                         legend('Location','NorthWest')
%                         grid
        
        %         rtest(k,:)=abs([data_orig(k,1).Data([1:5:9002],ndxP)-datacsv.P;data_orig(k,1).Data([1:5:9002],ndxQ)-datacsv.Q]);
        %
        
        
        
        %
        %
        %
        %     ndxV=PWFind(data_orig(k),'Bus ',' 40287 ','V pu');
        %     figure
        %     subplot(2,1,1)
        %     hold on
        %     plot(datacsv.t1,datacsv.v1,'LineWidth',1,'DisplayName','Event')
        %     plot(data_orig(k).Data(:,1),data_orig(k).Data(:,ndxV),'LineWidth',1,'DisplayName','PlayIn Orig')
        %     plot(data.Data(:,1),data.Data(:,ndxV),'LineWidth',1,'DisplayName','PlayIn Fitted')
        %     hold off
        %     if size(list2017,1)==size(list,1)
        %         title(['k=',num2str(k),' ',char(list_title2017(k,:)),' V Plot'])
        %     elseif size(list2018,1)==size(list,1)
        %         title(['k=',num2str(k),' ',char(list_title2018(k,:)),' V Plot'])
        %     end
        %     legend();
        %     grid
        %
        %
        %     ndxF=PWFind(data_orig(k),'Bus ',' 40287 ','Frequency in PU');
        %     subplot(2,1,2)
        %     hold on
        %     plot(datacsv.t1,datacsv.f1/60,'LineWidth',1,'DisplayName','Event')
        %     plot(data_orig(k).Data(:,1),data_orig(k).Data(:,ndxF),'LineWidth',1,'DisplayName','PlayIn Orig')
        %     plot(data.Data(:,1),data.Data(:,ndxF),'LineWidth',1,'DisplayName','PlayIn Fitted')
        %     hold off
        %     if size(list2017,1)==size(list,1)
        %         title(['k=',num2str(k),' ',char(list_title2017(k,:)),' F Plot'])
        %     elseif size(list2018,1)==size(list,1)
        %         title(['k=',num2str(k),' ',char(list_title2018(k,:)),' F Plot'])
        %     end
        %     legend();
        %     grid
        %     savefig(['F:\Grad School Research\State Plots\VF Plots\VFPlot_Event',num2str(k),'.fig'])
        %
        %     ndxVang=PWFind(data_orig(k),'Bus ',' 41744 ','V angle No shift');
        %     subplot(3,1,3)
        %     hold on
        %     plot(datacsv.t1,datacsv.Vang1-datacsv.Vang1(1),'LineWidth',1,'DisplayName','Event')
        %     plot(data_orig(k).Data(:,1),unwrap((data_orig(k).Data(:,ndxVang)-data_orig(k).Data(1,ndxVang))*pi/180)*180/pi,'LineWidth',1,'DisplayName','PlayIn Orig')
        %
        % %         plot(data.Data(:,1),unwrap((data.Data(:,ndxVang)-data.Data(1,ndxVang))*pi/180)*180/pi,'LineWidth',1,'DisplayName','PlayIn Fitted')
        %         hold off
        %         title('Vang Plot')
        %         legend();
        %         grid
        
        
    end
    clear data datacsv datacsv_save final_theta output resnorm
end
