% Corie Wilson
% OMCS Computational Photo
% Create "photomosaic" final project

[full_image] = imread('C:\Users\wilsoncorie\Pictures\Photo\Photo1.jpg', 'jpg');
info = imfinfo('C:\Users\wilsoncorie\Pictures\Photo\Photo1.jpg', 'jpg');

size_x_full = info.Width;
size_y_full = info.Height;
figure;
image(full_image);

%Mask input image. 
[tile] = imread('C:\Users\wilsoncorie\Pictures\Photo\Mask3.jpg', 'jpg');
tile_info = imfinfo('C:\Users\wilsoncorie\Pictures\Photo\Photo1.jpg', 'jpg');

size_x_tile = tile_info.Width;
size_y_tile = tile_info.Height;
figure;
image(tile);
num_x_tile = 90;
num_y_tile = 90;

count = 1;
num_cells = num_x_tile * num_y_tile;
size_x_tile = round(size_x_tile / num_x_tile)-1;
size_y_tile = round(size_y_tile / num_y_tile)-1;

clear aver;
for j = 0:num_y_tile-1,
   for i = 0:num_x_tile-1,
      temp = tile(j*size_y_tile+1:(j+1)*size_y_tile, i*size_x_tile+1:(i+1)*size_x_tile, :);      
                tile_small(j+1, i+1, 1) = mean(mean(mean(temp(:, :, :))));
                tile_small(j+1, i+1, 2) = mean(mean(mean(temp(:, :, :))));
                tile_small(j+1, i+1, 3) = mean(mean(mean(temp(:, :, :))));
      axis off;
   end
end

rmax = max(max(tile_small(:, :, 1)));
gmax = max(max(tile_small(:, :, 2)));
bmax = max(max(tile_small(:, :, 3)));
tile_small(:, :, 1) = tile_small(:, :, 1)./rmax;
tile_small(:, :, 2) = tile_small(:, :, 2)./gmax;
tile_small(:, :, 3) = tile_small(:, :, 3)./bmax;
image(tile_small);

clear aver;

% Try changing these numbers
num_x = 20;
num_y = 20;

count = 1;
num_cells = num_x * num_y;
size_x = round(size_x_full / num_x)-1;
size_y = round(size_y_full / num_y)-1;

for j = 0:num_y-1,
   for i = 0:num_x-1,
      temp = full_image(j*size_y+1:(j+1)*size_y, i*size_x+1:(i+1)*size_x, :);
      count = count + 1;
                aver(j+1, i+1, 1) = mean(mean(mean(temp(:, :, :))));
                aver(j+1, i+1, 2) = mean(mean(mean(temp(:, :, :))));
                aver(j+1, i+1, 3) = mean(mean(mean(temp(:, :, :))));
      axis off;
   end
end

rmax = max(max(aver(:, :, 1)));
gmax = max(max(aver(:, :, 2)));
bmax = max(max(aver(:, :, 3)));
aver_scaled(:, :, 1) = aver(:, :, 1)./rmax;
aver_scaled(:, :, 2) = aver(:, :, 2)./gmax;
aver_scaled(:, :, 3) = aver(:, :, 3)./bmax;
figure;
image(aver_scaled);

for j = 0:num_y-1,
   for i = 0:num_x-1,
                composite(j*num_y_tile+1:(j+1)*num_y_tile, i*num_x_tile+1:(i+1)*num_x_tile, :) = tile_small.*aver_scaled(j+1, i+1);
   end
end
image(composite);
axis off;

% This is the destination file.  Substitute filename and type.
imwrite(composite, 'C:\Users\wilsoncorie\Pictures\Photo\New.jpg', 'jpg');
