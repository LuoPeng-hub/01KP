clear;
tic                                               %��ʼ��ʱ
Fid=fopen('b.txt','r');                           %ע�����������ļ�����չ����.txt
v=fscanf(Fid,'%f',1);
fclose(Fid);
Fid=fopen('p.txt','r');
p=fscanf(Fid,'%f',[1,50]);
fclose(Fid);
Fid=fopen('w.txt','r');
w=fscanf(Fid,'%f',[1,50]);
fclose(Fid);                                      %��������������
n=50;                                             %��Ʒ����
rfa=1.0;
beta=1.0;
ro=0.7;                                           %��Ϣ��˥������                                        
Q=1;
NCMax=40;                                         %����������
t=ones(n,1);
bestjp=zeros(1,NCMax);                            %ÿ�ε�������������ֵ
bestp=0;                                          %ȫ������ֵ
bestJ=[];                                         %ȫ�����Ž�
m=n;                                              %����nֻ����
for NC=1:NCMax                                    % ��ʼ����
   solutions=zeros(m,n);                          %���mֻ���ϵ�·��
        q=[];                                     %��Ʒ��ѡ��ĸ���
        d=0;
        for j=1:n
            d=d+t(j)^rfa*(p(j)/w(j))^beta;        %������ʵķ�ĸ
        end
        for j=1:n
            q(j)=t(j)^rfa*(p(j)/w(j))^beta/d;
        end
    for k=1:m                                     % mֻ���Ͽ�ʼ�ж�
        temp=q; 
        h=floor(rand*49)+1;                       %���ѡȡ��һ����Ʒ
        solutions(k,h)=1;                         %������ӵ�����k��·����
        vk=w(h);                                  %�޸ĵ�ǰ����
        u=1-temp(h);
        temp(h)=0;
       while(u>1e-8)                              %��ʼ���̶�
            j=roulette_wheel(u,temp);             %ԭ���̶��㷨����һ������������ȴ������������һ��Ϊʲô�����Ƕ�ԭ�㷨�������һ���޸�
            u=u-temp(j);
            temp(j)=0;
            if(vk+w(j)<=v)                        %�������Լ��������Ʒj���뱳��
               solutions(k,j)=1;                  %������ӵ�����k��·����
                vk=vk+w(j);                       %�޸ĵ�ǰ����
            end
        end
    end
    [bestjp(NC),J]=max(solutions*p');            %���ε�������������ֵ
    disp(['��',num2str(NC),'�ε������Ž�Ϊ��',num2str(bestjp(NC)),'��ǰ����',num2str(solutions(J,:)*w')]);
    if(bestp<bestjp(NC))
        bestp=bestjp(NC);
        bestJ=solutions(J,:);
    end
    t=ro*t;
    t=t+(bestJ.*p*Q/bestjp(NC))';                %������Ʒ�ϵ���Ϣ��
end
t_time=toc;                                      % ֹͣ��ʱ
plot(1:NCMax,bestjp);                            %��ʼ��ͼ
axis([1,n,min(bestjp)-100,bestp+100]);
xlabel('��������');
ylabel('���Ž�');
text(15,13500,'���Ž�����������仯����');
title(['���ε�������ֵ:',num2str(bestp),',��ʱ:',num2str(t_time),'��']);
disp(['���ε������Ž�Ϊ��',num2str(bestp),'��ǰ����',num2str(bestJ*w'),',��ʱ:',num2str(t_time),'��']);
bestJ