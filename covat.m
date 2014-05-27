function [Druc,Dr,Dc,Dp,Dco,Pruc,Pr,Pc]=covat(D,renorm)

if(nargin<2)
    renorm=0;
end;

[Nrow,Ncol]=size(D);
meanD=mean(D(:));

if renorm,
    D=(D-meanD)/std(D(:));
end;

for r=1:Nrow,
    for c=r:Nrow,
        Dr(r,c)=norm(D(r,:)-D(c,:));
        Dr(c,r)=Dr(r,c);
    end;
end;

meanDr=(sum(sum(Dr)))/(Nrow^2-Nrow);

if renorm,
    Dr=(Dr-meanDr)/std(Dr(:));
else
    Dr=Dr/meanDr*meanD;
end;

for r=1:Ncol,
    for c=r:Ncol,
        Dc(r,c)=norm(D(:,r)-D(:,c));
        Dc(c,r)=Dc(r,c);
    end;
end;

meanDc=(sum(sum(Dc)))/(Ncol^2-Ncol);

if renorm,
    Dc=(Dc-meanDc)/std(Dc(:));
else
    Dc=Dc/meanDc*meanD;
end;

Druc=[Dr D
    D' Dc];

[Dr,Pr]=vat(Dr);
[Dc,Pc]=vat(Dc);
[Druc,Pruc]=vat(Druc);

Dp=D(Pr,Pc);

Prco=Pruc(Pruc<=Nrow);
Pcco=Pruc(Pruc>Nrow)-Nrow;

Dco=D(Prco,Pcco);

