x=-1:0.0001:3;
y= x.* x .* x + 2 .* x .* x + x -1;
plot(x, y);

% Метод дихотомии
f = inline('x.* x .* x + 2 .* x .* x + x -1');
eps = 0.01;
a = 0;
b = 3;
i = 0;
while abs(a - b) > eps
   c = (a + b) / 2; 
   if ((f(c) * f(a)) < 0) 
       b = c; 
   else
       a = c;
   end
   i = i + 1;
end
fprintf('Корень уравнения, посчитанный методом дихотомии = %f, \n', c);


% Метод простых итераций
x0 = 0.5; % начальное приближение 
N = 1000; 
 g= inline('-(x.* x .* x + 2 .* x .* x -1)')
x1 = g(x0);
for i = 1 : N 
    if (abs(x1 - x0) < eps)
        break
    end
    x0 = x1;
    x1 = g(x0);
end
fprintf('Корень уравнения, посчитанный методом простых итераций = %f, \n', x1);

% x.* x .* x + 2 .* x .* x + x -1
i
% Метод Ньютона
df = inline('3.*x.^2 + 4.*x + 1');
x = x0;
x0 = 0.5;
while abs(x - x0) > eps
 x0 = x;  
 x=x0-f(x0)./df(x0);
end

fprintf('Корень уравнения, посчитанный методом Ньютона = %f, \n', x);

