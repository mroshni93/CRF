
function  [v]= mfcc_test2(s,fs)
%s=wav_without_unvoiced(s,fs);
% The function computed the mfcc output of the input signal s sampled at fs
%    s:    Samples
%    fs:   Sampling rate
%fs=100;
N=0.02*fs;                    % size of each frame
%M=156;
M=0.01*fs;                      % overlap size
nof=40;                     % number of filters
len=floor(length(s)/(N-M));          
         
 %The number of times for loop is to be run  ;                                
a(1:N,1:len)=0;             % framing the signal with overlap
 
% initialization of the first chunk
a(:,1)=s(1:N);
x=N-M;
 h= hamming(N);
 
for j=2:len
 a(:,j)=s(x*(j-2)+1:x*(j-2)+N);
 
%    a(:,j)=s(x*j-1:x*j+N);
    end;
   
    for j=1:len;
   b(:,j)= a(:,j).* h;
end
% computes the mel filter bank coeffs
 %m=melfilterbank(nof,N,fs);         % normailising to mel freq
% The computation of the cepstrum coefficients
% The computation of the cepstrum coefficients
%m=melfilterbank(nof,N,fs); 
m=melfilterbank(nof,N,fs); 
 
for j=1:len
    y(:,j)=fft(b(:,j));            % calculating fft
    n2 = 1 + floor(N/2);        % adjust the dimensions of the vector y for mel filter banks
    ms = m * abs(y(1:n2,j)).^2;  % applies the mel filter bank
    v(:,j)=dct(log(ms));                  % converting back to time domain
end
 
v(1,:)=[];
 
file1 = fopen('sil6.txt','w');
%fprintf(file1,'%6s %12s\n','x','exp(x)');
fprintf(file1,'  %f',v);
fclose(file1);
save('hello','v');
 
 
%v(:,j)=[];
