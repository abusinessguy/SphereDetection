clf
clc
clear all
%% Start Functions
% Choose the image
img = imread('0010.bmp');
% Convert the image to HSV color space
hsvImage = rgb2hsv(img);
hueChannel = hsvImage(:,:,1);
% Define the lower and upper bounds of the Hue range you want to display
lowerHue = 0.07; % Replace with your lower Hue value (between 0 and 1)
upperHue = 0.50; % Replace with your upper Hue value (between 0 and 1)
% Create a binary mask selecting pixels within the desired Hue range
hueMask = (hueChannel >= lowerHue) & (hueChannel <= upperHue);
%%
% Create a structuring element (disk-shaped kernel)
se = strel('disk', 20); % Adjust the size of the disk as needed

% Perform image opening then closing
openedImage = imopen(hueMask, se);
openedclosedImage = imclose(openedImage, se);

% Perform closing operation then opening
closedImage = imclose(hueMask, se);
closedopenedImage = imclose(closedImage, se);

% Display the original and opened images side by side
figure (1);
subplot(3, 2, 1);
imshow(hueMask);
title('Original');
ax = gca;
    
subplot(3, 2, 2);
imshow(hueMask);
title('Original');

subplot(3, 2, 3);
imshow(openedImage);
title('Opened');
ax = gca;
    
subplot(3, 2, 4);
imshow(closedImage);
title('Closed');

subplot(3, 2, 5);
imshow(openedclosedImage);
title('Opened then Closed');
ax = gca;
ax.XLabel.String = sprintf('This looks much better \n\n\n\n');
    
subplot(3, 2, 6);
imshow(closedopenedImage);
title('Closed then Opened');

%% Opening and closing multiple times
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
    figure (2);
    subplot(1, 2, 1);
    imshow(openedclosedImage);
    title(['Opened then Closed - Iteration ', num2str(iteration)]);
    ax = gca;
    ax.XLabel.String = sprintf('                             Suprisingly no big change from multiple opening and closings \n\n\n\n');
    
    subplot(1, 2, 2);
    imshow(closedopenedImage);
    title(['Closed then Opened - Iteration ', num2str(iteration)]);
end

%% Different Open and Close Disk sizes
se = strel('disk', 5);
openedclosedImage = imopen(hueMask, se);
openedclosedImage = imclose(openedclosedImage, se);

figure (3);
subplot(3, 2, 1);
imshow(openedclosedImage);
title('5');
ax = gca;

se = strel('disk', 10);
openedclosedImage = imopen(hueMask, se);
openedclosedImage = imclose(openedclosedImage, se);
subplot(3, 2, 2);
imshow(openedclosedImage);
title('10');

se = strel('disk', 20);
openedclosedImage = imopen(hueMask, se);
openedclosedImage = imclose(openedclosedImage, se);
subplot(3, 2, 3);
imshow(openedclosedImage);
title('20');
ax = gca;

se = strel('disk', 30);
openedclosedImage = imopen(hueMask, se);
openedclosedImage = imclose(openedclosedImage, se);
subplot(3, 2, 4);
imshow(openedclosedImage);
title('30');

se = strel('disk', 50);
openedclosedImage = imopen(hueMask, se);
openedclosedImage = imclose(openedclosedImage, se);
subplot(3, 2, 5);
imshow(openedclosedImage);
title('50');
ax = gca;

se = strel('disk', 100);
openedclosedImage = imopen(hueMask, se);
openedclosedImage = imclose(openedclosedImage, se);
subplot(3, 2, 6);
imshow(openedclosedImage);
title('100');
