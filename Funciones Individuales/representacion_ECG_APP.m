function [t,signal_estrella,tp,fs,Qplot,Qplot2,m,mi,pp] = representacion_ECG_APP(signal,fs,t,indice)

load ('pre-ecg7_QRS_detection.mat');
load ('pre-ecg7_ECG_delineation.mat');

switch indice
    case 1
        tp = pantom_I.time; %marcador tompankins
        QRSon = wavedet.I.QRSon; %segmentacion QRS 1
        QRSoff= wavedet.I.QRSoff;%segmentacion QRS 2
        signal_estrella=signal(:,1);
        
    case 2
        tp = pantom_II.time; %marcador tompankins
        QRSon = wavedet.II.QRSon; %segmentacion QRS 1
        QRSoff= wavedet.II.QRSoff;%segmentacion QRS 2
        signal_estrella=signal(:,2);
        
    case 3
        tp = pantom_III.time; %marcador tompankins
        QRSon = wavedet.III.QRSon; %segmentacion QRS 1
        QRSoff= wavedet.III.QRSoff;%segmentacion QRS 2
        signal_estrella=signal(:,3);
        
    case 4
        tp = pantom_aVL.time; %marcador tompankins
        QRSon = wavedet.aVL.QRSon; %segmentacion QRS 1
        QRSoff= wavedet.aVL.QRSoff;%segmentacion QRS 2
        signal_estrella=signal(:,4);
        
    case 5
        tp = pantom_aVR.time; %marcador tompankins
        QRSon = wavedet.aVR.QRSon; %segmentacion QRS 1
        QRSoff= wavedet.aVR.QRSoff;%segmentacion QRS 2
        signal_estrella=signal(:,5);
        
    case 6
        tp = pantom_aVF.time; %marcador tompankins
        QRSon = wavedet.aVF.QRSon; %segmentacion QRS 1
        QRSoff= wavedet.aVF.QRSoff;%segmentacion QRS 2
        signal_estrella=signal(:,6);
        
    case 7
        tp = pantom_V1.time; %marcador tompankins
        QRSon = wavedet.V1.QRSon; %segmentacion QRS 1
        QRSoff= wavedet.V1.QRSoff;%segmentacion QRS 2
        signal_estrella=signal(:,7);
        
    case 8
        tp = pantom_V2.time; %marcador tompankins
        QRSon = wavedet.V2.QRSon; %segmentacion QRS 1
        QRSoff= wavedet.V2.QRSoff;%segmentacion QRS 2
        signal_estrella=signal(:,8);
        
    case 9
        tp = pantom_V3.time; %marcador tompankins
        QRSon = wavedet.V3.QRSon; %segmentacion QRS 1
        QRSoff= wavedet.V3.QRSoff;%segmentacion QRS 2
        signal_estrella=signal(:,9);
        
    case 10
        tp = pantom_V4.time; %marcador tompankins
        QRSon = wavedet.V4.QRSon; %segmentacion QRS 1
        QRSoff= wavedet.V4.QRSoff;%segmentacion QRS 2
        signal_estrella=signal(:,10);
        
   case 11
        tp = pantom_V5.time; %marcador tompankins
        QRSon = wavedet.V5.QRSon; %segmentacion QRS 1
        QRSoff= wavedet.V5.QRSoff;%segmentacion QRS 2
        signal_estrella=signal(:,11);
        
   case 12
        tp = pantom_V6.time; %marcador tompankins
        QRSon = wavedet.V6.QRSon; %segmentacion QRS 1
        QRSoff= wavedet.V6.QRSoff;%segmentacion QRS 2
        signal_estrella=signal(:,12);
end



tp = pantom_I.time; %marcador tompankins
QRSon = wavedet.I.QRSon; %segmentacion QRS 1
QRSoff= wavedet.I.QRSoff;%segmentacion QRS 2

Nb=length(QRSon); %Numero de beats detectados
m=max(signal_estrella);
mi=min(signal_estrella);
pp=[m*ones(1,Nb);mi*ones(1,Nb)]; %Para plotear rectas verticales entre mi y m
Qplot = [QRSon;QRSon];
Qplot2 = [QRSoff;QRSoff];


end

