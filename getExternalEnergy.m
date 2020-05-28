function [Eext] = getExternalEnergy(I,Wline,Wedge,Wterm)

% Eline
Eline = im2double(I);

% Eedge
[Gmag, Gdir] = imgradient(I);

%Eedge = -1 * sqrt((Gmag.*Gmag + Gdir.*Gdir));
Eedge = -1 * (Gmag);

% Eterm
% define mask
m1 = [-1, 1];
m2 = [-1; 1];
m3 = [-1, -2, 1];
m4 = [-1; -2; 1];
m5 = [1, -1: -1, 1];

% calculate derivatives C
Cx = conv2(I, m1, 'same');
Cy = conv2(I, m2, 'same');
Cxx = conv2(I, m3, 'same');
Cyy = conv2(I, m4, 'same');
Cxy = conv2(I, m5, 'same');

[row, col] = size(I);

for i = 1: row
    for j = 1: col
        Eterm(i,j) = (Cyy(i,j)*Cx(i,j)*Cx(i,j) - 2*Cxy(i,j)*Cx(i,j)*Cy(i,j) + Cxx(i,j)*Cy(i,j)*Cy(i,j))/((1 + Cx(i,j)*Cx(i,j) + Cy(i,j)*Cy(i,j))^(3/2));
        
    end
end
        
% Eext
Eext = Wline*Eline + Wedge*Eedge + Wterm*Eterm;
Eext = Eext / max(Eext(:))

end

