function [outputArg1,outputArg2] = Part2c_Narrowing(nx,ny)

global L W V0

save = zeros(nx,ny);
solution = zeros(nx*ny,1);
G = sparse(nx*ny, nx*ny);

%Question 2

G = sparse((nx *ny), (nx*ny));
V = zeros(1,(nx *ny));
Vo = 1;

conductivity1 = 1; %outside
conductivity2 = 1e-2; %inside

box1 = [(nx* 2/5), (nx* 3/5), ny , (ny *3/5)]; %lower box
box2 = [(nx* 2/5), (nx* 3/5),0, (ny *2/5)]; %top box

bottleNeckVec = zeros(1,10);
currentVec = zeros(1,10);

% conductivity map
map = ones(nx,ny);

for i = 1:nx
    for j = 1:ny
        if (i < box1(2) && i >box1(1) && ((j < box2(4)) || (j > box1(4))))
            map(i,j) = conductivity2;
        end
    end
end
% plot the conduction map
figure(11)
surf(map);
title('Conductivity Map');
xlabel('Y axis');
ylabel('X axis');
view(90,90)

%Matrix G
for i = 1:nx
    
    for j = 1: ny
        n = j+ (i-1) *ny;
        
        if (i == 1)
            G(n,:) = 0;
            
            G(n,n) = 1;
            
            V(1,n) = 1;
            
        elseif (i == nx)
            G(n,:) = 0;
            
            G(n,n) = 1;

            
        elseif ((i > 1) && (i < nx) && (j==1))
            
            G(n, n+ny) = map(i+1,j);
            
            G(n,n) = -(map(i,j+1)+map(i-1,j)+map(i+1,j));
            
            G(n,n-ny) = map(i-1,j);
            
            G(n,n-1) = map(i,j+1);
            
        elseif ((j == ny) && (i < nx) && (i >1))
            G(n, n+ny) = map(i+1,j);
            
            G(n,n) = -(map(i-1,j)+map(i+1,j)+map(i,j-1));
            
            G(n,n-ny) = map(i-1,j);
            
            G(n,n+1) = map(i,j-1);
        else
            G(n, n+ny) = map(i+1,j);
            
            G(n,n) = -(map(i-1,j)+map(i+1,j)+map(i,j+1)+map(i,j-1));
            
            G(n,n-ny) = map(i-1,j);
            
            G(n,n-1) = map(i,j+1);
            
            G(n,n+1) = map(i,j-1);
        end
    end
end

solution1 = G\V';

Volt = zeros(nx,ny);

for i =1:nx
    for j = 1:ny
        n = j+(i-1) * ny;
        Volt(i,j) = solution1(n);
    end
end

% Plot of Voltage Map
figure(12)
subplot(2,1,1);
surf(Volt);
title('Voltage Map with Bottleneck');
xlabel('Y axis');
ylabel('X axis');
view(90,90)

subplot(2,1,2);
surf(Volt);
title('Voltage Map with Bottleneck');
xlabel('Y axis');
ylabel('X axis');
view(-110,20)

% Electric Field plot
[Efx,Efy] = gradient(Volt);
Efx = -Efx;
Efy = -Efy;

figure(13)
quiver(Efx',Efy');
title('Quiver Plot of Electric Field')
xlabel('X axis');
ylabel('Y axis');
axis([0 nx 0 ny]);

% Electric Field Y
figure(14)
subplot(2,1,1);
title('Electric Field along the Y direction')
surface(Efy)
xlabel('Y axis');
ylabel('X axis');
axis([0 ny 0 nx]);
view(90,90)

subplot(2,1,2);
title('Electric Field along the Y direction')
surface(Efy)
xlabel('Y axis');
ylabel('X axis');
axis([0 ny 0 nx]);
view(-280,30)

figure(15)
subplot(2,1,1);
title('Electric Field along the X direction')
surface(Efx)
xlabel('Y axis');
ylabel('X axis');
axis([0 ny 0 nx]);
view(90,90)

subplot(2,1,2);
title('Electric Field along the X direction')
surface(Efx)
xlabel('Y axis');
ylabel('X axis');
axis([0 ny 0 nx]);
view(-280,30)


%plotting current density
Jx = Efx .* map;
Jy = Efx .*map;

figure(16)
quiver(Jx,Jy);
title('Quiver Plot of Current Density (J)')
xlabel('Y axis');
ylabel('X axis');
axis([0 ny 0 nx]);
view(270,90)

% Magnitude of current density 
magnitude = ((Jx .^2) + (Jy .^2)) .^0.5;

figure(17)
title('Magnitude of Current Density')
surface(magnitude)
axis tight

currentflow = sum(Jx(nx/2,:));
        
end
