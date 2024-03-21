function [rows,cols,height, width] = TargetedImagageToWhiteRowsCols(picture, diskSize, xCenter, yCenter, radius)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% Prepare Image
% Read the image
img = picture; %imread(picture);
% Get image size
[height, width, depth] = size(img);
radius =radius + 40;
[xx, yy] = meshgrid(1:width, 1:height);
mask = (xx - xCenter).^2 + (yy - yCenter).^2 <= radius^2;

% Convert the image to HSV color space
hsvImage = rgb2hsv(img);
hueChannel = hsvImage(:,:,1);
% Define the lower and upper bounds of the Hue range you want to find
lowerHue = 0.07; % Replace with your lower Hue value (between 0 and 1)
upperHue = 0.50; % Replace with your upper Hue value (between 0 and 1)
% Create a binary mask selecting pixels within the desired Hue range
hueMask = (hueChannel >= lowerHue) & (hueChannel <= upperHue);
% Opening and closing 
% Create a structuring element (disk-shaped kernel)
se = strel('disk', diskSize); % Adjust the size of the disk as needed
% Perform image opening then closing
openedImage = imopen(hueMask, se);
openedclosedImage = imclose(openedImage, se);
% Make the outline
% Calculate the gradient along the x and y directions
[Gmag,Grot] = imgradient(openedclosedImage,'prewitt');
binaryImage = im2bw(Gmag, .5).*mask;
%imshow(binaryImage);
% Find white pixels
[rows, cols] = find(binaryImage == 1);
end

