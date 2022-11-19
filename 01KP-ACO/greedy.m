%贪心算法解决0－1背包问题
Fid=fopen('b.txt','r');
v=fscanf(Fid,'%f',1);
fclose(Fid);
Fid=fopen('p.txt','r');
p=fscanf(Fid,'%f',[1,50]);
fclose(Fid);
Fid=fopen('w.txt','r');
w=fscanf(Fid,'%f',[1,50]);
fclose(Fid);                %以上是载入数据
u=p./w;                     %计算性价比
vk=0;
bestp=0;
while(length(p)>0)
    [wk,IK]=max(u);        %每次选择性价比最高的物品
    if(vk+w(IK)<=v)        %如果满足要求，则将其加入背包
        vk=vk+w(IK);
        bestp=bestp+p(IK);     
    end
    u(IK)=[];              %将本次搜索过的物品删除
    w(IK)=[];
    p(IK)=[];
end
bestp
        
