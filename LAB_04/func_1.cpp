#include <iostream>
#include <math.h>
#include <clocale>
#include <iomanip>
#define N 100

using namespace std;

// ������� x0.5^(x^2)
double f(double x) {
	return x * pow(0.5, x * x);
}
// ������������� �������
double F(double x) {
	return 0.5 * (pow(0.5, x * x) / -0.693147);
}

void main() {

	setlocale(LC_ALL, "ru");

	double a, b, dx, z0, z1, z2, z3;
	a = -4;
	b = -3;
	dx = (b - a) / N;

	z0 = F(b) - F(a);
	cout << setprecision(9) << fixed;
	cout << "������ �������� ���������: " << z0 << endl << endl;

	// ����� ��������
	z1 = 0;
	z1 += ( 0.5 * f(a));
	z1 += ( 0.5 * f(b));
	for (int i = 1; i <= N - 1; i++) {
		z1 = z1 + f(a + i * dx);
	}
	z1 = z1 * dx;
	cout << "����� ��������: " << z1;
	cout << endl << "-> " << "���������� �����������: " << fabs(z1 - z0);
	cout << endl << "-> " << "������������� �����������: " << fabs(z1 - z0) / fabs(z0) << endl << endl;

	// ����� ��������
	z2 = 0;
	for (int i = 1; i <= N / 2; i++) {
		z2 = z2 + 4 * f(a + (2 * i - 1) * dx);
	}
	for (int i = 1; i <= N / 2 - 1; i++) {
		z2 = z2 + 2 * f(a + 2 * i * dx);
	}
	z2 = (f(a) + f(b) + z2) * dx / 3;
	
	cout << "����� ��������: " << z2;
	cout << endl << "-> " << "���������� �����������: " << fabs(z2 - z0);
	cout << endl << "-> " << "������������� �����������: " << fabs(z2 - z0) / fabs(z0) << endl << endl;

	// ����� ���������������
	z3 = 0;
	for (int i = 1; i <= N; i++) {
		z3 += f(a + dx * (i - 0.5));
	}
	z3 = z3 * dx;

	cout << "����� ���������������: " << z3;
	cout << endl << "-> " << "���������� �����������: " << fabs(z3 - z0);
	cout << endl << "-> " << "������������� �����������: " << fabs(z3 - z0) / fabs(z0) << endl << endl;
}