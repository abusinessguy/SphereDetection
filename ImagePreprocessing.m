clf
clc
clear all
%% Start Functions
% Choose the image
img = imread('0010.bmp');

% Convert the image to HSV color space
hsvImage = rgb2hsv(img);

figure (1);
hueChannel = hsvImage(:,:,1);
imshow(hueChannel);
title('Hue (H) Channel');
colorbar; % Display a colorbar for reference
ax = gca;
ax.XLabel.String = sprintf('This is the layer which hold the most valuable infomation for our mission. \n\n\n\n');

%%
% Define the lower and upper bounds of the Hue range you want to display
lowerHue = 0.07; % Replace with your lower Hue value (between 0 and 1)
upperHue = 0.50; % Replace with your upper Hue value (between 0 and 1)

% Create a binary mask selecting pixels within the desired Hue range
hueMask = (hueChannel >= lowerHue) & (hueChannel <= upperHue);

% Display the Hue values within the specified range
figure (2);
imshow(hueMask);
title('Hue Values in the Specified Range');
colorbar; % Display a colorbar for reference
ax = gca;
ax.XLabel.String = sprintf('It is important not to be overly selective in this stage. \n Yes you can be more selective in this image but the results will not scale for all images.\n\n\n');

%% Opening and closing 
% Create a structuring element (disk-shaped kernel)
se = strel('disk', 20); % Adjust the size of the disk as needed

% Perform image opening then closing
openedclosedImage = imopen(hueMask, se);
openedclosedImage = imclose(openedclosedImage, se);

% Perform closing operation then opening
closedopenedImage = imclose(hueMask, se);
closedopenedImage = imclose(closedopenedImage, se);

% Display the original and opened images side by side
figure (4);
subplot(1, 2, 1);
imshow(openedclosedImage);
title('Opened then Closed');
ax = gca;
ax.XLabel.String = sprintf('This looks much better \n\n\n\n');
    
subplot(1, 2, 2);
imshow(closedopenedImage);
title('Closed then Opened');


% Opening and closing multiple times
% Number of times to repeat opening and closing
numIterations = 30;
openedclosedImage = hueMask;
closedopenedImage = hueMask;
% Loop for the specified number of iterations
for iteration = 1:numIterations
    % Perform image opening then closing
    openedclosedImage = imopen(openedclosedImage, se);
    openedclosedImage = imclose(openedclosedImage, se);

    % Perform closing operation then opening
    closedopenedImage = imclose(closedopenedImage, se);
    closedopenedImage = imopen(closedopenedImage, se);

    % Display the original and opened images side by side
    figure (6);
    subplot(1, 2, 1);
    imshow(openedclosedImage);
    title(['Opened then Closed - Iteration ', num2str(iteration)]);
    ax = gca;
    ax.XLabel.String = sprintf('                             Suprisingly no big change from multiple opening and closings \n\n\n\n');
    
    subplot(1, 2, 2);
    imshow(closedopenedImage);
    title(['Closed then Opened - Iteration ', num2str(iteration)]);
end

%Suprisingly no big change from multiple opening and closings
%% Make the outline
% Calculate the gradient along the x and y directions
[Gmag,Grot] = imgradient(openedclosedImage,'prewitt');
figure (7);
imshow(Gmag);
title('Prewitt Gradient (Derivative)');
impixelinfo;
% Here we are taking the gradient (derivative) using the Prewitt mask which will give an
% outline of our shape

%% Find the circle
%The key to success here is being very accepting of anything being a circle
%so high sensetivity, combined with having a real good idea of the radius
%so we can throw away all the wrong circles

% Set parameters for imfindcircles
minRadius = 110;
maxRadius = 350;
sensitivity = 0.99;

% Use imfindcircles to detect circles
[centers, radii, metric] = imfindcircles(Gmag, [minRadius, maxRadius], 'ObjectPolarity', 'bright', 'Sensitivity', sensitivity)

figure (8);
imshow(img);
hold on;
viscircles(centers, radii, 'EdgeColor', 'b');
hold off;

subplot(1, 2, 1);
imshow(Gmag);
hold on;
viscircles(centers, radii, 'EdgeColor', 'b');
hold off;
title('Circle Found from Derivative Image ');

    
subplot(1, 2, 2);
imshow(img);
hold on;
viscircles(centers, radii, 'EdgeColor', 'b');
hold off;
title('Overlayed on Original Image');
