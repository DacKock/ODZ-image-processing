% Завантаження кольорового фото
colorImage = imread('1.jpg');

% Додавання гаусів шуму до кольорового фото
noisyColorImage = imnoise(colorImage, 'gaussian');

% Декомпозиція кольорового фото за допомогою ДВП
[LLr, LHr, HLr, HHr] = dwt2(noisyColorImage(:, :, 1), 'haar');
[LLg, LHg, HLg, HHg] = dwt2(noisyColorImage(:, :, 2), 'haar');
[LLb, LHb, HLb, HHb] = dwt2(noisyColorImage(:, :, 3), 'haar');

% Завантаження сірого фото
grayImage = rgb2gray(colorImage);

% Додавання гаусів шуму до сірого фото
noisyGrayImage = imnoise(grayImage, 'gaussian');

% Декомпозиція сірого фото за допомогою ДВП
[LL, LH, HL, HH] = dwt2(noisyGrayImage, 'haar');

% Обчислення інформативних зображень для кольорового фото
informativeImageColor = sqrt(LHr.^2 + HLr.^2 + HHr.^2) + sqrt(LHg.^2 + HLg.^2 + HHg.^2) + sqrt(LHb.^2 + HLb.^2 + HHb.^2);

% Обчислення інформативного зображення для сірого фото
informativeImageGray = sqrt(LH.^2 + HL.^2 + HH.^2);

% Порівняння якості знешумлення обох фотографій
% Можна використовувати різні метрики, наприклад, PSNR (Peak Signal-to-Noise Ratio)
psnrColor = psnr(noisyColorImage, colorImage);
psnrGray = psnr(noisyGrayImage, grayImage);

% Відображення результатів
figure;
subplot(2, 2, 1), imshow(colorImage), title('Оригінальне кольорове фото');
subplot(2, 2, 2), imshow(noisyColorImage), title('Фото з гаусівим шумом');
subplot(2, 2, 3), imshow(informativeImageColor, []), title('Інформативне зображення кольорового фото');
subplot(2, 2, 4), imshow(abs(colorImage - noisyColorImage), []), title('Різницеве зображення кольорового фото');

figure;
subplot(2, 2, 1), imshow(grayImage), title('Оригінальне сіре фото');
subplot(2, 2, 2), imshow(noisyGrayImage), title('Сіре фото з гаусівим шумом');
subplot(2, 2, 3), imshow(informativeImageGray, []), title('Інформативне зображення сірого фото');
subplot(2, 2, 4), imshow(abs(grayImage - noisyGrayImage), []), title('Різницеве зображення сірого фото');

% Виведення значень PSNR
disp(['PSNR для кольорового фото: ', num2str(psnrColor)]);
disp(['PSNR для сірого фото: ', num2str(psnrGray)]);
