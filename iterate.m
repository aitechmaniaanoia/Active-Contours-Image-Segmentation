function [newX, newY] = iterate(Ainv, x, y, Eext, gamma, kappa)

% Get fx and fy
[fx, fy] = gradient(Eext);

% Iterate
ssx = gamma*x' + kappa*interp2(fx, x', y');
ssy = gamma*y' + kappa*interp2(fy, x', y');
newX = (Ainv*ssx)';
newY = (Ainv*ssy)';

% Clamp to image size
[row, col] = size(Eext);

for p = 1:length(newX)
    if newX(p) <= 0
        newX(p) = 1
    end
    if newY(p) <= 0
        newY(p) = 1
    end
    if newY(p) >= col
        newY(p) = col-1
    end
    if newX(p) >= row
        newX(p) = row-1
    end
end

end

