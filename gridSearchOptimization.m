% Load necessary image processing toolbox
pkg load image

% Clear workspace, command window, and close all figures
clear
clc
close all;

% Load main image
main = imread("./dataset/reference.png");

% Load test images
test_images = cell(1, 13);
for i = 1:13
    test_images{i} = imread(["./dataset/train/train" num2str(i) ".png"]);
end

% Define the range of resize ratios and Canny ratios to search
resize_ratios = 0.01:0.01:1.00;
canny_ratios = 0.01:0.01:1.00;

% Initialize variables to store the best parameters and success rate
best_resize_ratio = 0;
best_canny_ratio = 0;
best_success_rate = 0;


% Perform grid search
for resize_ratio = resize_ratios
    for canny_ratio = canny_ratios
        correct = 0;
        disp("--------------")
        canny_ratio, resize_ratio
        % Resize images
        resized_images = cellfun(@(img) imresize(img, resize_ratio), ...
            [test_images, {main}], 'UniformOutput', false);

        % Convert to grayscale
        gray_images = cellfun(@rgb2gray, resized_images, 'UniformOutput', false);

        % Apply Canny edge detection
        canny_edges = cellfun(@(gray) edge(gray, 'Canny', canny_ratio), ...
            gray_images, 'UniformOutput', false);

        % Analyze results with concise conditions
        whitePixelsEdge = cellfun(@(canny) sum(canny(:) == 1), canny_edges);
        filled_images = cellfun(@(canny) imfill(canny, 'holes'), ...
            canny_edges, 'UniformOutput', false);
        whitePixelsFilled = cellfun(@(filled) sum(filled(:) == 1), filled_images);

        % Concise conditions based on your original code
        conditions = {
            whitePixelsEdge(1) - whitePixelsEdge(14) <= 100 && ...
            whitePixelsFilled(14) - whitePixelsFilled(1) > 100, 1;

            whitePixelsEdge(2) - whitePixelsEdge(14) > 100, 2;

            whitePixelsEdge(3) - whitePixelsEdge(14) > 100, 3;

            whitePixelsEdge(4) - whitePixelsEdge(14) <= 100 && ...
            whitePixelsFilled(14) - whitePixelsFilled(4) <= 100, 4;

            whitePixelsEdge(5) - whitePixelsEdge(14) > 100, 5;

            whitePixelsEdge(6) - whitePixelsEdge(14) <= 100 && ...
            whitePixelsFilled(14) - whitePixelsFilled(6) > 100, 6;

            whitePixelsEdge(7) - whitePixelsEdge(14) > 100, 7;

            whitePixelsEdge(8) - whitePixelsEdge(14) <= 100 && ...
            whitePixelsFilled(14) - whitePixelsFilled(8) > 100, 8;

            whitePixelsEdge(9) - whitePixelsEdge(14) <= 100 && ...
            whitePixelsFilled(14) - whitePixelsFilled(9) > 100, 9;

            whitePixelsEdge(10) - whitePixelsEdge(14) <= 100 && ...
            whitePixelsFilled(14) - whitePixelsFilled(10) > 100, 10;

            whitePixelsEdge(11) - whitePixelsEdge(14) <= 100 && ...
            whitePixelsFilled(14) - whitePixelsFilled(1) > 100, 11;

            whitePixelsEdge(12) - whitePixelsEdge(14) <= 100 && ...
            whitePixelsFilled(14) - whitePixelsFilled(12) > 100, 12;

            whitePixelsEdge(13) - whitePixelsEdge(14) > 100, 13;
        };

        % Iterate over conditions
        for i = 1:size(conditions, 1)
            if conditions{i, 1}
                correct = correct + 1;
                disp(conditions{i, 2});
            end
        end
        disp(['Success Rate: %' num2str(correct * 100/13)]);
        best_success_rate * 100/13
        best_canny_ratio
        best_resize_ratio
        % Update best parameters if the success rate improves
        if correct > best_success_rate
            best_success_rate = correct;
            best_resize_ratio = resize_ratio;
            best_canny_ratio = canny_ratio;

        end
    end
end

% Display the best parameters and success rate
disp("************")
disp(['Best Resize Ratio: ' num2str(best_resize_ratio)]);
disp(['Best Canny Ratio: ' num2str(best_canny_ratio)]);
disp(['Best Success Rate: ' num2str(best_success_rate * 10)]);
disp("************")
