% Завантаження зображення
img = imread('image.jpg');

% Показ оригінального зображення
figure;
imshow(img);
title('Оригінальне зображення');

% Перетворення зображення на сіре та тип даних double
gray_img = im2double(rgb2gray(img));

% Показ сірого зображення
figure;
imshow(gray_img);
title('Сіре зображення');

% Додавання шуму "сіль і перець"
noisy_img = imnoise(gray_img, 'salt & pepper', 0.02);

% Фільтрація зображення за допомогою фільтра Габора
wavelength = 3;
orientation = 0;
gabor_filter = gabor(wavelength, orientation);
filtered_img = imgaborfilt(noisy_img, gabor_filter);

% Показ фільтрованого зображення
figure;
imshow(filtered_img);
title('Фільтроване зображення');

% Оцінка похибки фільтрації
error = immse(filtered_img, gray_img);
percent_error = error * 100;
fprintf('Похибка фільтрації: %.2f%%\n', percent_error);

% Відображення різницевого зображення
diff_img = abs(filtered_img - gray_img);
figure;
imshow(diff_img);
title('Різницеве зображення');
