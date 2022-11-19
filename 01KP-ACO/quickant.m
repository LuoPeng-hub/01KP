clear;
tic                                               %开始记时
Fid=fopen('b.txt','r');                           %注意三个数据文件的扩展名是.txt
v=fscanf(Fid,'%f',1);
fclose(Fid);
Fid=fopen('p.txt','r');
p=fscanf(Fid,'%f',[1,50]);
fclose(Fid);
Fid=fopen('w.txt','r');
w=fscanf(Fid,'%f',[1,50]);
fclose(Fid);                                      %以上是载入数据
n=50;                                             %物品数量
rfa=1.0;
beta=1.0;
ro=0.7;                                           %信息素衰减因子                                        
Q=1;
NCMax=40;                                         %最多迭代次数
t=ones(n,1);
bestjp=zeros(1,NCMax);                            %每次迭代产生的最优值
bestp=0;                                          %全局最优值
bestJ=[];                                         %全局最优解
m=n;                                              %生成n只蚂蚁
for NC=1:NCMax                                    % 开始迭代
   solutions=zeros(m,n);                          %存放m只蚂蚁的路径
        q=[];                                     %物品被选择的概率
        d=0;
        for j=1:n
            d=d+t(j)^rfa*(p(j)/w(j))^beta;        %计算概率的分母
        end
        for j=1:n
            q(j)=t(j)^rfa*(p(j)/w(j))^beta/d;
        end
    for k=1:m                                     % m只蚂蚁开始行动
        temp=q; 
        h=floor(rand*49)+1;                       %随机选取第一个物品
        solutions(k,h)=1;                         %将其填加到蚂蚁k的路径中
        vk=w(h);                                  %修改当前容量
        u=1-temp(h);
        temp(h)=0;
       while(u>1e-8)                              %开始轮盘赌
            j=roulette_wheel(u,temp);             %原轮盘赌算法中有一个参数，而我却设了两个，想一想为什么，这是对原算法最大错误的一个修改
            u=u-temp(j);
            temp(j)=0;
            if(vk+w(j)<=v)                        %如果满足约束，则将物品j放入背包
               solutions(k,j)=1;                  %将其填加到蚂蚁k的路径中
                vk=vk+w(j);                       %修改当前容量
            end
        end
    end
    [bestjp(NC),J]=max(solutions*p');            %本次迭代产生的最优值
    disp(['第',num2str(NC),'次迭代最优解为：',num2str(bestjp(NC)),'当前载重',num2str(solutions(J,:)*w')]);
    if(bestp<bestjp(NC))
        bestp=bestjp(NC);
        bestJ=solutions(J,:);
    end
    t=ro*t;
    t=t+(bestJ.*p*Q/bestjp(NC))';                %更新物品上的信息素
end
t_time=toc;                                      % 停止记时
plot(1:NCMax,bestjp);                            %开始绘图
axis([1,n,min(bestjp)-100,bestp+100]);
xlabel('迭代次数');
ylabel('最优解');
text(15,13500,'最优解随迭代次数变化曲线');
title(['本次迭代最优值:',num2str(bestp),',耗时:',num2str(t_time),'秒']);
disp(['本次迭代最优解为：',num2str(bestp),'当前载重',num2str(bestJ*w'),',耗时:',num2str(t_time),'秒']);
bestJ