function px = Barycentric2_Interpolation(evaluation_points, x_mesh, beta, fx, precision)

% Initialize Sroage for polynomial construction
px = zeros(size(evaluation_points), precision);

%Cast Single/double point precision on input parameters
evaluation_points = cast(evaluation_points, precision);
x_mesh = cast(x_mesh, precision);
beta = cast(beta, precision);
fx = cast(fx, precision);

% Begin polynomial evaluation
for j=1:length(evaluation_points)
    x_current = evaluation_points(j); 

    % Compute difference vector (x - x_i) with transformed mesh
    difference = x_current - x_mesh; 

    % check if (x-x_i) = 0 at any point
    % if difference = 0  => Code fails via (0*inf) 
    exact_spot = find(difference == 0,1);

    % if exact_spot is Not empty => return f(x) 
    if ~isempty(exact_spot)
        px(j) = fx(exact_spot);
    % Otherwise compute Barycentric 2 formula
    else
        rho = beta ./ difference;
        px(j) = sum(rho .* fx)/ sum(rho);
    end 
end
end