close all
clear all
clc
disp('welcom to Magnus-1 sys')
disp('-_-_-_-_-_-_for Forward Kienmatics enter fk-_-_-_-_-_-_')
disp('-_-_-_-_-_-_for Inverse Kienmatics enter ik-_-_-_-_-_-_')
char x;
x=input('Enter the type of the study:');
syms q1 q2 q3 q4 q5 q6 q7; 
q=[q1 q2 q3 q4 q5 q6 q7];
dh=[ %setting the dh table 
% the d     a   alpha
    0 0.085 0     pi/2; %j1
    0 0.15  0.51  pi; %j2
    0 0.085     0.51  -pi/2; %j3
    0 0     0.085 pi/2; %j4
    0 0.085 0.1   -pi/2; %j5
    0 0.125 0.155 -pi/2; %j6
    0 0     0     pi/2]; %j7

         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch x %switch case is for losers
 case 'fk'
        disp('______________forward Keinmetics study______________')
        thetalist=input('Enter theta list: '); 
        td=input('theta_dot_list');
        r=SerialLink(dh);
        r.name='Magnus'; %is n't acool name 
        T=r.fkine(thetalist) %desired T_matrix
        figure
        r.plot(thetalist)%the orientaion of the robot at hte desired joint values
        figure
        r.teach
        disp('_____________forward veloscity Keinamtics___________')
%         %jacobian hell
%         %velocity keinametics
         J=r.jacobe(thetalist)% the desierd jacobian 
         S=rank(J) %singularity chek%
         if S < 7
             disp('this position is singular!!!!!!!!!!!!!!!!!!!!!!!!!!!')
         end
         V=J*td.'
       %%%%%%genral solution%%%%%%  
         %i know this fucked up but here is the genral soltion for the
        %jacobian
         %rg = r.sym; %thank you peter corke
        %T_genral=rg.fkine([q1, q2, q3, q4, q5, q6 ]) %the Genral form   
         %J_genral=rg.jacobe([q1, q2, q3, q4, q5, q6])
         %s_g=rank(J_genral)
                  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'ik'
        r=SerialLink(dh); %intilazing the robot
        disp('-------inverse kienamtics---------')%this pathetic 
       T=input('enter the Transformation Matrix:'); %
        thetalist= r.ikine(T)
        J=r.jacobe(thetalist)
        J_inv=pinv(J)
        disp('_____________Inverse veloscity Keinamtics___________')
        V_d=input('the desierd velocity');
        td=J_inv*V_d.'
        r.plot(thetalist)
end
        



