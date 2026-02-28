function [fx, DDT, newton_coefficients] = Divided_Difference(mesh, f, precision)

% Num of nodes
n = length(mesh); 
% Evaluate the function at the mesh points
fx = cast(f(mesh), precision);   
% Storage for Table with same precision as fx 
DDT = zeros(n, n, 'like', fx); 

for i = 1:n 
    DDT(1,i) = fx(i); 
end

for j = 2:n
    for i = 1:(n - j + 1)
        num = DDT(j-1, i+1) - DDT(j-1, i);
        den = mesh(i + j - 1) - mesh(i);
        DDT(j, i) = num / cast(den, precision);
    end
end

newton_coefficients = DDT(:,1); 
end