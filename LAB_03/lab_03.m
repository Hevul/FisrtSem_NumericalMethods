% Задаем функцию и интервал
f = @(x) x ./ (3 * x .^2  + 1);
a = -1;
b = 5;
x_val = linspace(a, b, 100);
y_o = f(x_val);
for i = 3:9
% Выбираем равноотстоящие узлы на отрезке [-1, 5]
n = i; % Количество узлов
n
x = linspace(a, b, n);
y = f(x);
% Вычисляем интерполяционный многочлен Лагранжа для заданных узлов
x_val = linspace(a, b, 100);
y_val = arrayfun(@(xv) lagrange_interpolation(x, y, xv), x_val);
% Используем функцию polyfit для сравнения с найденным многочленом Лагранжа
p = polyfit(x, y, n-1);
y_polyfit = polyval(p, x_val);
% Сравниваем результаты
figure('Position', [0, 0, 400, 400]);
plot(x_val, y_val, 'b-', x_val, y_polyfit, 'r--', x, y, 'ko', x_val, y_o, 'g--');
legend({'Лагранж', 'Polyfit', 'Узлы интерполяции', 'x / (3x^2 + 1)'}, 'Location', 'best');
xlabel('x');
ylabel('y');
title(' Лагранжа и polyfit n');
end


% Исходная функция и интервал
f = @(x) x ./ (3 * x .^2  + 1);
a = -1;
b = 5;

% Количество узлов интерполяции
n = 3;

% Создание равноотстоящих узлов интерполяции
x = linspace(a, b, n);
y = f(x);

% Построение интерполяционного многочлена Ньютона
coefficients = newton_coefficients(x, y);
newton_poly = @(t) newton_evaluate(coefficients, x, t);

% Создание вектора для графика
t = linspace(a, b, 1000);

% Проверка правильности с помощью polyfit
p = polyfit(x, y, n-1);

% Отображение графиков
figure;
figure('Position', [0, 0, 400, 400]);
plot(t, newton_poly(t), 'b-', t, polyval(p, t), 'r--', x, y, 'ko', t, f(t), 'g--');
legend({'Ньютон', 'Polyfit', 'Узлы интерполяции', 'x / (3x^2 + 1)'}, 'Location', 'best');
xlabel('x');
ylabel('y');
title(' Ньютон и polyfit n');


% Исходные данные
data = [-1.00 0.39;
        -0.72 0.64;
        -0.31 0.90;
        0.04 1.00;
        0.08 0.91;
        0.66 0.65;
        1.10 0.37;
        0.89 0.17;
        2.00 0.07;
        1.80 0.02];

% Разделение данных на координаты x и y
x_data = data(:, 1);
y_data = data(:, 2);

% Визуализация данных
figure;
plot(x_data, y_data, 'bo');
title('Табличные данные');
xlabel('x');
ylabel('y');
grid on;

% Преобразование данных x
inv_x_data = x_data;

% Метод наименьших квадратов
A = [length(x_data), sum(inv_x_data), sum(inv_x_data.^2); 
    sum(inv_x_data), sum(inv_x_data.^2), sum(inv_x_data.^3)
    sum(inv_x_data.^2), sum(inv_x_data.^3), sum(inv_x_data.^4)];
B = [sum(y_data); sum(inv_x_data .* y_data); sum(inv_x_data .^2 .* y_data)];
coeffs = A \ B; % коэффициенты аппроксимирующей функции
coeffs

% Вычисление аппроксимирующей функции
x_fit = linspace(min(x_data), max(x_data), 100);
y_fit = coeffs(1) + coeffs(2) .* x_fit + coeffs(3) .* x_fit .^2;

% Отображение аппроксимирующей функции и табличных данных на графике
figure;
plot(x_data, y_data, 'bo', x_fit, y_fit, 'r-');
title('Аппроксимация данных функцией (МНК)');
xlabel('x');
ylabel('y');
legend('Табличные данные', 'Аппроксимация');
grid on;
% Исходные и предсказанные значения
y_true = y_data; % истинные значения (наблюдаемые)
y_pred = coeffs(1) + coeffs(2) .* x_data + coeffs(3) .* x_data .^2; % предсказанные значения с использованием аппроксимирующей функции

% Вычисление RMSE
N = length(y_true);
RMSE = sqrt(sum((y_true - y_pred).^2) / N);
RMSE

function L = lagrange_interpolation(x, y, x_val)
    n = length(x); % число узлов интерполяции
    L = 0;
    % Цикл по всем узлам интерполяции
    for i = 1:n
        P = 1; % Инициализируем переменную для базисного полинома Лагранжа
        % Цикл для вычисления базисного полинома Лагранжа
        for j = 1:n
            if i ~= j
                % Вычисляем базисный полином Лагранжа для узла i
                P = P * (x_val - x(j)) / (x(i) - x(j));
            end
        end
        % Обновляем значение многочлена Лагранжа
        L = L + y(i) * P;
    end
end



 % Функция для вычисления коэффициентов интерполяционного многочлена Ньютона
function coeffs = newton_coefficients(x, y) 
    n = length(x); % Получаем число узлов интерполяции
    coeffs = zeros(1, n);
    for k = 1:n 
        coeffs(k) = y(k); % Присваиваем текущий коэффициенту значение функции в узле
        for j = n:-1:k+1 % Цикл для вычисления разделенных разностей
            % Вычисляем разделенные разности и обновляем значения функции
            y(j) = (y(j) - y(j-1)) / (x(j) - x(j-k));
        end
    end
end
% Функция для вычисления значения интерполяционного многочлена Ньютона в заданных точках
function val = newton_evaluate(coeffs, x, t)
    n = length(coeffs);
    val = coeffs(n);
    for k = n-1:-1:1 % Цикл по коэффициентам многочлена в обратном порядке
        % Умножаем текущее значение на (t - x(k)) и добавляем текущий коэффициент
        val = val .* (t - x(k)) + coeffs(k);
    end
end