function methods
result = input('For Bisection method press 1, for fixedpoint press 2 , for Newton method press 3 , for False postion press 4 . \n');
switch result
case 1 
     Bisection;
case 2 
     fixedpoint;
case 3    
     Newton;
case 4 
     False;
otherwise disp('You pressed an unspecified key , please run again')
end
end
function [equation , PN_4th , tolerance , vec_4th] = Bisection(equation,a,b,tolerance) % with parameters--> Bisection_N(equation,a,b,tolerance)
    syms x
    equation =input('Enter the equation f(x): ');
    a =input('Enter the interval[a,b] a= ');
    b =input('b= ');
    tolerance =input('Enter the tolerance : ');
    f = inline(equation);
    Iter=1;
   
    
    PN=(a+b)/2;
    disp('________________________________________________________________________________');    
    row = ['     ',' Iter ' , '    an ' ,'       bn ','      Pn ' , '       f(a) ' ,'      f(Pn)  ','  |PN - PN_1/PN|'];
    disp(row);
    disp('________________________________________________________________________________');    
    row = [Iter,a,b,PN,f(a),f(PN)];
    disp(row); 
    disp('--------------------------------------------------------------------------------');   
        if f(a)*f(PN) <= 0
            b=PN;
        else
            a=PN;
        end        
    vec_roots(Iter)= PN ;    
    PN_1=PN;
    PN=(a+b)/2; 
%-------- starting loop ----------    
    while abs((PN - PN_1)/PN) >= tolerance
        Iter=Iter+1;       
        
        vec_roots(Iter)= PN ;
        row = [Iter,a,b,PN,f(a),f(PN),abs((PN - PN_1)/PN)];
        disp(row); 
        disp('--------------------------------------------------------------------------------');    
        if f(a)*f(PN) < 0
            b=PN;
        else
            a=PN;
        end
      PN_1=PN;
      PN=(a+b)/2;
    end
    vec_roots(Iter)= PN ;
    x_axis = (1:Iter);
    plot(x_axis,vec_roots,'--o');
end
%----------------------------------------------------------------------------------------------------------

function [equation , p0 , tolerance , pn] = fixedpoint(equation,p0,pn,tolerance) 
 syms x
equation =input('Enter the equation f(x): ');
    f(x) = equation ; 
   g(x)= x-f(x)/diff(f(x));

    p0 =input('Enter the P0 = ');
    tolerance =input('Enter the tolerance : ');


iter=1;
u=feval(g, p0);
pn=u;
    vec_roots(iter)= u ;    

 % It just set up a big number
disp('-------------------------------------------')
disp('iter      pn-1           pn        |pn-pn-1| ')
disp('-------------------------------------------')
fprintf('%2.0f  %12.6f  %12.6f\n', iter, p0,u)
while abs((u - p0))>=tolerance
      vec_roots(iter)= u ;
    pn=u;
    err=abs(pn-p0);
    p0=pn;
    u=feval(g, p0);

    iter=iter+1;

fprintf('%2.0f  %12.6f  %12.6f %12.8f\n', iter,p0,u,err)
end
 vec_roots(iter)= u ;
    x_axis = (1:iter);
    plot(x_axis,vec_roots,'--o');
end

%----------------------------------------------------------------------------------------------------------



function root = Newton(equation, x0 , tolerance , B_vec)

syms x
  equation =input('Enter the equation f(x): ');
    x0=input('Enter the x0 = ');
    tolerance =input('Enter the tolerance : ');
    f1 = inline(equation);
   f2 = inline(diff(f1(x)));  
    PN = x0 - (f1(x0)/f2(x0));
    Iter=1;
    root_vec = x0;    
    disp('______________________________________________________________________');    
    row = ['     ',' Iter ' , '   PN_1 ' ,'    f1(PN_1) ','  f2(PN_1) ' , '   PN ' ,'  |PN - PN_1/PN|'];
    disp(row);
    disp('______________________________________________________________________');    
    while abs((PN - x0)/PN) >= tolerance
        if (f2(x0) == 0)
            fprintf('zero derivative \n' );
            break;
        end
        row = [Iter , x0 ,f1(x0),f2(x0) , PN ,abs(PN - x0)]; 
        disp(row);  
        disp('----------------------------------------------------------------------');
        root_vec(Iter)= PN ;
        Iter=Iter+1;        
        x0=PN;
        PN= x0 - (f1(x0)/f2(x0));
    end
    root=PN;
    y_axis = (1:length(root_vec));
    plot(y_axis,root_vec,'--o');
end



%----------------------------------------------------------------------------------------------------------


function root = False (f, xl , xu , e)
clc;
clear all;
syms x
f = inline(input('Enter the equation : ','s'))
i=1;
while(i)
    xl = input('Enter lower value : ');
    xu = input('Enter upuer value : ');
    e = input('Enter accurancy : ');
    if f(xl) * f(xu) <0
        i=0;
    else
        display('root not located between the entered values ')
    end
    
end

if f(xl) <0
    xn=xl;
    xp =xu;
else
    xn=xu;
    xp=xl;
end
xm=xl;
t=1;
while(abs(f(xm))>e)
    xm=(xn*f(xp)-xp*f(xn)) / (f(xp) - f(xn));
    x=[xm];
    disp(x);
    t=t+1;
      root_vec(t)= xm ;
    if f(xm)<0
        xn=xm;
    else
        xp=xm;
    end
end
Root = xm;
fprintf('%2.0f  %12.6f  %12.6f\n', Root);
 Root=xm;
    y_axis = (1:length(root_vec));
    plot(y_axis,root_vec,'--o');

end
    






    


