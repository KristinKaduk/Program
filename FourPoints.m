function [placement] = FourPoints(vectX, vectY, hight, width)

% placement= zeros(length(vectX)*length(vectY),1);
placement = cell((length(vectX)*length(vectY)),1);
index = 1;

for i = 1:length(vectX)
    for j = 1:length(vectY)
        placement(index)= {[vectX(i) - width/2 vectY(j) - hight/2 vectX(i) + width/2 vectY(j) + hight/2]};
        index = index + 1;
    end
end
end
