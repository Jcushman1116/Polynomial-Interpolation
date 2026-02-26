function [gamma, fx] = Barycentric1Coefficients(mesh, f, precision)
n = length(x)-1; % n+1 data points to interpolate polynomial of degree n 

% Initialize mesh points for single and double point precision
if precision == "single" 
    mesh = single(mesh);
    gamma = ones(1, n+1, 'single');
else
    mesh = double(mesh);
    gamma = ones(1, n+1, 'double');
end

% eval. function at mesh points
fx = f(mesh); 

% Code from berrut and Trefethen 
for j = 1:n 
    for k = 0:j-1
        gamma(k+1) = (mesh(k+1)- mesh(j+1)) * gamma(k+1);  
    end 

    new_weight = 1; 
    for k = 0:j-1
        new_weight = new_weight * (x(j+1)-x(k+1));
    end 
    gamma(j+1) = new_weight;
end 

% compute element wise reciporical         
gamma = 1 ./ gamma;
end 