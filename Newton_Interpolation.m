function px = Newton_Interpolation(evaluation_points, mesh, newton_coefficients)

evaluation_points = cast(evaluation_points, precision);
mesh = cast(mesh, precision);
divided_coeffs = cast(newton_coefficients, precision);

n = length(divided_coeffs) - 1; 
px = zeros(size(evaluation_points), precision);

% Loop through each point we want to evaluate
for j = 1:length(evaluation_points)
    x = evaluation_points(j);
        
    % Horner's Method: Start from the highest order coefficient
    s = newton_coefficients(n + 1); 
        
    % Iterate backwards from n-1 down to 0
    % s = s*(x - x_i) + alpha_i
    for i = n:-1:1
        s = s * (x - mesh(i)) + newton_coefficients(i);
    end
        
    px(j) = s;
end
end