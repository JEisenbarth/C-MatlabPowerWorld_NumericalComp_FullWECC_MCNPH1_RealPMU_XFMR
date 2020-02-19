function [residual,J] = residual_Jacobian_PowerWorld_RealPMU_MCNPH1(theta,theta_indicies,index,data_event,filenamedyd,gentpj,esst1a,pss1a,ieeeg3,XFMR1,XFMR2,PQ_Flag,SimAuto,percentnominal,filename_RunAux,filename_PlayInCase,filename_SetupAux,Ipmu,Vpmu)
%residual_Jacobian_PowerWorld This function calculates the P, Q, or PQ residual based on a given theta.
%   PQ_Flag=0 then use P Residual
%   PQ_Flag=1 then use Q Residual
%   PQ_Flag=2 then use PQ Residual

%% Get nominal thetas for later Jacobian calculations
theta_nominal=zeros(size(theta));
for m=1:length(theta)
    if theta_indicies(m,1)==1
        theta_nominal(m)=gentpj(index.gentpj(theta_indicies(m,2)));
    elseif theta_indicies(m,1)==2
        theta_nominal(m)=esst1a(index.esst1a(theta_indicies(m,2)));
    elseif theta_indicies(m,1)==3
        theta_nominal(m)=pss1a(index.pss1a(theta_indicies(m,2)));
    elseif theta_indicies(m,1)==4
        theta_nominal(m)=ieeeg3(index.ieeeg3(theta_indicies(m,2)));
    elseif theta_indicies(m,1)==5
        theta_nominal(m)=XFMR1(index.XFMR1(theta_indicies(m,2)));
    elseif theta_indicies(m,1)==6
        theta_nominal(m)=XFMR2(index.XFMR2(theta_indicies(m,2)));
    end
end
delta=percentnominal;

%% Put thetas into model for original residual calc.
for m=1:length(theta)
    if theta_indicies(m,1)==1
        gentpj(index.gentpj(theta_indicies(m,2)))=theta(m);
    elseif theta_indicies(m,1)==2
        esst1a(index.esst1a(theta_indicies(m,2)))=theta(m);
    elseif theta_indicies(m,1)==3
        pss1a(index.pss1a(theta_indicies(m,2)))=theta(m);
    elseif theta_indicies(m,1)==4
        ieeeg3(index.ieeeg3(theta_indicies(m,2)))=theta(m);
    elseif theta_indicies(m,1)==5
        XFMR1(index.XFMR1(theta_indicies(m,2)))=theta(m);
    elseif theta_indicies(m,1)==6
        XFMR2(index.XFMR2(theta_indicies(m,2)))=theta(m);
    end
end
theta
%% Write dyd and run simulation
[data]=PowerWorld_WriteDYD_Run_MCNPH1_RealPMU(filenamedyd,gentpj,esst1a,pss1a,ieeeg3,XFMR1,XFMR2,SimAuto,filename_RunAux,filename_PlayInCase,filename_SetupAux,Ipmu,Vpmu);

%% Determine Event Type and set eventlength
if data_event.event_type=="125 MW Square-wave Pulse";
    eventlength=17;
end
if data_event.event_type=="CJ Brake Pulse";
    eventlength=10;
end


%% Get rid of data before event start and after event start plus eventlength sec for fitting
B=all((data.Data(:,1)>=data_event.tevent)&(data.Data(:,1)<=data_event.tevent+eventlength),2);
data.Data=data.Data(B,:);
B=all((round(data_event.t1,8)>=data_event.tevent)&(round(data_event.t1,8)<=data_event.tevent+eventlength),2);
data_event.t1=data_event.t1(B);
data_event.P=data_event.P(B);
data_event.Q=data_event.Q(B);

%% Down sample from pslf defoult Ts to 1/60 sec like pmu data
ndxkeep=1:5:length(data.Data);
data.Data=data.Data([ndxkeep],:);

%% Find indicies for residual calculations then calc residual.
ndxP=PWFind(data,'Branch ',' 44122 44115 1 ','MW From');
ndxQ=PWFind(data,'Branch ',' 44122 44115 1 ','Mvar From');

%% Subtract the Mean of P and Q from P and Q.
data.Data(:,ndxP)=data.Data(:,ndxP)-mean(data.Data(:,ndxP));
data.Data(:,ndxQ)=data.Data(:,ndxQ)-mean(data.Data(:,ndxQ));

data_event.P=data_event.P-mean(data_event.P);
data_event.Q=data_event.Q-mean(data_event.Q);

%% Calculate residual based on PQ_Flag.
if(PQ_Flag==0)
    residual=data_event.P-data.Data(:,ndxP);
elseif(PQ_Flag==1)
    residual=data_event.Q-data.Data(:,ndxQ);
elseif(PQ_Flag==2)
    residual=[data_event.P;data_event.Q]-[data.Data(:,ndxP);data.Data(:,ndxQ);];
end

%% Calculate Residual for Jacobian Calculations.
for x=1:length(theta)
    %% Put thetas into model so can change a single parameter for Jacobian Calculations.
    for m=1:length(theta)
        if theta_indicies(m,1)==1
            gentpj(index.gentpj(theta_indicies(m,2)))=theta(m);
        elseif theta_indicies(m,1)==2
            esst1a(index.esst1a(theta_indicies(m,2)))=theta(m);
        elseif theta_indicies(m,1)==3
            pss1a(index.pss1a(theta_indicies(m,2)))=theta(m);
        elseif theta_indicies(m,1)==4
            ieeeg3(index.ieeeg3(theta_indicies(m,2)))=theta(m);
        elseif theta_indicies(m,1)==5
            XFMR1(index.XFMR1(theta_indicies(m,2)))=theta(m);
        elseif theta_indicies(m,1)==6
            XFMR2(index.XFMR2(theta_indicies(m,2)))=theta(m);
        end
    end
    
    %% Change only one parameter by delta based on k for loop
    if theta_indicies(x,1)==1
        gentpj(index.gentpj(theta_indicies(x,2)))=theta(x)+delta(x);
    elseif theta_indicies(x,1)==2
        esst1a(index.esst1a(theta_indicies(x,2)))=theta(x)+delta(x);
    elseif theta_indicies(x,1)==3
        pss1a(index.pss1a(theta_indicies(x,2)))=theta(x)+delta(x);
    elseif theta_indicies(x,1)==4
        ieeeg3(index.ieeeg3(theta_indicies(x,2)))=theta(x)+delta(x);
    elseif theta_indicies(x,1)==5
        XFMR1(index.XFMR1(theta_indicies(x,2)))=theta(x)+delta(x);
    elseif theta_indicies(x,1)==6
        XFMR2(index.XFMR2(theta_indicies(x,2)))=theta(x)+delta(x);
        
    end
    
    %% Write dyd and run simulation for residual for Jacobian calc.
    [data_Jacobian]=PowerWorld_WriteDYD_Run_MCNPH1_RealPMU(filenamedyd,gentpj,esst1a,pss1a,ieeeg3,XFMR1,XFMR2,SimAuto,filename_RunAux,filename_PlayInCase,filename_SetupAux,Ipmu,Vpmu);
    %% Get rid of data before event start and after event start plus eventlength sec for fitting
    B=all((data_Jacobian.Data(:,1)>=data_event.tevent)&(data_Jacobian.Data(:,1)<=data_event.tevent+eventlength),2);
    data_Jacobian.Data=data_Jacobian.Data(B,:);
    
    %% Down sample from pslf defoult Ts to 1/60 sec like pmu data
    ndxkeep=1:5:length(data_Jacobian.Data);
    data_Jacobian.Data=data_Jacobian.Data([ndxkeep],:);
    
    %% Find indicies for residual calculations then calc residual.
    ndxP=PWFind(data_Jacobian,'Branch ',' 44122 44115 1 ','MW From');
    ndxQ=PWFind(data_Jacobian,'Branch ',' 44122 44115 1 ','Mvar From');
    
    %% Subtract the Mean of P and Q from P and Q.
    data_Jacobian.Data(:,ndxP)=data_Jacobian.Data(:,ndxP)-mean(data_Jacobian.Data(:,ndxP));
    data_Jacobian.Data(:,ndxQ)=data_Jacobian.Data(:,ndxQ)-mean(data_Jacobian.Data(:,ndxQ));

    %% Calculate residual based on PQ_Flag.
    if(PQ_Flag==0)
        r(:,x)=data_event.P-data_Jacobian.Data(:,ndxP);
    elseif(PQ_Flag==1)
        r(:,x)=data_event.Q-data_Jacobian.Data(:,ndxQ);
    elseif(PQ_Flag==2)
        r(:,x)=[data_event.P;data_event.Q]-[data_Jacobian.Data(:,ndxP);data_Jacobian.Data(:,ndxQ);];
    end
    
    J(:,x)=(r(:,x)-residual)/delta(x);
    
    %% Change parameter back to original on k for loop
    if theta_indicies(x,1)==1
        gentpj(index.gentpj(theta_indicies(x,2)))=theta(x);
    elseif theta_indicies(x,1)==2
        esst1a(index.esst1a(theta_indicies(x,2)))=theta(x);
    elseif theta_indicies(x,1)==3
        pss1a(index.pss1a(theta_indicies(x,2)))=theta(x);
    elseif theta_indicies(x,1)==4
        ieeeg3(index.ieeeg3(theta_indicies(x,2)))=theta(x);
    elseif theta_indicies(x,1)==5
        XFMR1(index.XFMR1(theta_indicies(x,2)))=theta(x);
    elseif theta_indicies(x,1)==6
        XFMR2(index.XFMR2(theta_indicies(x,2)))=theta(x);
    end
    
end
%
% figure
% plot(J)
% mean(J)

% % Plot Check
% figure
% subplot(3,1,1)
% hold on
% plot(data_event.t1,data_event.P,'LineWidth',1,'DisplayName','Event')
% plot(data.Data(:,1),data.Data(:,ndxP),'LineWidth',1,'DisplayName','PlayIn')
% hold off
% 
% title([num2str(data_event.datatimes(1)),' to ',num2str(data_event.datatimes(2)),' P Plot'])
% % title('P Plot')
% legend();
% grid
% 
% subplot(3,1,2)
% hold on
% plot(data_event.t1,data_event.Q,'LineWidth',1,'DisplayName','Event')
% plot(data.Data(:,1),data.Data(:,ndxQ),'LineWidth',1,'DisplayName','PlayIn')
% hold off
% title('Q Plot')
% legend();
% grid
% 
% subplot(3,1,3)
% hold on
% 
% plot(abs(residual),'DisplayName',['Parameter='])
% hold off
% title('Residual')
% legend();
% grid
% % 
% % % ndxV=PWFind(data,'Bus ',' 44122 ','V pu');
% % % figure
% % % subplot(3,1,1)
% % % hold on
% % % plot(data_event.t1,data_event.v1,'LineWidth',1,'DisplayName','Event')
% % % plot(data.Data(:,1),data.Data(:,ndxV),'LineWidth',1,'DisplayName','PlayIn')
% % % hold off
% % % title('V Plot')
% % % legend();
% % % grid
% % %
% % % ndxF=PWFind(data,'Bus ',' 44122 ','Frequency in PU');
% % % subplot(3,1,2)
% % % hold on
% % % plot(data_event.t1,data_event.f1/60,'LineWidth',1,'DisplayName','Event')
% % % plot(data.Data(:,1),data.Data(:,ndxF),'LineWidth',1,'DisplayName','PlayIn')
% % % hold off
% % % title('F Plot')
% % % legend();
% % % grid
% % %
% % % ndxVang=PWFind(data,'Bus ',' 44122 ','V angle No shift');
% % % subplot(3,1,3)
% % % hold on
% % % plot(data_event.t1,data_event.Vang1-data_event.Vang1(1),'LineWidth',1,'DisplayName','Event')
% % % plot(data.Data(:,1),unwrap((data.Data(:,ndxVang)-data.Data(1,ndxVang))*pi/180)*180/pi,'LineWidth',1,'DisplayName','PlayIn')
% % % hold off
% % % title('Vang Plot')
% % % legend();
% % % grid
% % % %

end