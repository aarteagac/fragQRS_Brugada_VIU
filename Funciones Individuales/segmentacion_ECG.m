function [] = segmentacion_ECG()

delete('pre-ecg7_ECG_delineation.mat');

%%

%Delineacion empleando marcado tipo wavedet - Martinez 2004 TBM - IEEE
ECG = ECGwrapper('recording_name','pre-ecg7.mat','output_path','F:\Ingenieria Biomedica - VIU\Codigo Brugada');
ECG.ECGtaskHandle = 'ECG_delineation';
ECG.Run;










end

