%limpieza completa
clc, clear all, close all;

%% ********** PRE-PROCESAMIENTO ECG (LIBRERIA ECG-KIT)* *******************
% =========================================================================
%creacion de objeto tipo ECG
ECG1 = ECGwrapper('recording_name','F:\Ingenieria Biomedica - VIU\Codigo Brugada\Signal ECG\BH0010004.ecg');

[signal,N,t,fs] = pre_procesamientoECG(ECG1);

%% ********** DETECCION COMPLEJO QRS (LIBRERIA ECG-KIT) *******************
% =========================================================================
deteccion_ECG();

%% *********** SEGMENTACION COMPLEJO QRS (ECG-KIT)**************************
% =========================================================================
% Delineacion significa segmentar latido detectado mediante identificacion
% del complejo QRS en sus partes Onda P, Onda QRS, Onda T
segmentacion_ECG();

%% GRAFICACION

representacion_ECG(signal,fs,t,4);








