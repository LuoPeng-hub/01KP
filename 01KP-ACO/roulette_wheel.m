%轮盘赌程序
function f=roulette_wheel(u,q)
r=rand*u;                      %生成随机数r
s=0;
n=length(q);
for i=1:n                      %i从1开始，这也是对原算法的修改
    s=s+q(i);
    if(s>r)                    %原算法是s>=r，而我写的是s>r，想想是为什么，这避免了什么错误？这也是对原算法的一个修改
        f=i;                   %将选择到的点返回
        break;
    end
end