% Load the image processing toolbox
pkg load image;

% Load reference and demo images
referenceImage = imread("./dataset/reference.png");
demoImage = imread("./dataset/demoImage.png");

% Set resize and Canny edge detection ratios
resizeRatio = 0.38;
cannyRatio = 0.88;

% Resize the demo and reference images
resizedImages = cellfun(@(img) imresize(img, resizeRatio), ...
    {demoImage, referenceImage}, 'UniformOutput', false);

% Convert resized images to grayscale
grayImages = cellfun(@rgb2gray, resizedImages, 'UniformOutput', false);

% Apply Canny edge detection
cannyEdges = cellfun(@(gray) edge(gray, 'Canny', cannyRatio), grayImages, 'UniformOutput', false);

% Count white pixels in Canny edges
whitePixelsEdge = cellfun(@(canny) sum(canny(:) == 1), cannyEdges);

% Fill the Canny edges and count white pixels in the filled images
filledImages = cellfun(@(canny) imfill(canny, 'holes'), cannyEdges, 'UniformOutput', false);
whitePixelsFilled = cellfun(@(filled) sum(filled(:) == 1), filledImages);

% Initialize variable to store the result type
resultType = "";

% Determine the result type based on conditions
if (whitePixelsEdge(1) - whitePixelsEdge(2) <= 100) && ...
     (whitePixelsFilled(2) - whitePixelsFilled(1) > 100)
     resultType = "edge";
end

if (whitePixelsEdge(1) - whitePixelsEdge(2) > 100)
     resultType = "middle";
end

if ((whitePixelsEdge(1) - whitePixelsEdge(2)) <= 100 && (whitePixelsFilled(2) - whitePixelsFilled(1) <= 100))
     resultType = "perfect";
end

% Display the resized, grayscale, and Canny versions of the images
figure;

subplot(1, 4, 1);
imshow(demoImage);

subplot(1, 4, 2);
imshow(resizedImages{1});

subplot(1, 4, 3);
imshow(grayImages{1});

subplot(1, 4, 4);
imshow(cannyEdges{1});

% Create message for the popup
msg = ["Result : " resultType];
popupTitle = 'Result box';

% Display the message box
msgbox(msg, popupTitle);
