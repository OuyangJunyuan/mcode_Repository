clear all;


N=120;
CON=25;
Xexpect=CON*ones(1,N);
X=zeros(1,N);
Xkf=zeros(1,N);
Z=zeros(1,N);
P=zeros(1,N);

%����ֵ
X(1)=25.1;
P(1)=0.01;
Z(1)=24.9;
Xkf(1)=Z(1);

%����
Q=0.01;
R=0.25;
W=sqrt(Q)*randn(1,N);   %�������������С
V=sqrt(R)*randn(1,N);   %�������������С

%ϵͳ����
F=1;
G=1;
H=1;
I=eye(1);   %��ϵͳ״̬Ϊһά


%ģ�ⷿ���¶ȼ��������̣����˲�
for k=2:N
    %��һ������ʱ�����ƣ�������ʵ�¶Ȳ����仯
    %kʱ�̵���ʵ�¶ȣ��¶ȼ��ǲ�֪���ģ�������������ʵ���ڵģ��������Ҫ�����Ӳ���������������ʵ�¶�
    X(k)=F*X(k-1)+G*W(k-1);
    
    %�ڶ���������ʱ�����ƣ���ȡʵʱ����
    %�¶ȼƶ�kʱ�̷����¶ȵĲ�����Kalman�˲���վ���¶ȼƽǶȽ��еġ�
    %����֪���˿���ʵ�¶ȣ�ֻ��վ�ڱ��β���ֵ����һ�ι���ֵ������������Ŀ��������޶Ƚ��Ͳ�������R��Ӱ�졣�����ܵıƽ�X��k);
    Z(k)=H*X(k)+V(k);
    
    %���������������˲���
    %����kʱ�̵Ĺ۲��k-1ʱ�̵�״̬�Ϳ����˲��ˡ�
    X_pre=F*Xkf(k-1);      %״̬Ԥ��
    P_pre=F*P(k-1)*F'+Q;    %Э����Ԥ��
    Kg=P_pre*inv(H*P_pre*H'+R); %���㿨��������
    e=Z(k)-H*X_pre;     %��Ϣ
    Xkf(k)=X_pre+Kg*e;  %״̬����
    P(k)=(I-Kg*H)*P_pre;    %Э�������
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%�������
Err_Messure=zeros(1,N); %����ֵ����ʵֵ֮���ƫ��
Err_Kalman=zeros(1,N);  %����ֵ����ʵֵ֮���ƫ��
for k=1:N
    Err_Messure=abs(Z(k)-X(k));
    Err_Kalman=abs(Xkf(k)-X(k));
end



t=1:N;
figure; %��ͼ��ʾ
%�����������ֵ�����ӹ�����������ʵֵ
%�¶ȼƲ���ֵ������������ֵ
plot(t,Xexpect,'-b',t,X,'-r',t,Z,'-ko',t,Xkf,'-g*');
%plot(t,X,'-r',t,Xkf,'-g*');
legend('����ֵ','��ʵֵ','�۲�ֵ','�������˲�ֵ');
%legend('��ʵֵ','�������˲�ֵ');
xlabel('����ʱ��/s');
ylabel('�¶�ֵ/c');

%������ͼ
figure %��ͼ��ʾ
plot(t,Err_Messure,'-b',t,Err_Kalman,'-k*');
legend('����ƫ��','�������˲�ƫ��');
xlabel('����ʱ��/s');
ylabel('�¶�ֵ/c');