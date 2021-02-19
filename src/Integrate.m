%% Function to compute the flow map
function [xp_t,yp_t] = Integrate(xi,yi,tspan,options,lon,lat,UT,VT,time)
%%  geostrophic velocities:
   u_intrp = griddedInterpolant({lon,lat,time},UT,'linear','none');
   v_intrp = griddedInterpolant({lon,lat,time},VT,'linear','none');
   
   u = @(x,y,t) u_intrp(x,y,t);
   v = @(x,y,t) v_intrp(x,y,t);
        
%% Lagrangian trajectories:
[~,traj] = ode45(@odevel,tspan,[xi(:);yi(:)],options,u,v);
xp_t = traj(:,1:end/2);
yp_t = traj(:,end/2+1:end);

end


