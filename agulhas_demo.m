addpath('src');
addpath('data');
%% read data
readnc
t0 = time(1);
tf = t0+90;

Nt = 600;     % number of time steps
tspan = linspace(t0,tf,Nt);  % interval
options = odeset('RelTol',1e-4,'AbsTol',1e-4); % ODE options
memo1 = ['... Integration time is ',num2str(tf-t0),' days'];

%% initial conditions
n = 780;  m = 420;
x = linspace(-4,9,n);        dx = abs(x(2)-x(1));
y = linspace(-35,-28,m);     dy = abs(y(2)-y(1));
[xi,yi] = meshgrid(x,y);

%%
tic
[xp_t,yp_t]=Integrate(xi,yi,tspan,options,lon,lat,UT,VT,time);

[frey,enery] = LTF(xp_t,yp_t,m,n,Nt);
toc

%% extract eddies boundaries:
Nc = 10;                     % Ccontour levels
l = 3.15;                    % minimal arc-length
d = 10;                      % convexity deficiency
eddy = boundary_extract(frey,xi,yi,Nc,l,d);

figure
subplot(2,1,1)
set(gca,'ydir','normal')
axis equal tight; colorbar
imagesc(x,y,frey);
for jj=1:numel(eddy.xc); hold on; plot(eddy.xc{jj},eddy.yc{jj},'r','linewidth',3); end
plot(eddy.xp,eddy.yp,'or','MarkerFaceColor','r','MarkerSize',4);
axis equal tight;
set(gca,'ydir','normal')
subplot(2,1,2)
imagesc(x,y,enery);
axis equal tight;
set(gca,'ydir','normal')
