clf
clc
clear all
%% Start Functions
%figure(1)
% Read an image from file
img = imread('tokyo.jpg');

% % Display the image
% imshow(img);
% 
% % Optional: You can also customize the display, such as adding a title
% title('Lambo');

%% im2bw
% This example uses im2bw to convert a grayscale image to a binary image 
% using a specified threshold.
figure(2)

% Create a grayscale image
img_gray = rgb2gray(img);

% Calculate the gradient along the x and y directions
[Gmag,Grot] = imgradient(img_gray,'prewitt');

img_bw = Gmag > 80;

% Define an array of threshold values
thresholds = [50, 100, 150, 200];

% Create a subplot for each threshold
figure;

for i = 1:length(thresholds)
    % Apply threshold
    img_bw_test = Gmag > thresholds(i);
    
    % Display the binary image
    subplot(2, 2, i);
    imshow(img_bw_test);
    title(['Threshold = ' num2str(thresholds(i))]);
end
%img_bw = im2bw(Gx, 20); % Convert to binary image using a threshold of 0.5

% Display the original and binary imheages
subplot(1, 3, 1), imshow(img), title('Original Image');
subplot(1, 3, 2), imshow(img_gray), title('Grayscale Image');
subplot(1, 3, 3), imshow(img_bw), title('Binary Image');


%% Read the image
% Apply Canny edge detection
%edgeImg = edge(grayImg, 'Canny');

% Perform Hough transform to detect lines
[H, theta, rho] = hough(img_bw);

% Find peaks in the Hough transform
peaks = houghpeaks(H, 50);

% Extract lines using HoughLines function
lines = houghlines(img_bw, theta, rho, peaks);

% Display the original image
figure(3);
imshow(img_gray);
hold on;
% 
% % Plot the detected lines on top of the original image
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'r');
end

hold off;