clc;
clear all;
workspace
grid on;
title('V2I Connectivity')
xlabel('Y')
ylabel('X')
axis([0 1000 0 1000]);
uiwait(msgbox('Click on two points for Road 1.', 'modal'));
[x1, y1] = ginput(2);
line([x1(1), x1(2)], [y1(1), y1(2)])
slope1 = (y1(2)-y1(1))/(x1(2)-x1(1))
uiwait(msgbox('Click on next point for Road 2.', 'modal'));
[x2, y2] = ginput(1);
line([x1(2), x2], [y1(2), y2])
uiwait(msgbox('Click on next point for Road 3.', 'modal'));
[x3, y3] = ginput(1);
line([x2, x3], [y2, y3])
% p1 = polyfit(x1, y1, 1);
% p2 = polyfit(x2, y2, 1);
% x_intersect = fzero(@(x) polyval(p1-p2,x),3);
% y_intersect = polyval(p1,x_intersect);

hold on;    
%scatter(x_1,y_1); 

a1 = [x1(1), y1(1)];
b1 = [x1(2), y1(2)];
% straight line function from a to b
func = @(xa)a1(2) + (a1(2)-b1(2))/(a1(1)-b1(1))*(xa-a1(1));
% determine the x values
speed = randi([10 20], 1, 1);
no_of_points = floor(abs(((x1(1) - x1(2))/speed)));
xa = linspace(a1(1),b1(1),no_of_points);
% determine the y values
ya = func(xa);
 
a2 = [x1(2), y1(2)];
b2 = [x2, y2];
% straight line function from a to b
func = @(xb)a2(2) + (a2(2)-b2(2))/(a2(1)-b2(1))*(xb-a2(1));
% determine the x values
no_of_points = floor(abs((x1(2) - x2)/speed));
xb = linspace(a2(1),b2(1),no_of_points);
% determine the y values
yb = func(xb);

a3 = [x2, y2];
b3 = [x3, y3];
% straight line function from a to b
func = @(xc)a3(2) + (a3(2)-b3(2))/(a3(1)-b3(1))*(xc-a3(1));
% determine the x values
no_of_points = floor(abs((x2 - x3)/speed));
xc = linspace(a3(1),b3(1),no_of_points);
% determine the y values
yc = func(xc);

uiwait(msgbox('Click on a point for RSU 1.', 'modal'));
[rsu1x, rsu1y] = ginput(1);
scatter(rsu1x, rsu1y, 'filled');

uiwait(msgbox('Click on a point for RSU 2.', 'modal'));
[rsu2x, rsu2y] = ginput(1);
scatter(rsu2x, rsu2y, 'filled');

hold on;
% get a handle to a plot graphics object
hPlot1 = plot(NaN,NaN, 'square');
line1 = plot(NaN,NaN, '--');
line2 = plot(NaN,NaN, '--');
% iterate through each point on line
for k=1:length(xa)
    % update the plot graphics object with the next position
    set(hPlot1,'XData',xa(k),'YData',ya(k));
    vrsu1 = pdist ([xa(k), ya(k); rsu1x, rsu1y],'euclidean');
    vrsu2 = pdist ([xa(k), ya(k); rsu2x, rsu2y],'euclidean');
    if(vrsu1 <=100)
        set(line1,'XData', [xa(k), rsu1x],'YData', [ya(k), rsu1y]);
    end
    if(vrsu2 <=100)
        set(line2,'XData', [xa(k), rsu2x],'YData', [ya(k), rsu2y]);
    end
    % pause for 1 second
    pause(1);
end

for k=1:length(xb)
    % update the plot graphics object with the next position
    set(hPlot1,'XData',xb(k),'YData',yb(k));
    vrsu1 = pdist ([xb(k), yb(k); rsu1x, rsu1y],'euclidean');
    vrsu2 = pdist ([xb(k), yb(k); rsu2x, rsu2y],'euclidean');
    if(vrsu1 <=100)
        set(line1,'XData', [xb(k), rsu1x],'YData', [yb(k), rsu1y]);
    end
    if(vrsu2 <=100)
        set(line2,'XData', [xb(k), rsu2x],'YData', [yb(k), rsu2y]);
    end
    % pause for 1 second
    pause(1);
end

for k=1:length(xc)
    % update the plot graphics object with the next position
    set(hPlot1,'XData',xc(k),'YData',yc(k));
    vrsu1 = pdist ([xc(k), yc(k); rsu1x, rsu1y],'euclidean');
    vrsu2 = pdist ([xc(k), yc(k); rsu2x, rsu2y],'euclidean');
    if(vrsu1 <=100)
        set(line1,'XData', [xc(k), rsu1x],'YData', [yc(k), rsu1y]);
    end
    if(vrsu2 <=100)
        set(line2,'XData', [xc(k), rsu2x],'YData', [yc(k), rsu2y]);
    end
    % pause for 1 second
    pause(1);
end
