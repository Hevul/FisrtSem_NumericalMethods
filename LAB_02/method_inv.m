A = [0, 1, 1, 1;
    2, 2, 1, 1;
    2, 2, 2, 1;
    2, 2, 2, 3]

B = [2; 3; 3; 1]
prover=det(A);

if(prover ~=0)
    res = inv(A)*B;
end
disp("  Метод обратной матрицы")
disp(res);