
clear;
w=[2 4 6]; %物品重量
c=[3 10 12]; %物品价值

M=11; % 背包总容量

x=zeros(1,3); % 初始解
n=size(x,2);
f=0;
m=0;
L=100*n; % Mapkob 链长
for i=1:n
f=f+c(i)*x(i);
m=m+w(i)*x(i);
end

t0=500; % 控制参数t的初值 
t=t0;
tf=0.95; % 衰减函数的系数

e=0.00001;
tic % 程序运行的初始,此处是为了计算程序运行的时间和程序结尾的toc对应

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
if m+dm<=M % 接受准则
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
t=t*tf; %衰减函数

f_max=f;
end

f_max
toc %程序运行的结尾，得出运行的时间 
