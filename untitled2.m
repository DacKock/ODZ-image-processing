img = imread('1.jpg');
img_gray = rgb2gray(img);

noisy_img = im2double(img);
mean = 0; % середнє значення шуму
variance = 0.01; % дисперсія шуму (можна налаштувати за потребою)

% for i = 1:3 % пройтись по кожному каналу кольору (R, G, B)
%     noisy_img(:,:,i) = imnoise(img(:,:,i), 'gaussian', mean, variance);
% end

noisy_img = imnoise(img, 'gaussian', mean, variance);

% Додайте гаусів шум до зображення
noisy_gray_img = imnoise(img_gray, 'gaussian', mean, variance);

% figure;
% subplot(1, 2, 1);
% imshow(img);
% title('Original Image');
% 
% subplot(1, 2, 2);
% imshow(noisy_img);
% title('Noisy Image');


red_channel = noisy_img(:, :, 1);
green_channel = noisy_img(:, :, 2);
blue_channel = noisy_img(:, :, 3);

[LL_red, LH_red, HL_red, HH_red] = dwt2(red_channel, 'haar');
[LL_green, LH_green, HL_green, HH_green] = dwt2(green_channel, 'haar');
[LL_blue, LH_blue, HL_blue, HH_blue] = dwt2(blue_channel, 'haar');

% figure;
% subplot(2, 2, 1);
% imshow(LL_red, []);
% title('Approximation (LL) - Red Channel');
% 
% subplot(2, 2, 2);
% imshow(LH_red, []);
% title('Horizontal (LH) - Red Channel');
% 
% subplot(2, 2, 3);
% imshow(HL_red, []);
% title('Vertical (HL) - Red Channel');
% 
% subplot(2, 2, 4);
% imshow(HH_red, []);
% title('Diagonal (HH) - Red Channel');
% 
% figure;
% subplot(2, 2, 1);
% imshow(LL_green, []);
% title('Approximation (LL) - Green Channel');
% 
% subplot(2, 2, 2);
% imshow(LH_green, []);
% title('Horizontal (LH) - Green Channel');
% 
% subplot(2, 2, 3);
% imshow(HL_green, []);
% title('Vertical (HL) - Green Channel');
% 
% subplot(2, 2, 4);
% imshow(HH_green, []);
% title('Diagonal (HH) - Green Channel');
% 
% figure;
% subplot(2, 2, 1);
% imshow(LL_blue, []);
% title('Approximation (LL) - Blue Channel');
% 
% subplot(2, 2, 2);
% imshow(LH_blue, []);
% title('Horizontal (LH) - Blue Channel');
% 
% subplot(2, 2, 3);
% imshow(HL_blue, []);
% title('Vertical (HL) - Blue Channel');
% 
% subplot(2, 2, 4);
% imshow(HH_blue, []);
% title('Diagonal (HH) - Blue Channel');

[LL_gray, LH_gray, HL_gray, HH_gray] = dwt2(noisy_gray_img, 'haar');

% figure;
% subplot(2, 2, 1);
% imshow(LL_gray, []);
% title('Approximation (LL) - Gray Image');
% 
% subplot(2, 2, 2);
% imshow(LH_gray, []);
% title('Horizontal (LH) - Gray Image');
% 
% subplot(2, 2, 3);
% imshow(HL_gray, []);
% title('Vertical (HL) - Gray Image');
% 
% subplot(2, 2, 4);
% imshow(HH_gray, []);
% title('Diagonal (HH) - Gray Image');

% енергія оригінального зображення
energy_color_img = sum(abs(img(:)).^2);
% Обчислення енергії кожної компоненти для кольорового зображення
energy_LL_red = sum(sum(LL_red.^2));
energy_LH_red = sum(sum(LH_red.^2));
energy_HL_red = sum(sum(HL_red.^2));
energy_HH_red = sum(sum(HH_red.^2));

% енергія оригінального зображення
energy_gray_img = sum(abs(img_gray(:)).^2);
% Обчислення енергії кожної компоненти для сірого зображення
energy_LL_gray = sum(sum(LL_gray.^2));
energy_LH_gray = sum(sum(LH_gray.^2));
energy_HL_gray = sum(sum(HL_gray.^2));
energy_HH_gray = sum(sum(HH_gray.^2));

% Виведення результатів
fprintf('Енергія LL_red (кольорове зображення): %.2f\n', energy_LL_red);
fprintf('Енергія LH_red (кольорове зображення): %.2f\n', energy_LH_red);
fprintf('Енергія HL_red (кольорове зображення): %.2f\n', energy_HL_red);
fprintf('Енергія HH_red (кольорове зображення): %.2f\n', energy_HH_red);
fprintf('Енергія LL (сіре зображення): %.2f\n', energy_LL_gray);
fprintf('Енергія LH (сіре зображення): %.2f\n', energy_LH_gray);
fprintf('Енергія HL (сіре зображення): %.2f\n', energy_HL_gray);
fprintf('Енергія HH (сіре зображення): %.2f\n', energy_HH_gray);

fprintf('Енергія LL_red (кольорове зображення): %.2f%%\n', energy_LL_red / energy_color_img);
fprintf('Енергія LH_red (кольорове зображення): %.2f%%\n', energy_LH_red / energy_color_img);
fprintf('Енергія HL_red (кольорове зображення): %.2f%%\n', energy_HL_red / energy_color_img);
fprintf('Енергія HH_red (кольорове зображення): %.2f%%\n', energy_HH_red / energy_color_img);
fprintf('Енергія LL (сіре зображення): %.2f%%\n', energy_LL_gray / energy_gray_img);
fprintf('Енергія LH (сіре зображення): %.2f%%\n', energy_LH_gray / energy_gray_img);
fprintf('Енергія HL (сіре зображення): %.2f%%\n', energy_HL_gray / energy_gray_img);
fprintf('Енергія HH (сіре зображення): %.2f%%\n', energy_HH_gray / energy_gray_img);

% З'єднання компонент ДВП для кожного каналу
reconstructed_red = idwt2(LL_red, LH_red, HL_red, HH_red, 'haar');
reconstructed_green = idwt2(LL_green, LH_green, HL_green, HH_green, 'haar');
reconstructed_blue = idwt2(LL_blue, LH_blue, HL_blue, HH_blue, 'haar');

% Різницеве зображення для кожного каналу кольору
reconstructed_color_image = cat(3, reconstructed_red, reconstructed_green, reconstructed_blue);
red_channel_resized = imresize(red_channel, size(reconstructed_red));
green_channel_resized = imresize(green_channel, size(reconstructed_green));
blue_channel_resized = imresize(blue_channel, size(reconstructed_blue));

diff_red = double(reconstructed_red) - double(red_channel_resized);
diff_green = double(reconstructed_green) - double(green_channel_resized);
diff_blue = double(reconstructed_blue) - double(blue_channel_resized);

% Збірка різницевого зображення
diff_image = cat(3, diff_red, diff_green, diff_blue);

% diff_color_image = abs(im2double(img) - im2double(reconstructed_color_image));

% З'єднання компонентів ДВП (LL, LH, HL, HH) і отримання відновленого зображення
reconstructed_gray_image = idwt2(LL_gray, LH_gray, HL_gray, HH_gray, 'haar');
% Різницеве зображення сірого фото
img_gray_resize = imresize(img_gray, size(reconstructed_gray_image));
diff_gray_image = double(reconstructed_gray_image) - double(img_gray_resize);

diff_image = diff_image * 100;
diff_gray_image = diff_gray_image * 100;

figure;
subplot(1, 2, 1), imshow(diff_image , []), title('Різницеве зображення кольорового фото');
subplot(1, 2, 2), imshow(diff_gray_image , []), title('Різницеве зображення сірого фото');
 
% Обчислення норми Евкліда
d_img = double(img);
d_img_gray = double(img_gray);
euclidean_norm_color = norm(diff_image(:)) / norm(d_img(:)); 
euclidean_norm_gray = norm(diff_gray_image(:)) / norm(d_img_gray(:)); 

fprintf('Якість знешумлення (кольорове зображення): %.2f \n', euclidean_norm_color);
fprintf('Якість знешумлення (сіре зображення): %.2f \n', euclidean_norm_gray);


