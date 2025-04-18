function [] = deteccion_ECG()

delete('pre-ecg7_QRS_detection.mat');

ECG2 = ECGwrapper('recording_name','pre-ecg7.mat','output_path','F:\Ingenieria Biomedica - VIU\Codigo Brugada');
ECG2.ECGtaskHandle = 'QRS_detection';
ECG2.ECGtaskHandle.detectors = {'pantom'};
ECG2.Run;

end

