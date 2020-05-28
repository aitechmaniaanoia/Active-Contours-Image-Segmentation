function [Ainv] = getInternalEnergyMatrixBonus(nPoints, alpha, beta, gamma)

A = beta*circshift(eye(nPoints), 2);
A = A - (alpha + 4*beta)*circshift(eye(nPoints), 1);
A = A + (2*alpha + 6*beta)*circshift(eye(nPoints), 0);
A = A - (alpha + 4*beta)*circshift(eye(nPoints), -1);
A = A + beta*circshift(eye(nPoints), -2);

Ainv = inv(A + gamma.*eye(nPoints));

end

