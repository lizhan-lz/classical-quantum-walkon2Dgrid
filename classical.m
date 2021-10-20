close all;clear;clc
a = input('请输入游走步数：');
%a = 10;
% x = -a:1:a;
% y = -a:1:a;
X = 2*a+1;
Y = 2*a+1;
st = a+1;
P = zeros(X,Y);
P(st,st) = 1;%从中点开始出发，概率为一，
Position(st,st)=1;
while a
    [loc_x,loc_y] = find(Position);%确定粒子当前可能位置
    for i=1:length(loc_x)
        %temp_x,temp_y = loc_x(i),loc_y(i);
        temp_x = loc_x(i);
        temp_y = loc_y(i);        
        %对每个概率位置迭代
        if(temp_x == 1||temp_y == 1)
            break;
        end
        %更新概率分布
        P(temp_x,temp_y+1) = P(temp_x,temp_y+1) + P(temp_x,temp_y)/4;
        P(temp_x,temp_y-1) = P(temp_x,temp_y-1) + P(temp_x,temp_y)/4;
        P(temp_x+1,temp_y) = P(temp_x+1,temp_y) + P(temp_x,temp_y)/4;
        P(temp_x-1,temp_y) = P(temp_x-1,temp_y) + P(temp_x,temp_y)/4;
        P(temp_x,temp_y) = 0;
        %更新概率位置分布
        Position(temp_x,temp_y+1)=1;
        Position(temp_x,temp_y-1)=1;
        Position(temp_x+1,temp_y)=1;
        Position(temp_x-1,temp_y)=1;
        Position(temp_x,temp_y)=0;
    end  
        a=a-1;
end
% figure(1);
% surf(x,y,P);
figure(2);
bar3(P);
%坐标轴显示的一点问题,8以内正常
set(gca,'XTickLabel',[]);
set(gca,'YTickLabel',[]);
xlabel('position_x');
ylabel('position_y');
zlabel('probability');
title('二维平面经典随机漫步概率分布','color','blue');