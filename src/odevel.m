%% ODE solver for the geostrophic velocity field
function dy = odevel(t,y,u,v)

Np = numel(y)/2;           
dy = zeros(2*Np,1);

dy(1:Np,1) = u( y(1:Np,1),y(Np+1:2*Np,1),t*ones(Np,1) );
dy(Np+1:2*Np,1) = v( y(1:Np,1),y(Np+1:2*Np,1),t*ones(Np,1) );
              
end
