%���̶ĳ���
function f=roulette_wheel(u,q)
r=rand*u;                      %���������r
s=0;
n=length(q);
for i=1:n                      %i��1��ʼ����Ҳ�Ƕ�ԭ�㷨���޸�
    s=s+q(i);
    if(s>r)                    %ԭ�㷨��s>=r������д����s>r��������Ϊʲô���������ʲô������Ҳ�Ƕ�ԭ�㷨��һ���޸�
        f=i;                   %��ѡ�񵽵ĵ㷵��
        break;
    end
end