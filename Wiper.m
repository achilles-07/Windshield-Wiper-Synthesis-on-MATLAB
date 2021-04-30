clc
clear all
close all

% Matlab Wiper Mechanism Visualization
% Mechanism Sessional Assignment 5


% The rocking angle to pi/3
% After setting the lengths of L4 and L1 arbitrarily, calculate the remaining lengths of L2 and L3 using the formula.
% To find L3, use the formula L1^2 + L2^2 = L3^2 + L4^2.


l1=360;
l2=90;
l4=180; % Grashof Equation Established & Non qrr Established
l3=sqrt(l1^2+l2^2-l4^2);
l5 = 450/(cos(pi/3));


th4star = 2*asin(l2/l4);  
%Angle at which l4 locks

th4star_degree = th4star*180/pi;

th2 = 0 : 2*pi/180 : 2*pi;





th4m=nan(size(th2)); % theta4 for minus


for j=1:length(th2)
    %Finding Theta 4 Given Theta 2
    a=sin(th2(j));
    b=l1/l2+cos(th2(j));
    c=(l1^2+l2^2-l3^2+l4^2)/(2*l2*l4)+l1/l4*cos(th2(j));
    th4m(j)=2*atan((a-(a^2+b^2-c^2)^0.5)/(b+c));
    end





th5m=nan(size(th2)); % theta5 for minus

for j=1:length(th2)
  % Finding theta 5 given theta 2
    a=sin(th2(j));
    b=l1/l2+cos(th2(j));
    c=(l1^2+l2^2-l3^2+l4^2)/(2*l2*l4)+l1/l4*cos(th2(j));
    th5m(j)=pi+2*atan((a-(a^2+b^2-c^2)^0.5)/(b+c)) ; 
end





th3m=nan(size(th2)); % theta4 for minus

for j=1:length(th2)
   %Finding theta 3 given theta 2
    a=sin(th2(j));
    b=l1/l2+cos(th2(j));
    c=-( (l1^2+l2^2+l3^2-l4^2)/(2*l2*l3)+l1/l3*cos(th2(j)) );
    th3m(j)=2*atan((a-(a^2+b^2-c^2)^0.5)/(b+c));
end

%% Plot configurations for wipers



% 1. Output the current wiping range
startwipe_degree= (min(th5m))*180/pi; %Start wiping ==> 85.6617
endwipe_degree= (max(th5m))*180/pi; %Wiping end ==> 145.6573
% An angle difference between L4 and L5 should be given so that the wiping range (based on the wiper center point) is 450 mm left and right.
% Since 60 degrees should be wiped from the center, the start should be 60 degrees and the end 120 degrees.
% Subtract 60-startwipe_degree from th5 to give the angle difference between L4 and L5.
startwipe_radian = min(th5m);
delth5 = (pi/3)-startwipe_radian;

for j=1:length(th2)
  % Finding theta 5 given theta 2
    a=sin(th2(j));
    b=l1/l2+cos(th2(j));
    c=(l1^2+l2^2-l3^2+l4^2)/(2*l2*l4)+l1/l4*cos(th2(j));
    th5m(j)=pi+2*atan((a-(a^2+b^2-c^2)^0.5)/(b+c))+delth5 ; 
end


fprintf('Length of L1: %1.f mm\n',l1)
fprintf('Length of L2: %1.f mm\n',l2)
fprintf('Length of L3: %f mm\n',l3)
fprintf('Length of L4: %1.f mm\n',l4)
fprintf('Angle difference between L4 and L5: %f(degree)\n',-delth5*180/pi) %However, although L4 and L5 are one rigid body, they are separated for explanation of each difference.

for j= 1: length(th2)

    O2x=0;
    O2y= 0;
    Ax=O2x+l2*cos(th2(j));
    Ay=O2y+l2*sin(th2(j));
    Bx=Ax+l3*cos(th3m(j));
    By=Ay+l3*sin(th3m(j));
  %  Bx2=-l1+l4*cos(th4p(j));
  %  By2=l4*sin(th4p(j));
    O4x=-l1;
    O4y=0;
    Cx= O4x+l5*cos(th5m(j));
    Cy= O4y+l5*sin(th5m(j));
    Dx= -200+O4x+l5*cos(th5m(j));
    Dy= O4y+l5*sin(th5m(j));
    O5x= -200+O4x;
    O5y= 0;
    W1x = Cx;
    W1y = Cy+400;
    W2x = Cx;
    W2y = Cy-400;
    
   
    
    xtemp=[O2x Ax Bx  O4x Cx Dx O5x];
    ytemp=[O2y Ay By  O4y Cy Dy O5y];
   
    wx = [W1x W2x];
    wy = [W1y W2y];
    plot(xtemp,ytemp,'bo-',wx,wy,'ro-','linewidth',2);
    %Area PLot
     %hold on;
    % plot(wx,wy,'ro-','linewidth',2);
    title('Wiper-Mechanical Design by Umang');
    grid on;
    xlabel('X [cm]');
    ylabel('Y [cm]');
    ylim([-500,1600])
    axis equal;
    pause(0.0000000001);
end

