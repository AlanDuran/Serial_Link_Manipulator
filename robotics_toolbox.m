%Parametros del robot
q = [0 0 0 0 0 0 0];
d = [0.2703 0 0.3644 0 0.3743 0 0.2295]; %metros
a = [0.069 0 0.069 0 0.01 0 0]; %matros
alpha = [-pi/2 pi/2 -pi/2 pi/2 -pi/2 pi/2 0]; %radianes
m = [5.70044 3.22698 4.31272 2.07206 2.24665 1.60879]; %kg

for i=1:7
    % create links using D-H parameters
    L(i) = Link([q(i) d(i) a(i) alpha(i)]); 
end

% create the robot model
Robot = SerialLink(L);
Robot.name = 'Robot';
% starting position
qz = [0 0 0 0 pi/2 0 0];
vz = [1 0 .2 1 1 1 1 1];
% ready position
qr = [0 2 0 (1/4)*pi -pi 0 0];
% generate a time vector
t = [0:0.056:2];
% computes the joint coordinate trajectory
q2 = jtraj(qz, qr, t);
% direct kinematics for each joint co-ordinate
Tr = Robot.fkine(q2)
%Robot.plot(qz)
t = Robot.itorque(qz,vz);
