function [x, y] = initializeSnake(I)

% Show figure
imshow(I);
hold on;

% Get initial points
[x,y] = getpts();
cPoly = [x,y];

% Interpolate
numberOfPoints = length(cPoly);
%disp(numberOfPoints);

originalSpacing = 1:numberOfPoints;
finerSpacing = 1:0.1:numberOfPoints;

splineXY = spline(originalSpacing, cPoly', finerSpacing);

x=splineXY(1,:);
y = splineXY(2,:);

% Clamp points to be inside of image
[row, col] = size(I);
%disp(i);
%disp(j);
for p = 1:length(splineXY)
    if x(p) <= 0
        x(p) = 1
    end
    if y(p) <= 0
        y(p) = 1
    end
    if x(p) >= row
        x(p) = row-1
    end
    if y(p) >= col
        y(p) = col-1
    end
end

plot([x x(1)], [y y(1)], 'r');
%plot(x,y, 'r');
hold on;

end

