% Codigo que permite el contraste de matriz de reporte
% con matriz patron, dentro de un analisis de filas y
% columnas, permitiendo identidicador indicadores y 
% calcular metricas de desempeño de algoritmo
clc, clear all, close all;
load patron.mat patron
load reporte.mat reporte
fpositivo=0;
vpositivo=0;
fnegativo=0;
vnegativo=0;
contador=0;
tpositivo=0;
tnegativo=0;

%analisis de exactitud (plantilla cuadrada)
for columnas=1:1:12
    for filas=1:1:26
        
        if(patron(filas,columnas)==reporte(filas,columnas))
            contador=contador+1;
        end
        
    end
    
end

exactitud=(contador/312)*100;
%***********************************************
%total de positivos
for columnas=1:1:12
    for filas=1:1:26
        
        if(patron(filas,columnas)==1)
            tpositivo=tpositivo+1;
        end
        
    end
    
end

%***********************************************
%analisis de falso positivos (positivo = 1)

for columnas=1:1:12
    for filas=1:1:26
        
        if(patron(filas,columnas)==1)
            if(patron(filas,columnas)==reporte(filas,columnas))
            vpositivo=vpositivo+1;
            else 
            fnegativo=fnegativo+1;
            end
        end
        
    end   
end

%************************-------------****
%total de nagetivos
for columnas=1:1:12
    for filas=1:1:26
        
        if(patron(filas,columnas)==0)
            tnegativo=tnegativo+1;
        end       
    end    
end

%***********************************************
%analisis de falso positivos (positivo = 1)
for columnas=1:1:12
    for filas=1:1:26
        
        if(patron(filas,columnas)==0)
            if(patron(filas,columnas)==reporte(filas,columnas))
            vnegativo=vnegativo+1;
            else 
            fpositivo=fpositivo+1;
            end
        end       
    end   
end

mconfusion=zeros(3,3);
mconfusion(2,2)=vpositivo;
mconfusion(3,2)=fnegativo;
mconfusion(2,3)=fpositivo;
mconfusion(3,3)=vnegativo;

precision=(vpositivo/(vpositivo+fpositivo));
recall=(vpositivo/(vpositivo+fnegativo));

fscore=2*((precision*recall)/(precision+recall));
fscore2=fscore*100;
precision2=precision*100;
recall2=recall*100;

especifico=100*(vnegativo/(vnegativo+fpositivo));

%impresion resultados
fprintf('INDICADORES DEL ALGORITMO\n');
fprintf('-------------------------\n');
fprintf('La sensitividad es: %d\n', round(recall2));
fprintf('La especificidad es: %d\n',round(especifico));
fprintf('La exactitud es: %d\n',round(exactitud));
fprintf('La precision es: %d\n',round(precision2));
fprintf('F-score es: %d\n ',round(fscore2));
fprintf('-------------------------\n\n');
disp(mconfusion)

