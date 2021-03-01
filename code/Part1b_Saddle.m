function [outputArg1,outputArg2] = Part1b_Saddle(nx,ny,Iteration)
global L W V0

save = zeros(nx,ny);
solution = zeros(nx*ny,1);
G = sparse(nx*ny, nx*ny);

for x = 1:nx
    for y = 1:ny
        n = y + (x-1)*ny;
        
        if x == 1
            G(n, : ) = 0;
            G(n, n) = 1;
            solution(n) = 1;
        elseif x == nx
            G(n, : ) = 0;
            G(n, n) = 1;
            solution(n) = 1;
        elseif y == 1
            G(n, : ) = 0;
            G(n, n) = 1;
        elseif y == ny
            G(n, : ) = 0;
            G(n, n) = 1;
        else
            G(n, n) = -4;
            G(n, n+1) = 1;
            G(n, n-1) = 1;
            G(n, n+ny) = 1;
            G(n, n-ny) = 1;
        end
    end
end

solution = G\solution;

for i = 1:nx
	for j = 1:ny
		n = j+(i-1)*ny;
		save(i,j) = solution(n);
	end
end
figure(2)
surf(save, 'edgecolor', 'none')
colorbar;
title('2D saddle simulation');
ylabel('Length');
xlabel('Width');
zlabel('V (Volts)');
view(-120,20)

% Analytical solution
A_Solve = zeros(ny, nx);
x2 = repmat(linspace(-L/2,L/2,nx),ny,1);
y2 = repmat(linspace(0,W,ny),nx,1)';

solution = reshape(solution,[],ny)';
for i=1:Iteration
    n = 2*i - 1;
    A_Solve = A_Solve + 1./n.*cosh(n.*pi.*x2./W) ...
        ./cosh(n.*pi.*(L./2)./W).*sin(n.*pi.*y2./W);
end

A_Solve = A_Solve.*4.*V0./pi;

figure(3);
surf(linspace(0,L,nx),linspace(0,W,ny),A_Solve);
colorbar;
title(sprintf('Analytical for %d iterations', Iteration));
ylabel('Length');
xlabel('Width');
zlabel('V (Volts)');
view(-120,20)

end

