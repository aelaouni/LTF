%%Function to compute the convexity deficiency 
function flag = convexity(xt,yt,d)

[~,H] = convhull(xt,yt);
A = polyarea(xt,yt);
Ad = abs(H-A)./A*100;

if Ad <= d
    flag = true;
else
    flag = false;
end



