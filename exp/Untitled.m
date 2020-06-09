% num1=35;den1=myconv([1,0],[0.2,1]);
% Pn=tf(num1,den1);
% Qgen(3,2,tau)

input = out.dataset.signals(1).values;
output = out.dataset.signals(2).values;
t = out.tout;


function sys = Qgen(N,r,tau)
den=1;
for k=1:N
    den=conv(den,[tau,1]);
end
for k=0:N-r
   num(N-r+1-k)=tau^k*factorial(N)/(factorial(N-k));
end
sys=tf(num,den);
end