clf
clc
clear all
%% Start Functions
% Read the image
img = imread('0001.bmp');

% Create a figure and display the image
figure (1);
imshow(img);
title('Hover over pixels to see HSV values');

% Enable impixelinfo to display pixel information
impixelinfo;

%%
% Convert the image to HSV color space
hsvImage = rgb2hsv(img);

% Create a new figure
figure (2);
tiledlayout(2,2,'TileSpacing','none')
% Subplot 1: Hue (H) channel
nexttile
hueChannel = hsvImage(:,:,1);
imshow(hueChannel);
title('Hue (H) Channel');
colormap(gca, 'hsv'); % Set the colormap to HSV for better visualization
colorbar; % Display a colorbar for reference

% Subplot 2: Saturation (S) channel
nexttile;
saturationChannel = hsvImage(:,:,2);
imshow(saturationChannel);
title('Saturation (S) Channel');
colorbar; % Display a colorbar for reference

% Subplot 3: Value (V) channel
nexttile
valueChannel = hsvImage(:,:,3);
imshow(valueChannel);
title('Value (V) Channel');

%% Hue Finder
figure (3);
imshow(hueChannel);
title('Hover over pixels to see Hue values');
colormap(gca, 'hsv'); % Set the colormap to HSV for better visualization
colorbar; % Display a colorbar for reference
% Enable impixelinfo to display pixel information
impixelinfo;

%% Hue Selection
% % Define the lower and upper bounds of the Hue range you want to display
% lowerHue = 0.07; % Replace with your lower Hue value (between 0 and 1)
% upperHue = 0.50; % Replace with your upper Hue value (between 0 and 1)
% 
% % Create a binary mask selecting pixels within the desired Hue range
% hueMask = (hueChannel >= lowerHue) & (hueChannel <= upperHue);
% 
% % Display the Hue values within the specified range
% figure (4);
% imshow(hueMask);
% %title(['Temperature is ',num2str(c),' C'])
% title(['Hue Values in Range ', num2str(lowerHue), ' to ', num2str(upperHue)]);
% colorbar; % Display a colorbar for reference
% ax = gca;
% ax.XLabel.String = sprintf('It is important not to be overly selective in this stage. \n Yes you can be more selective in this image but the results will not scale for all images.\n\n\n');
interactiveHueSelection(hueChannel)

function interactiveHueSelection(hueChannel)
    % Initial values for lower and upper hue
    lowerHue = 0.07;
    upperHue = 0.50;

    % Create figure 4 or select it if it already exists
    f = figure(4);
    clf(f); % Clear current figure
    set(f, 'Name', 'Interactive Hue Selection');

    % Define positions
    sliderWidth = 300;
    labelHeight = 30;
    sliderHeight = 40;
    gap = 10; % Gap between slider and label
    figureWidth = f.Position(3);

    % Position for lower slider and label
    lowerSliderLeft = (figureWidth / 4) - (sliderWidth / 2);
    sliderLower = uicontrol('Parent', f, 'Style', 'slider', 'Position', [lowerSliderLeft, labelHeight + gap, sliderWidth, sliderHeight], 'Value', lowerHue, 'Min', 0, 'Max', 1);
    labelLower = uicontrol('Parent', f, 'Style', 'text', 'Position', [lowerSliderLeft, 0, sliderWidth, labelHeight], 'String', sprintf('Lower: %.2f', lowerHue));
    
    % Position for upper slider and label
    upperSliderLeft = (3 * figureWidth / 4) - (sliderWidth / 2);
    sliderUpper = uicontrol('Parent', f, 'Style', 'slider', 'Position', [upperSliderLeft, labelHeight + gap, sliderWidth, sliderHeight], 'Value', upperHue, 'Min', 0, 'Max', 1);
    labelUpper = uicontrol('Parent', f, 'Style', 'text', 'Position', [upperSliderLeft, 0, sliderWidth, labelHeight], 'String', sprintf('Upper: %.2f', upperHue));
    
    % Set Callbacks for Sliders
    sliderLower.Callback = @(es,ed) sliderCallback(es, sliderUpper, hueChannel, labelLower, labelUpper);
    sliderUpper.Callback = @(es,ed) sliderCallback(sliderLower, es, hueChannel, labelLower, labelUpper);

    % Initial display
    sliderCallback(sliderLower, sliderUpper, hueChannel, labelLower, labelUpper);
end

function sliderCallback(sliderLower, sliderUpper, hueChannel, labelLower, labelUpper)
    lowerHue = sliderLower.Value;
    upperHue = sliderUpper.Value;
    
    % Update the labels
    labelLower.String = sprintf('Lower: %.2f', lowerHue);
    labelUpper.String = sprintf('Upper: %.2f', upperHue);

    % Update the Hue mask and display
    hueMask = (hueChannel >= lowerHue) & (hueChannel <= upperHue);
    imshow(hueMask);
    title(['Hue Values in Range ', num2str(lowerHue), ' to ', num2str(upperHue)]);
    colorbar;
end

