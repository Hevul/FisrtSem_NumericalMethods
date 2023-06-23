A = [0, 1, 1, 1;
    0, 2, 1, 1;
    1, 2, 2, 1;
    0, 2, 2, 3]

B = [2; 3; 3; 1]

a=cat(2,A,B)

n=size(A,1);
for i=1:n
    if(a(i,i) == 0)
        a = exch(a,i);
    end
    chgl = a(i,i);              % число на главной диагонали
    for j = i:(n + 1)           % деление строки на число которое находиться на главное диагонали
        a(i,j) = a(i,j) / chgl;
    end
    
    for k = i + 1:n             % отнимаем i строку от k 
        chislo = a(k, i);       % число на которое нужно умножить i строку
        for j = i:(n + 1)
            a(k,j) = a(k,j) - chislo*a(i,j);
        end
    end
end    
a
for i = 0:n-1%обратный ход
    for k = i + 1: 3
        col = n - k;
        a(col,n + 1) = a(col,n + 1) - a(col,n - i)*a(n-i,n + 1);
        a(col,n - i) = 0;
    end
end
a

resh = zeros(n,1); 
for i=1:n
    resh(i,1)=a(i,n+1);
end
resh

function output = exch(c, i)
    k = i + 1;
    while c(k,i)==0
        k=k+1;
    end
    for j=1:5
        ch = c(i,j);
        c(i,j) = c(k,j);
        c(k,j) = ch;
    end
    output = c;
end