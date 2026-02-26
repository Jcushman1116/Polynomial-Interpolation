function px = Barycentric1_Interpolation(evaluation_points, mesh, gamma, fx, precision)

% Initialize input values as single or double floating point precision
if precision == "single"
    evaluation_points = single(evaluation_points);
    mesh = single(mesh);
    gamma = single(gamma); 
    fx = single(fx);
else
    mesh = double(mesh);
    evaluation_points = double(evaluation_points);
    gamma = double(gamma); 
    fx = double(fx); 
end

% Initialize output array with the appropriate type
px = zeros(size(evaluation_points), precision);

% loop through each point that gets evaluated 
for j=1:length(evaluation_points)
    x_current = evaluation_points(j); 

    % Compute difference vector (x - x_i)
    difference = x_current - mesh; 

    % check if (x-x_i) = 0 at any point
    % if difference = 0  => Code fails via (0*inf) 
    exact_spot = find(difference == 0,1);

    % if exact_spot is Not empty => return f(x) 
    if ~isempty(exact_spot)
        px(j) = fx(exact_spot);
    % Otherwise compute Barycentric 1 formula
    else 
        lx = prod(difference); 
        summation = sum((gamma .* fx ./ difference));
        px(j) = lx * summation; 
    end
end
end