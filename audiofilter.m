%____________________________________________________________________
%
% A U D I O    F I L T E R
%
% By: Heitor Lemos (TorRLD)
%_____________________________________________________________________
% A ideia deste algoritmo é filtrar um áudio gravado
% de acordo com o filtro escolhido
%Recebe o número correspondente ao tipo de filtro:
ans = input ("Escolha 1 para PB, 2 PARA PF ou 3 para PA\n" );
% Filtro Passa-faixa (médios)
if ans == 2
printf("\nVocê escolheu o filtro Passa-faixa");
f = [ 0 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1];
s = [0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0 0 0 0 0 ];
end
%Filtro Passa-baixa (graves)
if ans == 1
printf("\nVocê escolheu o filtro Passa-baixa");
f = [ 0 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1];
s = [1.0 1.0 1.0 0.0 0.0 0.0 0.0 0.0 0 0 0 0 ];
end
%Filtro Passa-alta (agudos)
if ans == 3
printf("\nVocê escolheu o filtro Passa-alta");
f = [ 0 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1];
s = [0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1 1 1 1 ];
end
printf("\nGrave seu áudio de 5 segundos!");
pause(0.2); %espera 200 milisegundos para o áudio ser gravado
N = 32; %Número de Taps
h = remez(N,f,s); %Função responsável por calcular o filtro
y = record(5, fs); %Grava áudio de 5 segundos e armazena a frequência de amostragem em fs
sound(y,fs); %reproduz arquivo de áudio original
subplot(311);
plot(y);%plota gráfico do sinal de áudio no domínio t
xlabel 'Tempo em milisegundos', ylabel 'Amplitude'
legend('Gravação do áudio');
title(['Sinal de áudio"']);
[H,w] = freqz(h,1,512);%Resposta em frequência do Filtro
%frequencia armazenada na variável w
subplot(312);
plot(w/pi,abs(H),'LineWidth',2); grid on;
title('Resposta em frequência do Filtro escolhido');
legend('Filtro projetado')
xlabel 'Frequencia em radianos (\omega/\pi)', ylabel 'Magnitude'
% Calculo da transformada de Fourier do sinal
z = conv(y,h); %Convolução do sinal de áudio e do filtro escolhido
nfft = abs(fft(y));
nfft = nfft/(length(nfft)/2);
deltaf = fs/length(nfft); %A variação de frequência entre cada valor
freq = 0:deltaf:length(nfft)*freq_base -freq_base;
subplot(313);
plot(freq,nfft);
hold on;
p = plot((w/pi)*fs/2,abs(H)*max(nfft),'--r','LineWidth',1); grid on; hold off;
axis([0 4000 0 0.02]);
grid on;
legend('Espectro do áudio', 'Filtro projetado')
xlabel('Frequência (Hz)');
ylabel('Ampliturde');
title('Espectro do sinal de áudio');
sound(real(z),fs); % Reproduz áudio gravado filtrado
