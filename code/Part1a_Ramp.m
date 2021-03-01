function [outputArg1,outputArg2] = Part1a_Ramp(nx,ny)

solutMat = zeros(nx,ny);
solutVect = zeros(nx*ny,1);
G = sparse(nx*ny, nx*ny);

for i = 1:nx
    for j = 1:ny
        
        n = j+(i-1)*ny;
        
        if i == 1               %Left side
            G(:,n) = 0;
            G(n,n) = 1;
            solutVect(n) = 1;
                        
        elseif i == nx          % Right size
            G(:,n) = 0;
            G(n,n) = 1;
            
        elseif j == 1           %Bottom y-axis
            G(n,n) = -3;
            G(n,n+ny) = 1;
            G(n,n-ny) = 1;
            G(n,n+1) = 1;
                        
        elseif j == ny          %Top y-axis
            G(n,n) = -3;
            G(n,n+ny) = 1;
            G(n,n-ny) = 1;
            G(n,n-1) = 1;
            
        else %Handle standard middle cases
            
            G(n,n) = -4;
            G(n,n+ny) = 1;
            G(n,n-ny) = 1;
            G(n,n+1)= 1;
            G(n,n-1) = 1;
        end
    end
end

solutVect = G\solutVect;

for i = 1:nx
	for j = 1:ny
		n= j+(i-1)*ny;
		solutMat(i,j) = solutVect(n);
	end
end

figure(1)
surf(solutMat, 'edgecolor', 'none')
colorbar;
title('1D Ramp');
ylabel('Length');
xlabel('Width');
zlabel('V (Volts)');
view(-100,20)


end

