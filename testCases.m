% Load necessary image processing toolbox
pkg load image;

% Clear workspace, command window, and close all figures
clear
clc
close all;

% Load reference and test images
referenceImage = imread("./dataset/reference.png");
test1 = imread("./dataset/test/test1.png");
test2 = imread("./dataset/test/test2.png");
test3 = imread("./dataset/test/test3.png");
test4 = imread("./dataset/test/test4.png");
test5 = imread("./dataset/test/test5.png");
test6 = imread("./dataset/test/test6.png");
test7 = imread("./dataset/test/test7.png");

% Set resize and Canny edge detection ratios
resizeRatio = 0.38;
cannyRatio = 0.88;
correct = 0;

% Resize the test and reference images
resizedImages = cellfun(@(img) imresize(img, resizeRatio), ...
    {test1, test2, test3, test4, test5, test6, test7, referenceImage}, 'UniformOutput', false);

% Convert resized images to grayscale
grayImages = cellfun(@rgb2gray, resizedImages, 'UniformOutput', false);

% Apply Canny edge detection
cannyEdges = cellfun(@(gray) edge(gray, 'Canny', cannyRatio), grayImages, 'UniformOutput', false);

% Count white pixels in Canny edges
whitePixelsEdge = cellfun(@(canny) sum(canny(:) == 1), cannyEdges);

% Fill the Canny edges and count white pixels in the filled images
filledImages = cellfun(@(canny) imfill(canny, 'holes'), cannyEdges, 'UniformOutput', false);
whitePixelsFilled = cellfun(@(filled) sum(filled(:) == 1), filledImages);

% Check conditions for each test image
if (whitePixelsEdge(1) - whitePixelsEdge(8) <= 100) && ...
    (whitePixelsFilled(8) - whitePixelsFilled(1) > 100)
    correct = correct + 1;
    disp(1);
end

if (whitePixelsEdge(2) - whitePixelsEdge(8) > 100)
    correct = correct + 1;
    disp(2);
end

if (whitePixelsEdge(3) - whitePixelsEdge(8) > 100)
    correct = correct + 1;
    disp(3);
end

if (whitePixelsEdge(4) - whitePixelsEdge(8) <= 100) && ...
   (whitePixelsFilled(8) - whitePixelsFilled(4) > 100)
    correct = correct + 1;
    disp(4);
end

if (whitePixelsEdge(5) - whitePixelsEdge(8) > 100)
    correct = correct + 1;
    disp(5);
end

if (whitePixelsEdge(6) - whitePixelsEdge(8) <= 100) && ...
   (whitePixelsFilled(8) - whitePixelsFilled(6) > 100)
    correct = correct + 1;
    disp(6);
end

if (whitePixelsEdge(7) - whitePixelsEdge(8) > 100)
    correct = correct + 1;
    disp(7);
end

% Calculate success rate
successRate = correct * 100/7
