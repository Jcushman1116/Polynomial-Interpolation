function ordered_mesh = Ordering(mesh, type, precision)

mesh = cast(mesh, precision);
if type == "increasing"
    ordered_mesh = sort(mesh, "ascend");
elseif type == "decreasing"
    ordered_mesh = sort(mesh, "descend");
elseif type == "leja"

    % Find the largest abs. value
    [~, i] = max(abs(mesh));
    mesh([1 i]) = mesh([i 1]); % swap to first position

    p = ones(n,1); % store the products 
    for k =2:length(mesh)
        for i = k:length(mesh)
            p(i) = p(i) * abs(a(i) - a(k-1));
        end

        [~, best_idx] = max(p(k:n));
        best_idx = best_idx + k -1; 
        mesh([k best_idx]) = mesh([best_idx k]); 
        p([k best_idx]) = p([best_idx k]);
    end 
end
% final cast to ensure correct precision 
ordered_mesh = cast(ordered_mesh, precision); 
end

