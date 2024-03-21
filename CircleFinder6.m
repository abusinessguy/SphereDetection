function [xCenter,yCenter, radius] = CircleFinder6(rows,cols,height, width,chunkSize, minRadius, maxRadius)
%Summary of this function goes here

% Define the range of x and y values
y = (0:chunkSize:height);
x = (0:chunkSize:width);
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

xCenter = fix(mean(indX))*chunkSize;
yCenter = fix(mean(indY))*chunkSize;
radius = fix(mean(indZ));

end

