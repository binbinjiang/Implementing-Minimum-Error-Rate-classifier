x1 = -7:0.2:7; x2 = -7:0.2:7;
[X1,X2] = meshgrid(x1,x2);

mu1 = [5 5];
Sigma1 = [.1 .8;.8 9];
F1 = mvnpdf([X1(:) X2(:)],mu1,Sigma1); %multi variate normal probability density function
                                       %returns the density of the multivariate normal distribution 
                                       %with mean mu1 and covariance Sigma1,
                                       %evaluated at each row of X1 X2
                                       
F1 = reshape(F1,length(x2),length(x1));%reshapes F1 into a length(x2) by length(x1) array 
                                       % where length(x2) and length(x1) indicates the size of each dimension.
%surfc(x1,x2,F1);
meshc(X1,X2,F1);                       %draws a wireframe mesh and a contour plot under it 
                                       %with color determined by F1
                                       %A contour plot displays isolines of
                                       %matrix F1

axis([-7 7 -7 7 -1.0 0.6]);             %sets the axis limit

xlabel('x1'); ylabel('x2'); zlabel('Probability Density');

hold on;

mu2 = [-1 -2];
Sigma2 = [.8 0;0 .8];
F2 = mvnpdf([X1(:) X2(:)],mu2,Sigma2);
F2 = reshape(F2,length(x2),length(x1));
%surfc(x1,x2,F2);
meshc(X1,X2,F2);  

axis([-7 7 -7 7 -1.0 0.6]);
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');
hold on;

%assigning color to the axis
caxis([min(F2(:))-.5*range(F2(:)),max(F2(:))]);

% Write Your CODE here
samples=[1 1;1 -1;4 5;-2 2.5;0 2;2 -3];

for n=1:6
    for m=1:2
        if(m==1)
           g1=-log(2*pi)-0.5*log(det(Sigma1))-0.5*(samples(n,:)'-mu1')'*inv(Sigma1)*(samples(n,:)'-mu1')+log(0.5);
        elseif(m==2)
           g2=-log(2*pi)-0.5*log(det(Sigma2))-0.5*(samples(n,:)'-mu2')'*inv(Sigma2)*(samples(n,:)'-mu2')+log(0.5); 
        end
    end
    
    if(g1>g2)
        plot3(samples(n,1),samples(n,2),-1.0,'rx');
        text(samples(n,1),samples(n,2),-1.0,'R1');
    else
        plot3(samples(n,1),samples(n,2),-1.0,'b*');
        text(samples(n,1),samples(n,2),-1.0,'R2');
    end
    
end  

syms x y;
eq1 =-log(2*pi)-0.5*log(det(Sigma1))-0.5*([x;y]-mu1')'*inv(Sigma1)*([x;y]-mu1')+log(0.5);
eq2 =-log(2*pi)-0.5*log(det(Sigma2))-0.5*([x;y]-mu2')'*inv(Sigma2)*([x;y]-mu2')+log(0.5);
eq = eq1 - eq2;   %generating the equation
con=ezplot(eq, [[-7,7],[-7,7]]);
set(con,'Color','red');
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');
    
hold off;












