clear all;

% Parameters (play around with different images and different parameters)

N = 200;
alpha = 0.1;
beta = 0.02;
gamma = 0.3;
kappa = 0.5;
Wline = 0.4;
Wedge = 1.0;
Wterm = 0.5;
sigma = 2.0;

% Load image
I = imread('images/circle.jpg');
if (ndims(I) == 3)
    I = rgb2gray(I);
end

% Initialize the snake
[x, y] = initializeSnake(I);

% Calculate external energy
I_smooth = double(imgaussfilt(I, sigma));
Eext = getExternalEnergy(I_smooth,Wline,Wedge,Wterm);

% Calculate matrix A^-1 for the iteration
Ainv = getInternalEnergyMatrixBonus(size(x,2), alpha, beta, gamma);

% Iterate and update positions
displaySteps = floor(N/10);
for i=1:N
    % Iterate
    [x,y] = iterate(Ainv, x, y, Eext, gamma, kappa);

    % Plot intermediate result
    imshow(I); 
    hold on;
    plot([x x(1)], [y y(1)], 'r-');
    %hold on;
    % Display step
    if(mod(i,displaySteps)==0)
        fprintf('%d/%d iterations\n',i,N);
    end
    
    pause(0.0001)
    %pause(0.1)
end
 
if(displaySteps ~= N)
    fprintf('%d/%d iterations\n',N,N);
end