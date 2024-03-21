function [xCenter,yCenter, radius] = TargetedCircleFinder7(rows,cols,chunkSize, minRadius, maxRadius, LastXCenter, LastYCenter, pixelRange)
%Summary of this function goes here
% Define the range of x and y values
y = ((LastYCenter-pixelRange):chunkSize:(LastYCenter+pixelRange));
x = ((LastXCenter-pixelRange):chunkSize:(LastXCenter+pixelRange));
z = (0:chunkSize:maxRadius);

aggregatedResults = zeros(length(x), length(y), maxRadius);
for i = 1:size(rows)
    for pixY = 1:length(y)
        for pixX = 1:length(x)
            Z = fix((sqrt((rows(i) - y(pixY)).^2 + (cols(i) - x(pixX)).^2))/chunkSize);
            if Z < maxRadius/chunkSize && Z > minRadius/chunkSize
                aggregatedResults(pixX, pixY, Z*chunkSize) = aggregatedResults(pixX, pixY, Z*chunkSize) + 1;
            end
        end
    end
end

% Find the global maximum value
globalMax = max(aggregatedResults(:));

% Find the indices of the maximum value
[indX, indY, indZ] = ind2sub(size(aggregatedResults), find(aggregatedResults == globalMax));

xCenter = x(fix(mean(indX)));%*chunkSize;
yCenter = y(fix(mean(indY)));%*chunkSize;
radius = fix(mean(indZ));

end

