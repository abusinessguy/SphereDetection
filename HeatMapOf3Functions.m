clf
clc
clear all
close all;

% Define the range of x and y values
x = linspace(0, 100, 100);
y = linspace(0, 100, 100);

% Create a grid of x and y values
[X, Y] = meshgrid(x, y);

% Define three different quadratic functions
function1 = @(x, y) (x - 1).^2 + (y - 9).^2;
function2 = @(x, y) (x - 5).^2 + (y - 7).^2;
function3 = @(x, y) (x - 10).^2 + (y - 10).^2;

% Evaluate each function on the grid
Z1 = function1(X, Y);
Z2 = function2(X, Y);
Z3 = function3(X, Y);

% Aggregate results (simple summation for illustration)
aggregatedResults = Z1 + Z2 + Z3;

% Create a heatmap
figure;
heatmap(x, y, aggregatedResults');
xlabel('X');
ylabel('Y');
title('Popularity Heatmap across 3 Functions');

globalMin = min(aggregatedResults(:));
[row, col] = find(aggregatedResults == globalMin);
disp(['The global maximum value occurs at coordinates: (' num2str(x(col)) ', ' num2str(y(row)) ')']);
