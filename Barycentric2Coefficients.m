function [beta, fx, x_mesh] = Barycentric2Coefficients(Interval, f, mesh_type, n, precision)
a = Interval(1); 
b = Interval(2); 

% Index from 0,...,n 
k = 0:n; 

% Generate mesh points from [-1,1] aka nodes for Interpolation
if mesh_type == "uniform"
    x = -1 + (2*k) / n;
elseif mesh_type == "chebychev1"
    x = cos((2*k + 1) * pi / (2*n +2)); 
elseif mesh_type == "chebychev2"
    x = cos(k * pi / n); 
end 

% Create mapping from [-1,1] -> [a,b]
x_mesh = 0.5*(a+b) + 0.5*(b-a) * x;  

% Initialize precision for mesh and function eval.
x_mesh = cast(x_mesh, precision); 
fx = cast(f(x_mesh), precision);

% Compute Coefficients for Barycentric form 2 
if mesh_type == "uniform"
    % storage for weights
    beta = zeros(1, n+1, precision);
    % if uniform mesh => Binomial Coefficients/weights: (-1)^j * binomial(n,j)
    for j = 0:n 
        beta(j+1) = (-1)^j * nchoosek(n,j);
    end 

% if chebychev points of 1st kind => Sinusodial Coefficients/weights 
elseif mesh_type == "chebychev1"
    beta = ((-1).^k) .* sin((2*k + 1) * pi / (2*n + 2));

% if chebychev points of 2nd kind => [1/2, 1, 1, ..., 1, 1, 1/2] * (-1)^j   
elseif mesh_type == "chebychev2"
    beta = ones(1, n+1, precision);
    beta(1) = 0.5; 
    beta(end) = 0.5;
    beta = beta .* ((-1).^k);
end 

% Ensure beta is computed with correct precision
beta = cast(beta, precision); 
end