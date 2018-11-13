function error_plot_final1(tspan,x0,Pd)

global A B C D Jv Ke

%Parametros del sistema
d = [0.2703 0 0.3644 0 0.3743 0 0.2295]; %metros
a = [0.069 0 0.069 0 0.01 0 0]; %matros
alpha = [-pi/2 pi/2 -pi/2 pi/2 -pi/2 pi/2 0]; %radianes

T = D_H(x0(1:7),a,alpha,d,0,7);
J = jacobiano(T);
Jv = J(4:6,:);
%MATRICES DEL SISTEMA
A = [0 0 0 0 0 0 0;Jv(1:3,:)];
B = [ones(1,7);Jv];
C = [0];
D = 0;

%CALCULAMOS GANANCIAS DE CONTROL
Ke = Pd;

%RESOLVER ECUACIONES DIFERENCIALES ORDINARIAS
[t,X] = ode45(@SegRef_sys,tspan,x0);

%Graficar estados
figure;
subplot(3,1,1); plot(t,X(:,8));title('ESTADO 1'); grid;
subplot(3,1,2); plot(t,X(:,9));title('ESTADO 2'); grid;
subplot(3,1,3); plot(t,X(:,10));title('ESTADO 3'); grid;

ref = [1;1;1]; dref = [0;0;0];
e = ref - X(8:10)';
U = pinv(Jv)*(dYref - Ke*e);

%figure; plot(t,X*C','r',t,ref);title('SALIDA');grid;
figure; plot(t,U(:,1)); title('SEÑAL DE CONTROL'); grid;
end

function dX = SegRef_sys(t,X)

global A B C D Jv Ke

yref = [1;1;1];
dYref = [0;0;0];

%T = D_H(X(1:7)',a,alpha,d,0,7);
%J = jacobiano(T);
%Jv = J(4:6,:);

e = yref - X(8:10);
U = pinv(Jv)*(dYref - Ke*e);
%ODE's
dX = [U;Jv*U];
end
