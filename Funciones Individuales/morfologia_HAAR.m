
function [CDetail,interpolated_qrs, segmento]= morfologia_HAAR(indice)

load ('pre-ecg7_QRS_detection.mat');
load ('pre-ecg7_ECG_delineation.mat');
load ('pre-ecg7.mat');


%todas derivaciones operan con un unico QRS definido por multilead
referencia1=(wavedet.multilead.QRSon)';
referencia2=(wavedet.multilead.QRSoff)';

%algoritmo de eleccion de mejor referencia QRS proximo a promedio
periodoQRS=referencia2-referencia1;
temporal=abs(periodoQRS-mean(periodoQRS));
temporal2=min(temporal<5,[],1);

%save temporal2.mat temporal2 periodoQRS

p=length(temporal2);
segmento=0;
%Se elige ultimo segmento que cumple condicion
for i=1:1:p
    
    if(temporal2(i)==1)
        segmento=i;
    end
    
end

if(segmento==0)
segmento=5;
end
%save temporal2.mat temporal2 periodoQRS segmento




qrs=signal(referencia1(1,segmento):referencia2(1,segmento),indice); %segmento 3



%Interpolacion para incrementar resolucion de analisis
L=length(qrs);
z=1;
interpolated_qrs=zeros(1,2*L-1);

for k=1:1:L
    if k<L
        w=[qrs(k),mean([qrs(k),qrs(k+1)]),qrs(k+1)];
        interpolated_qrs(z)=w(1);
        interpolated_qrs(z+1)=w(2);
        z=z+2;
    end
end

%Transformada wavelet tipo HAAR de 2 niveles
[Cprom,CDetail]=dwt(interpolated_qrs,"haar");


end