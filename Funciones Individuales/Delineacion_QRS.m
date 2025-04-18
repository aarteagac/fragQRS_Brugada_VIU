%% ******************* LECTURA, PRE-PROCESAMIENTO Y GUARDADO ECG **********
% =========================================================================

%limpieza completa
clc, clear all, close all;

%creacion de objeto tipo ECG
ECG1 = ECGwrapper('recording_name','F:\Ingenieria Biomedica - VIU\Codigo Brugada\Signal ECG\BH0010004.ecg');

[signal,t] = pre_procesamientoECG(ECG1);

%% ********** DETECCION COMPLEJO QRS (LIBRERIA ECG-KIT) *******************
% =========================================================================
deteccion_ECG();

% *********** MUESTRA QRS PRE-DETECTADO SEGUN CANAL REFERENCIA ***********
% =========================================================================
load ('pre-ecg7_QRS_detection.mat')
 %fs = ECG.ECG_header.freq;
% Se extrae la señal ECG completa y se usará lead II, s(:,2)
s = ECG1.read_signal(1,ECG.ECG_header.nsamp);
% ADC gain 
%gain = ECG.ECG_header.gain(1);
%s = double(s)/(gain/1e-6);  % int16 2 double and escalado en mV  ADC gain/units
%s = s/1000;
N=length(s);

%creacion de vector de tiempo para normalizacion
%t=(1:N)/fs';
t=(1:N)';

%############# referencia del canal 2 #####################################

m=max(s(:,1));  % amplitud máxima del lead II
%figure(4)  % Tomaremos la derivación II
%plot(t,s(:,2),tq,m,'ro')   %equivale a plot(t,s(:,2),tq,m*ones(Nb,1),'ro')
%tw = wavedet_I.time; % QRS detectados por wavelets (Martinez, IEEE TBM, 2004)
tp = pantom_I.time; % QRS detectados por Pan-Tompkins (Pan-Tompkins, IEEE TBE, 1985)


%Muestra imagen de señal de canal II junto a marcadores QRS tipo 
%wavedet (reciente) y pan_tompkins (antiguo)
% marcadores visuales de color azul con icono de tipo diamante 
% Tiplo blue diamond ('bd')
% tipo negro estrella('k*)

%figure(777);
%plot(t,s(:,1),tp,m,'ro');

%Se observa similitud de deteccion QRS entre ambos marcadores con
%ligera...desviacion
%plot(t,s(:,2),tw,m,'bd',tp,m,'k*');
%figure(2);
%
%plot(t,s(:,7),tw,m,'bd');
% %% ######################## PENDIENTE DE ANALISIS (COMPLEJO RR ECG)####
% R = wavedet_II.time;
% %Deteccion de completo RR entre 2 señales continuas
% RR = diff(R);
% [fRR]=filter12(RR);
% tR = R(2:end);




%% *********** DELINEACION COMPLEJO QRS (ECG-KIT)**************************
% =========================================================================
% Delineacion significa segmentar latido detectado mediante identificacion
% del complejo QRS en sus partes Onda P, Onda QRS, Onda T



delete('pre-ecg7_ECG_delineation.mat');

%%

%Delineacion empleando marcado tipo wavedet - Martinez 2004 TBM - IEEE
ECG = ECGwrapper('recording_name','pre-ecg7.mat','output_path','F:\Ingenieria Biomedica - VIU\Codigo Brugada');
ECG.ECGtaskHandle = 'ECG_delineation';
ECG.Run;

%Carga de archivo delineacion devuelto por libreria para visualizacion
load('pre-ecg7_ECG_delineation.mat')

% Buscamos los resultados de QRSon y Toff en lead II (Analisis canal II)
QRSon = wavedet.V2.QRSon;

%Toff = wavedet.I.Toff;  %Toff
QRSoff= wavedet.V2.QRSoff;
%definicion de numero de latidos
Nb=length(QRSon) %Numero de beats detectados



m=max(s(:,8));  % amplitud máxima del lead II:2 (V1: 7)
mi =min(s(:,8)); % amplitud mínima de lead II: 2  (V1: 7)
pp=[m*ones(1,Nb);mi*ones(1,Nb)]; %Para plotear rectas verticales entre mi y m
Qplot = [QRSon;QRSon];
Qplot2 = [QRSoff;QRSoff];

fs = ECG.ECG_header.freq;
figure(3);


plot(t/fs,s(:,8),'K',tp/fs,m,'bh',Qplot/fs,pp,'r--',Qplot2/fs,pp,'r--')
xlabel('tiempo (s)'), title('Pre-cordial derecho V1');



%%%% crear indice para representar derivacion y a su vez permita imprimir
%%%% en el texto

title(ECG.ECG_header.recname);
set(gca,'Color',"#f6d7d8 ")
grid on, grid minor, axis tight;








