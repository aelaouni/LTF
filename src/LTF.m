function [frey,enery] = LTF(xp_t,yp_t,m,n,Nt)

x3 = reshape(xp_t,Nt,m,n);
y3 = reshape(yp_t,Nt,m,n);


enerx=zeros(m,n);
frex=zeros(m,n);
enery=zeros(m,n);
frey=zeros(m,n);

w = hamming(Nt);

for i=1:1:m
parfor j=1:1:n
xxx=x3(:,i,j);
xxx=xxx-mean(xxx);
yyy=y3(:,i,j);
yyy=yyy-mean(yyy);
fx=abs(fft(w.*xxx));
fx=fx(1:Nt/2);
fy=abs(fft(w.*yyy));
fy=fy(1:Nt/2);
[ax,bx]=max(fx);
[ay,by]=max(fy);

if(isempty(ax)||isempty(ay))

enerx(i,j)=0;
frex(i,j)=0;
enery(i,j)=0;
frey(i,j)=0;

elseif(ax(1)<Nt/3&& ay(1)<Nt/3 && bx(1)>1&&bx(1)<Nt/30 && by(1)>1&&by(1)<Nt/30) 

enerx(i,j)=ax(1);
frex(i,j)=bx(1);
enery(i,j)=ay(1);
frey(i,j)=by(1);
 else
enerx(i,j)=0;
frex(i,j)=0;
enery(i,j)=0;
frey(i,j)=0;

end
end
%i
end
end
