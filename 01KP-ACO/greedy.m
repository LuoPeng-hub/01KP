%̰���㷨���0��1��������
Fid=fopen('b.txt','r');
v=fscanf(Fid,'%f',1);
fclose(Fid);
Fid=fopen('p.txt','r');
p=fscanf(Fid,'%f',[1,50]);
fclose(Fid);
Fid=fopen('w.txt','r');
w=fscanf(Fid,'%f',[1,50]);
fclose(Fid);                %��������������
u=p./w;                     %�����Լ۱�
vk=0;
bestp=0;
while(length(p)>0)
    [wk,IK]=max(u);        %ÿ��ѡ���Լ۱���ߵ���Ʒ
    if(vk+w(IK)<=v)        %�������Ҫ��������뱳��
        vk=vk+w(IK);
        bestp=bestp+p(IK);     
    end
    u(IK)=[];              %����������������Ʒɾ��
    w(IK)=[];
    p(IK)=[];
end
bestp
        
