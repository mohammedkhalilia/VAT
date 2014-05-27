function [RV,I]=vat(R)
% Example function call: [DV,I] = VAT(D);
%
% *** Input Parameters ***
% @param R (n*n double): Dissimilarity data input
% 
% *** Output Values ***
% @value RV (n*n double): VAT-reordered dissimilarity data
% @value I (n int): Reordered indexes of R, the input data

[N,M]=size(R);

K=1:N;
J=K;
%P=zeros(1,N);

[y,i]=max(R);
[y,j]=max(y);
%P(1)=i(j);
I=i(j);
J(I)=[];
[y,j]=min(R(I,J));
%P(2)=J(j);
I=[I J(j)];
J(J==J(j))=[];

for r=3:N-1,
    %fprintf('r=%d/%d\n',r,N-1);
    [y,i]=min(R(I,J));
    [y,j]=min(y);
    %P(r)=J(j);
    I=[I J(j)];
    J(J==J(j))=[];
end;
%P(N)=J;
I=[I J];

RV=R(I,I);
