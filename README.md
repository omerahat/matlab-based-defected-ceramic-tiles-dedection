# Matlab Based Defected Ceramic Tiles Dedection

This repository contains MATLAB scripts designed for image processing optimization, testing, and demonstration. The scripts utilize the image processing toolbox for various operations.

## 1. `gridSearchOptimization.m`

### Summary:

The `gridSearchOptimization.m` script aims to optimize parameters for image processing operations, specifically resize ratios and Canny edge detection ratios. It performs a **grid search** over a range of ratios and evaluates success based on predefined conditions.

### Usage:

1. **Input:**
   - Load a reference image (`reference.png`).
   - Load training images (`train1.png` to `train13.png`).
2. **Parameters:**
   - Define the range of resize and Canny ratios.
3. **Output:**
   - Display the best parameters and success rate.

### Conditions:

The success rate is determined based on specific conditions related to the number of white pixels in Canny edges and filled images.

**Grid Search Results:**
- After performing the grid search, optimal parameters were found.
- Best Resize Ratio: `0.38`
- Best Canny Ratio: `0.88`
- Best Success Rate: `100%`

## 2. `testCases.m`

### Summary:

The `testCases.m` script tests the performance of the image processing algorithm using predefined conditions. It evaluates correctness on a set of test cases and calculates the success rate.

### Usage:

1. **Input:**
   - Load a reference image (`reference.png`).
   - Load test images (`test1.png` to `test7.png`).
2. **Parameters:**
   - Set resize and Canny ratios.
3. **Output:**
   - Calculate the success rate based on predefined conditions.

**Test Results:**
- Using the parameters obtained from the grid search, the algorithm achieved a **100%** success rate on a set of 7 test images.

## 3. `demo.m`

### Summary:

The `demo.m` script demonstrates the image processing algorithm on a demo image. It categorizes the result based on specific conditions and displays visual comparisons of the original and processed images.

### Usage:

1. **Input:**
   - Load a reference image (`reference.png`).
   - Load a demo image (`demoImage.png`).
2. **Parameters:**
   - Set resize and Canny ratios.
3. **Output:**
   - Display the resized, grayscale, and Canny versions of the images.
   - Show a message box with the result type (`edge`, `middle`, `perfect`).

## Notes:

- Ensure that the image processing toolbox is installed (`pkg load image`).
- Adjust parameters and conditions based on specific project requirements.

Feel free to explore, modify, and adapt these scripts to suit your image processing needs. For any questions or issues, please reach out to the repository owner.

## The paper I refer to:

[Matlab based automated surface defect detection system for ceremic tiles using image processing](https://ieeexplore.ieee.org/abstract/document/7872824)

Thanks!

-> To reach me [CLICK!](https://bento.me/ahat)
