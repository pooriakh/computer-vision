clc
clear
close all
iteration=10;

data = load('data3');
X = data(:, 1);
Y = data(:, 2);
Old_Faithful=Old_Faithful_Geyser_Data;
K=2;
size_data=size(data)
size_data=size_data(1)
K1=round(rand*(size_data))
K2=round(rand*(size_data))
K3=round(rand*(size_data))


x=X;
y=Y;

figure;
plot(x,y,'o')
hold on
plot(x(K1),y(K1),'*')
hold on
plot(x(K2),y(K2),'*')
hold on
plot(x(K3),y(K3),'*')
hold off

X_K1=x(K1);y_K1=y(K1);
X_K2=x(K2);y_K2=y(K2);
X_K3=x(K3);y_K3=y(K3);

for j=1:iteration

kk1=0;
kk2=0;
kk3=0;

clear GroupK1 GroupK2 GroupK3

for i=1:size_data
%        if i~=K1 & i~=K2
            deltaK1=sqrt((x(i)-X_K1).^2+(y(i)-y_K1).^2);
            deltaK2=sqrt((x(i)-X_K2).^2+(y(i)-y_K2).^2);
            deltaK3=sqrt((x(i)-X_K3).^2+(y(i)-y_K3).^2);            
           if ((deltaK1<= deltaK2) & (deltaK1<= deltaK3))
               kk1=kk1+1;
               GroupK1(kk1)=i;
              
           elseif ((deltaK2<= deltaK1) & (deltaK2<= deltaK3))
               kk2=kk2+1;
               GroupK2(kk2)=i;   
               
           else
               kk3=kk3+1;
               GroupK3(kk3)=i;
               
           end
           
           if deltaK1==deltaK2 | deltaK3==deltaK2 | deltaK1==deltaK3
               display('************************equal********************')
           end
%    end
end

size_group_K1=size(GroupK1);
size_group_K1=size_group_K1(2)
size_group_K2=size(GroupK2);
size_group_K2=size_group_K2(2)
size_group_K3=size(GroupK3);
size_group_K3=size_group_K3(2)
figure;
plot(x(GroupK1),y(GroupK1),'*')
hold on
plot(x(GroupK2),y(GroupK2),'o')
hold on
plot(x(GroupK3),y(GroupK3),'gs')
hold off

x_adjust_mean1=sum(x(GroupK1))/size_group_K1
y_adjust_mean1=sum(y(GroupK1))/size_group_K1

x_adjust_mean2=sum(x(GroupK2))/size_group_K2
y_adjust_mean2=sum(y(GroupK2))/size_group_K2


x_adjust_mean3=sum(x(GroupK3))/size_group_K3
y_adjust_mean3=sum(y(GroupK3))/size_group_K3

if ((X_K1==x_adjust_mean1) &(y_K1==y_adjust_mean1)&(X_K2==x_adjust_mean2)&(y_K2==y_adjust_mean2)&(X_K3==x_adjust_mean3)&(y_K3==y_adjust_mean3))
    display('************************Solution********************')
    display('loop iteration =')
    j
    break;
end %if
X_K1=x_adjust_mean1;
y_K1=y_adjust_mean1;

X_K2=x_adjust_mean2;
y_K2=y_adjust_mean2;

X_K3=x_adjust_mean3;
y_K3=y_adjust_mean3;

 
    
end