clf;
clc;
clear all;
close all;

radius = 0;

% Read the video file 
videoFile = 'seq1.mkv';
videoObj = VideoReader(videoFile); 

% Initialize video writer
outputVideo = VideoWriter('processedVideo.avi');
open(outputVideo);


while hasFrame(videoObj)
    img =  readFrame(videoObj);
    
    if radius == 0;
        [rows,cols, height, width] = ImageToWhiteRowsCols(img, 20);
        chunkSize = 10;
        minRadius = 100;
        maxRadius = 350;
        [xCenter,yCenter, radius] = CircleFinder6(rows,cols, height, width,chunkSize, minRadius, maxRadius);
        figure (1);
        hold on;
        imshow(img);
        viscircles([xCenter, yCenter], radius, 'EdgeColor', 'b');
        %impixelinfo;
        hold off;
        lastRadius = radius;
        frame = getframe(gcf); % Capture the current figure
        writeVideo(outputVideo, frame);
    else;
        [rows,cols, height, width] = TargetedImagageToWhiteRowsCols(img, 3, xCenter, yCenter, radius);
        chunkSize = 1;
        radiusChange = (abs(radius - lastRadius)+10)*2;
        minRadius = radius - radiusChange;
        maxRadius = radius + radiusChange;
        lastRadius = radius;
        pixelRange = 40;
        [xCenter,yCenter, radius] = TargetedCircleFinder7(rows,cols,chunkSize, minRadius, maxRadius, xCenter, yCenter, pixelRange);
        figure (1);
        hold on;
        imshow(img);
        viscircles([xCenter, yCenter], radius, 'EdgeColor', 'b');
        %impixelinfo;
        hold off;
        frame = getframe(gcf); % Capture the current figure
        writeVideo(outputVideo, frame);
    end;    
end 

% Close the video writer
close(outputVideo);

