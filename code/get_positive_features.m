% Starter code prepared by James Hays for CS 143, Brown University
% This function should return all positive training examples (faces) from
% 36x36 images in 'train_path_pos'. Each face should be converted into a
% HoG template according to 'feature_params'. For improved performance, try
% mirroring or warping the positive training examples.

function features_pos = get_positive_features(train_path_pos, feature_params, img_ext)
% 'train_path_pos' is a string. This directory contains 36x36 images of
%   faces
% 'feature_params' is a struct, with fields
%   feature_params.template_size (probably 36), the number of pixels
%      spanned by each train / test template and
%   feature_params.hog_cell_size (default 6), the number of pixels in each
%      HoG cell. template size should be evenly divisible by hog_cell_size.
%      Smaller HoG cell sizes tend to work better, but they make things
%      slower because the feature dimensionality increases and more
%      importantly the step size of the classifier decreases at test time.


% 'features_pos' is N by D matrix where N is the number of faces and D
% is the template dimensionality, which would be
%   (feature_params.template_size / feature_params.hog_cell_size)^2 * 31
% if you're using the default vl_hog parameters

% Useful functions:
% vl_hog, HOG = VL_HOG(IM, CELLSIZE)
%  http://www.vlfeat.org/matlab/vl_hog.html  (API)
%  http://www.vlfeat.org/overview/hog.html   (Tutorial)
% rgb2gray

narginchk(2, 3);
if nargin < 3, img_ext = 'jpg'; end

image_files = dir( fullfile( train_path_pos, ['*.' img_ext]) ); %Caltech Faces stored as .$(img_ext)
num_images = length(image_files);

for i = 1 : num_images
    imName = fullfile(train_path_pos,image_files(i).name);
    imgRGB =  imread(imName);
    img = im2single(rgb2gray(imgRGB));
    [features, features_view]= extractHOGFeatures(img);
end
% placeholder to be deleted
features_pos = rand(100, (feature_params.template_size / feature_params.hog_cell_size)^2 * 31);