%____________________________________________________________________
%
% A U D I O    F I L T E R
%
% By: Heitor Lemos (TorRLD)
%
%_____________________________________________________________________
% The idea this algorithm is filter a record audio
% according to the choosed filter
% The filter parameters have been choosing trhough of tests
%REnter the filter number:
ans = input ("Enter 1 for LP, 2 for BP or 3 para HP\n" );
% Band-Pass
if ans == 2
printf("\nYou choosed the Band-Pass filter");
f = [ 0 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1];
s = [0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0 0 0 0 0 ];
end
%Low-Pass
if ans == 1
printf("\nYou choosed the Low-Pass filter");
f = [ 0 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1];
s = [1.0 1.0 1.0 0.0 0.0 0.0 0.0 0.0 0 0 0 0 ];
end
%High-Pass
if ans == 3
printf("\nYou choosed the High-Pass filter");
f = [ 0 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1];
s = [0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1 1 1 1 ];
end
printf("\nRecord your 5 seconds audio!");
pause(0.2); %Waiting 200 miliseconds for the audio to be record
N = 32; %Number of Taps
h = remez(N,f,s); %Function to calcule the filter
y = record(5, fs); %Grava áudio de 5 segundos e armazena a frequência de amostragem em fs
%it Record a audio of 5 seconds and stores the sample frequency in fs
sound(y,fs); %play original audio
subplot(311);
plot(y);%Plot time domain
xlabel 'Time (milliseconds)', ylabel 'Amplitude'
legend('Audio record');
title(['Audio sign"']);
[H,w] = freqz(h,1,512);%Filter Response
%The frequency is stores in w
subplot(312);
plot(w/pi,abs(H),'LineWidth',2); grid on;
title('Frequency response of choosed filter');
legend('Projected filter')
xlabel 'Frequency in radians (\omega/\pi)', ylabel 'Magnitude'
% Fourier Transform of Signal
z = conv(y,h); %Convolution between the choosed filter and the audio signal
nfft = abs(fft(y));
nfft = nfft/(length(nfft)/2);
deltaf = fs/length(nfft); %The frequency variation
freq = 0:deltaf:length(nfft)*freq_base -freq_base;
subplot(313);
plot(freq,nfft);
hold on;
p = plot((w/pi)*fs/2,abs(H)*max(nfft),'--r','LineWidth',1); grid on; hold off;
axis([0 4000 0 0.02]);
grid on;
legend('Audio specter', 'Projected filter')
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Audio signal specter');
sound(real(z),fs); % Reproduz áudio gravado filtrado
