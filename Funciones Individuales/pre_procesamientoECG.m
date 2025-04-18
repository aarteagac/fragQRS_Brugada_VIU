
function [signal,N,t,fs,ECGs_original] = pre_procesamientoECG(signalECG12)
%==========================================================================
% Funcion que permite realizar el pre-procesamiento de una señal ECG,
% basado en las siguientes caracteristicas:
%
%
% Usando libreria ECG KIT
%==========================================================================

ECG=signalECG12; %intercambio de contenido pseudonimo

%lectura de objeto ECG en totalidad muestras
cantidad.muestras=ECG.ECG_header.nsamp;
ECGs = ECG.read_signal(1,cantidad.muestras);  

%Ajuste de resolucion y unidades de señal ECG
% Output in ADC units and int16 format
ECGs = double(ECGs);   % signals in int16 --> float
ECGs_original=ECGs;
gain = ECG.ECG_header.gain; % gain=4e-4 -> 1/2500 (Resolution = 2500 nV)
fs = ECG.ECG_header.freq; % Sampling frequency
baseline= ECG.ECG_header.adczero;
[N,leads]=size(ECGs);
%Convert to Physical units (by default nV)
for i=1:leads
    ECGs(:,i) = (ECGs(:,i)-baseline(i))/gain(i);
end
% Units in nV (nanoVolts) --> mV (*1e-6)
ECGs = ECGs.*1e-6;   % units in mV

%eliminacion de offset en canales ECG (offset=0)
ECGs = detrend(ECGs);
%creacion de vector de tiempo para normalizacion
t=(1:N)/fs';

%eliminacion de ruido de lineabase de tipo wander presente en ECG
%uso de filtro de tipo recursivo IIR de fase 0 (Ida y vuelta)
% Filtro pasa alto IIR Butterworth orden 3, fc = 0.3 Hz, forward-backward

fN = fs/2;  %frecuencia de nyquist
fc1=0.6;  %frecuencia de corte

% filtro en 1 sentido
[bfpa,afpa]=butter(3,fc1/fN,'high');
signal=filtfilt(bfpa,afpa,ECGs);
% filtro en 2 sentido
[bfpb,afpb]=butter(3,40/fN);
signal=filtfilt(bfpb,afpb,signal);

%vector signal contiene las 12 derivaciones de señal ECG
N= length(signal);
%creacion de vector de tiempo para normalizacion
t=(1:N)/fs';

%almacen señal ECG de 12 derivaciones pre-procesada
header=ECG.ECG_header;
header.nsamp=N;
delete('pre-ecg7.mat')

save pre-ecg7.mat signal header  %salvado

%################ IMPORTANTE ##############################################
%muestra de señales normalizadas en orden de mV (Milivoltios)
%Objeto de tipo vector ECGs(filas, columnas) contiene :
% filas = cantidad de muestras
% columnas = canales ECG (7-precordial v1, 8-precordial v2, 9-precordial v3
% para analisis de sindrome de brugada nos centramos en los 3 ...
% precordiales derechos v1, v2 y v3.
%##########################################################################











end

