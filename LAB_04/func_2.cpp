#include <iostream>
#include <math.h>
#include <clocale>
#include <iomanip>
#define N 100

using namespace std;

// Функция sin(7x + 1) / (7x + 1)
double f(double x) {
	return sin(7 * x + 1) / (7 * x + 1);
}

void main() {

	setlocale(LC_ALL, "ru");

	double a, b, dx, z1, z2, z3, z0;
	a = -4;
	b = -3;
	dx = (b - a) / N;

	z0 = 0.004577711846462;
	cout << setprecision(15) << fixed;
	cout << "Точное значение интеграла: " << z0 << endl << endl;
	// Метод трапеции
	z1 = 0;
	z1 += (0.5 * f(a));
	z1 += (0.5 * f(b));
	for (int i = 1; i <= N - 1; i++) {
		z1 = z1 + f(a + i * dx);
	}
	z1 = z1 * dx;
	cout << "Метод трапеции: " << z1 << endl;
	cout << "-> " << "Абсолютная погрешность: " << fabs(z1 - z0);
	cout << endl << "-> " << "Относительная погрешность: " << fabs(z1 - z0) / fabs(z0) << endl << endl;

	// Метод Симпсона
	z2 = 0;
	for (int i = 1; i <= N / 2; i++) {
		z2 = z2 + 4 * f(a + (2 * i - 1) * dx);
	}
	for (int i = 1; i <= N / 2 - 1; i++) {
		z2 = z2 + 2 * f(a + 2 * i * dx);
	}
	z2 = (f(a) + f(b) + z2) * dx / 3;

	cout << "Метод Симпсона: " << z2 << endl;
	cout << "-> " << "Абсолютная погрешность: " << fabs(z2 - z0);
	cout << endl << "-> " << "Относительная погрешность: " << fabs(z2 - z0) / fabs(z0) << endl << endl;

	// Метод прямоугольников
	z3 = 0;
	for (int i = 1; i <= N; i++) {
		z3 += f(a + dx * (i - 0.5));
	}
	z3 = z3 * dx;
	cout << "Метод прямоугольников: " << z3 << endl;
	cout << "-> " << "Абсолютная погрешность: " << fabs(z3 - z0);
	cout << endl << "-> " << "Относительная погрешность: " << fabs(z3 - z0) / fabs(z0) << endl << endl;
}