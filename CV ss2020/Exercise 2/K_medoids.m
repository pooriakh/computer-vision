clc
clear
close all
iteration=15;
Old_Faithful=Old_Faithful_Geyser_Data;
K=2;
size_Old_Faithful=size(Old_Faithful)
size_Old_Faithful=size_Old_Faithful(1)

K1=round(rand*(size_Old_Faithful))
K2=round(rand*(size_Old_Faithful))

 x=Old_Faithful(:,1);
 y=Old_Faithful(:,2);

%%%normalize of the domain x,y
minx=min(x)
maxx=max(x)

x=(x-minx)/(maxx-minx);

miny=min(y)
maxy=max(y)
y=(y-miny)/(maxy-miny);

%%%


figure;
plot(x,y,'o')
hold on
plot(x(K1),y(K1),'*')
hold on
plot(x(K2),y(K2),'*')
hold off

X_K1=x(K1);Y_K1=y(K1);
X_K2=x(K2);Y_K2=y(K2);

X_K1_medoid=x(K1);Y_K1_medoid=y(K1);
X_K2_medoid=x(K2);Y_K2_medoid=y(K2);

for j=1:iteration

kk1=0;
kk2=0;

clear GroupK1 GroupK2
for i=1:size_Old_Faithful


%        if i~=K1 & i~=K2
            deltaK1=(abs(x(i)-X_K1)+abs(y(i)-Y_K1)); %deltaK1=sqrt((x(i)-X_K1).^2+(y(i)-Y_K1).^2); in order to make the caclcultaion  linear
            deltaK2=(abs(x(i)-X_K2)+abs(y(i)-Y_K2)); %deltaK2=sqrt((x(i)-X_K2).^2+(y(i)-Y_K2).^2); in order to make the caclcultaion  linear
           if deltaK1<= deltaK2
               kk1=kk1+1;
               GroupK1(kk1)=i;
           else
               kk2=kk2+1;
               GroupK2(kk2)=i;               
           end
           if deltaK1==deltaK2
               display('************************equal********************')
           end
%    end
end

size_group_K1=size(GroupK1);
size_group_K1=size_group_K1(2)
size_group_K2=size(GroupK2);
size_group_K2=size_group_K2(2)
figure;
plot(x(GroupK1),y(GroupK1),'*')
hold on
plot(x(GroupK2),y(GroupK2),'o')
hold on



%%% drawing the boundary line
C1=[X_K1;Y_K1];
C2=[X_K2;Y_K2];
syms XX YY
S=solve(dot((C1-C2),[XX;YY])+(-dot(C1,C1)+dot(C2,C2))/2,YY);
f(XX)=S;
fplot(XX,f,[0.2 .8])
hold on

Boundary_line(XX)=(Y_K2+Y_K1)/2+(XX-(X_K1+X_K2)/2)*(X_K1-X_K2)/(Y_K2-Y_K1);
QQ=.2:.1:.8;
plot(QQ,Boundary_line(QQ),'*c')
hold on
%%%



x_adjust_mean1=sum(x(GroupK1))/size_group_K1;
y_adjust_mean1=sum(y(GroupK1))/size_group_K1
summ=0;
for h=1:size_group_K1
    summ=summ+y(GroupK1(h));
end
summ=summ/size_group_K1
x_adjust_mean2=sum(x(GroupK2))/size_group_K2;
y_adjust_mean2=sum(y(GroupK2))/size_group_K2;


X_K1=x_adjust_mean1
Y_K1=y_adjust_mean1

X_K2=x_adjust_mean2
Y_K2=y_adjust_mean2

%%%%%% medoid methods
min_dis_k_medoi=sqrt((x(GroupK1(1))-X_K1).^2+(y(GroupK1(1))-Y_K1).^2);
count_medoid_mean1=1;
for m=2:size_group_K1
    dis_k_medoid=sqrt((x(GroupK1(m))-X_K1).^2+(y(GroupK1(m))-Y_K1).^2);
    if min_dis_k_medoi> dis_k_medoid
        count_medoid_mean1=m;
    end
end
count_medoid_mean1=count_medoid_mean1
X_K1=x(GroupK1(count_medoid_mean1));
Y_K1=y(GroupK1(count_medoid_mean1));


min_dis_k_medoi=sqrt((x(GroupK2(1))-X_K2).^2+(y(GroupK2(1))-Y_K2).^2);
count_medoid_mean2=1;
for m=2:size_group_K2
    dis_k_medoid=sqrt((x(GroupK2(m))-X_K2).^2+(y(GroupK2(m))-Y_K2).^2);
    if min_dis_k_medoi> dis_k_medoid
        count_medoid_mean2=m;
    end
end
count_medoid_mean2=count_medoid_mean2
X_K2=x(GroupK2(count_medoid_mean2));
Y_K2=y(GroupK2(count_medoid_mean2));

plot(x(GroupK1(count_medoid_mean1)),y(GroupK1(count_medoid_mean1)),'k*')
hold on
plot(x(GroupK2(count_medoid_mean2)),y(GroupK2(count_medoid_mean2)),'ko')
hold off


%%%%
if ((X_K1==X_K1_medoid) &(Y_K1==Y_K1_medoid)&(X_K2==X_K2_medoid)&(Y_K2==Y_K2_medoid))
    display('************************Solution********************')
    display('loop iteration =')
    j
    break;
end %if
X_K1_medoid=X_K1; Y_K1_medoid=Y_K1;
X_K2_medoid=X_K2; Y_K2_medoid=Y_K2;
%%%%




end