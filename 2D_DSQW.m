close all;clear all;clc
%模拟二维平面上离散量子漫步概率分布实现
a = input('请输入游走步数：');
%a=10;
X = 2*a+1;
Y = 2*a+1;
st = a+1;
Position(st,st)=1;%粒子初始节点概率位置
P = zeros(4,X,Y);
P(:,st,st) = 1/2*[1,i,1,i];
H = 1/sqrt(2)*[1,1,0,0;    1,-1,0,0;    0,0,1,1;    0,0,1,-1];
Pro = zeros(X,Y);
temp_P = P;
step = a;
for i = 1:step
    [loc_x,loc_y] = find(Position);%确定粒子当前可能位置    
    for i = 1:length(loc_x)
        %对每个概率位置迭代
        x = loc_x(i);
        y = loc_y(i);
        if(x == 1||y ==1)
            break;
        end
        P(:,x,y) = H*temp_P(:,x,y);
        P(1,x-1,y-1) = P(1,x-1,y-1)+P(1,x,y);  
        P(3,x-1,y-1) = P(3,x-1,y-1)+P(3,x,y);
        
        P(2,x+1,y-1) = P(2,x+1,y-1)+P(2,x,y);
        P(3,x+1,y-1) = P(3,x+1,y-1)+P(3,x,y);

        P(1,x-1,y+1) = P(1,x-1,y+1)+P(1,x,y);
        P(4,x-1,y+1) = P(4,x-1,y+1)+P(4,x,y);

        P(2,x+1,y+1) = P(2,x+1,y+1)+P(2,x,y); 
        P(4,x+1,y+1) = P(4,x+1,y+1)+P(4,x,y);  

        P(:,x,y) = 0;     
        Position(x-1,y-1)=1;
        Position(x-1,y+1)=1;
        Position(x+1,y-1)=1;
        Position(x+1,y+1)=1;
        Position(x,y)=0;
    end
        temp_P = P;
        temp_Position = Position;
end
s = 0;
for i=1:X
    for j=1:Y
        Pro(i,j) = abs(P(1,i,j))^2+abs(P(2,i,j))^2+abs(P(3,i,j))^2+abs(P(4,i,j))^2;
        s =s+Pro(i,j);
    end
end
Position
Pro = Pro/s;
sum(Pro,'ALL')
figure(1)
bar3(Pro);

%问题坐标轴,8以内正常
% xlim ([-a a]);
% ylim ([-a a]);
% %zlim ([-a a]);
% x = -a:5:a;
% y = -a:5:a;
set(gca,'XTick',[],'YTick',[]);
% set(gca,'YTicklabel',[-a,a]);

%坐标轴设置
% xlim auto;
% ylim auto
% zlim auto
% axis([-2*a,2*a,-2*a,2*a]);
%axis([-a,a,-a,a]);
%axis off;
xlabel('X');
ylabel('Y');
zlabel('P');
title(['二维平面离散量子漫步概率分布,步数：',num2str(a),],'color','blue');