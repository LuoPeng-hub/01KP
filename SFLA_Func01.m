
 
tic; t1=clock; 
num=1;
ge=100;
le=10
  fit2=zeros(num,ge*le);
  sbest=zeros(1,num);
  for tdy=1:num
 
 
  M=40;
  
m=4;
n=5;
q=m*n;
ge=100;
le=10;
 
Dmin= -100;
Dmax =100;
c=2;
 
fit=[];

%%%%%%%%%%%%%%%%
NN=0.2;



frog=struct('fitness',{},'center',{});
% lfrog= struct('fitness2',{},'center2',{});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%1) Sphere function [-100,100]  data=a+(b-a)*rand(m,n)
     
%     
%       data=-5.12+5.12*2*rand(1,M);
%     
%      f1=0.0;
%     for  t=1:size(data,2)
%         
%      f1=f1+data(t)*data(t);
%     end
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
for i=1:q 
  
            data=-100+100*2*rand(1,M);
%             data=-5.12+5.12*2*rand(1,M);
%          
        
      f1=0.0;
      for  t=1:size(data,2)
         
          f1=f1+data(t)*data(t);
      end
       f1;
       fitness=f1;

       frog(i).fitness=fitness;
      frog(i).center=data;
end
 

 

w=1;
%%%%%%%%%%%%%%%%%
 
 
for v=1:ge 
    
    
         for I=1:q-1
             for J=1:q-I
                if frog(J).fitness < frog(J+1).fitness
                     temp=frog(J+1).fitness;
                     temp2=frog(J+1).center;
            
                      frog(J+1).fitness=frog(J).fitness;
                      frog(J+1).center=frog(J).center;
             
                      frog(J).center=temp2;
                      frog(J).fitness=temp;
                end 
             end
         end
  


 
      Xg=frog(q)  ;%ȫ����õ�����
%  fit=[fit Xg.fitness] 
        
 
       testG=Xg;
 

       for k=1:le
          for ff=1: q
                if   testG.fitness>frog(ff).fitness
                        testG=frog(ff);
                end
          end
        
              fit=[fit testG.fitness] 
           fit2(tdy, le*(v-1)+k)=Xg.fitness; 
      for i=1:m
%             for k=1:le
                    Xw= frog(i);
                    w=i;
                     Xb= frog(i);
                     b=i;
           
                    for tt=2:n
                         if  frog(i+m*(tt-1)).fitness<Xb.fitness
                             Xb=frog(i+m*(tt-1));
                             b=i+m*(tt-1);
                         end
                         if  frog(i+m*(tt-1)).fitness>Xw.fitness
                            Xw=frog(i+m*(tt-1));
                            w=i+m*(tt-1);%�ṹ�������������
                         end

                    end
                    Xw;
                    Xb;
        
                         Xnew=Xw;
             
                          for x=1:size(Xb.center,2)
                             Xnew.center(x )=Xw.center(x )+c*rand.*(Xb.center(x)-Xw.center(x));
                             if Xnew.center(x)<Dmin
                               Xnew.center(x)=Dmin;
                             end
                             if Xnew.center(x )>Dmax
                                 Xnew.center(x )=Dmax;  
                             end
                          end
                       
                          data=Xnew.center;
                          f1=0.0;
                          for  t=1:size(data,2)
                            f1=f1+data(t)*data(t);
                          end
                          fitness=f1;
            
                          Xnew.fitness=fitness;
                         if Xnew.fitness<Xw.fitness
                           Xw=Xnew;
                         end
                         
                          Xb=Xg;
             
             
                         for x=1:size(Xb.center)
                              
                            Xnew.center(x )=Xw.center(x )+c*rand.*(Xb.center(x)-Xw.center(x));
                           if Xnew.center(x)<Dmin
                              Xnew.center(x)=Dmin;
                           end
                           if Xnew.center(x )>Dmax
                              Xnew.center(x )=Dmax;  
                           end
                         end
             
                        data=Xnew.center;
                        f1=0.0;
                       for  t=1:size(data,2)
        
                          f1=f1+data(t)*data(t);
                       end
                       fitness=f1;
                       Xnew.fitness= fitness;

                      if  Xnew.fitness<Xw.fitness %������ȫ��������ܵ���Ӧ���滻�ֲ�������ܵ���Ӧ��
                        Xw=Xnew;
                      end

                      if Xnew.fitness> Xw.fitness%��������µ�����
             
%                         data=-5.12+5.12*2*rand(1,M);
                         data=-100+100*2*rand(1,M);
                          f1=0.0;
                         for  t=1:size(data,2)
        
                            f1=f1+data(t)*data(t);
                         end
              
                         fitness=f1;
                         Xnew.center=data;
                         Xnew.fitness=fitness;
                      end
         
                     if Xnew.fitness <Xw.fitness%���º��������Ӧ�ȴ���ԭ��������ܵ���Ӧ��
                       Xw=Xnew;
                       
                     end
                       frog(w)=Xw;
                
           end%k����
      end%i����
 end%v����
      
 
 
 
for i=1:q-1
    for j=1:q-i
        if frog(j).fitness < frog(j+1).fitness
            temp=frog(j+1).fitness;
            temp2=frog(j+1).center;
            
             frog(j+1).fitness=frog(j).fitness;
             frog(j+1).center=frog(j).center;
             
             frog(j).center=temp2;
             frog(j).fitness=temp;
        end 
    end
end
frog(q).center;

center=frog(q).center;
 
fitness=frog(q).fitness

 
fit;
bestfit=log(fit);
%
sbest(tdy)=fit2(tdy,ge*le);%���Ž�
  end%tdy
bestfit=log(fit2);
%                         save('D:\matlabCode\SFLA 5FUNCTION\testNSFLA\sfla\20Q40M\best01', 'sbest');
%                       save('D:\matlabCode\SFLA 5FUNCTION\testNSFLA\sfla\20Q40M\bestfit01', 'bestfit');
toc;etime(clock,t1) 
