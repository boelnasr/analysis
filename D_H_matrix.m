function T=D_H_matrix(a,alpha,d,theta)
c=cos(theta)
s=sin(theta)

T=[[c -(s*cos(alpha)) (s*sin(alpha)) a*c];
    [s (c*cos(alpha)) -(c*sin(alpha)) a*s ];
    [0 sin(alpha) cos(alpha) d];
    [0 0 0 1] ]
end
    
   