
clear;
w=[2 4 6]; %��Ʒ����
c=[3 10 12]; %��Ʒ��ֵ

M=11; % ����������

x=zeros(1,3); % ��ʼ��
n=size(x,2);
f=0;
m=0;
L=100*n; % Mapkob ����
for i=1:n
f=f+c(i)*x(i);
m=m+w(i)*x(i);
end

t0=500; % ���Ʋ���t�ĳ�ֵ 
t=t0;
tf=0.95; % ˥��������ϵ��

e=0.00001;
tic % �������еĳ�ʼ,�˴���Ϊ�˼���������е�ʱ��ͳ����β��toc��Ӧ

while t>e 

for k=1:L
i=round(rand*(n-1))+1;
if x(i)==0
if m+w(i)<=M
x(i)=1;f=f+c(i);m=m+w(i);
else
j=round(rand*(n-1))+1;
while x(j)==0
j=round(rand*(n-1))+1;
end
df=c(i)-c(j);dm=w(i)-w(j);
if m+dm<=M % ����׼��
if (df>0)|(exp(df/t)>rand)
x(i)=1;x(j)=0;f=f+df;m=m+dm;
end
end
end
else
j=round(rand*(n-1))+1;
while x(j)==1
j=round(rand*(n-1))+1;
end
df=c(j)-c(i);dm=w(j)-w(i);
if m+dm<=M 
if (df>0)|(exp(df/t)>rand)
x(i)=0;x(j)=1;f=f+df;m=m+dm;
end
end
end
end
t=t*tf; %˥������

f_max=f;
end

f_max
toc %�������еĽ�β���ó����е�ʱ�� 
