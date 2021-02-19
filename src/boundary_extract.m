function eddy = boundary_extract(VMatrix,xi,yi,Nc,l,d)
x = xi(1,:);
y = yi(:,1);  

h1 = contourc(x,y,VMatrix,Nc);
s = getctr(h1);
disp(sprintf('... %3d boundaries are extracted.',numel(s)));
eddy = struct('xc',[],'yc',[],'cval',[],'xp',[],'yp',[],'valp',[]);
for k=1:numel(s)
    if ( s(k).x(1)==s(k).x(end) ) && ( s(k).y(1)==s(k).y(end) ) 
        Length = sum( sqrt(diff(s(k).x,1).^2+diff(s(k).y,1).^2) );
        if Length>l
            if convexity(s(k).x,s(k).y,d) 
                eddy.xc{end+1} = s(k).x';
                eddy.yc{end+1} = s(k).y'; 
                eddy.cval(end+1,1) = s(k).v';
            end
        end
    end
end
Nc_filt1 = numel(eddy.xc);
disp(sprintf('... %3d boundaries are closed and convex.',Nc_filt1));

Nc_filt2 = numel(eddy.xc);
if Nc_filt2~=0
    xq = cellfun(@(x) x(1),eddy.xc,'UniformoutPut',true);  
    yq = cellfun(@(x) x(1),eddy.yc,'UniformoutPut',true);  
end
%%
indEliminate_2 = false(Nc_filt2,1);
for ii=1:Nc_filt2
    in = inpolygon(xq,yq,eddy.xc{ii},eddy.yc{ii});  in(ii)=0;
    indEliminate_2(in) = 1;
end
eddy.xc(indEliminate_2)   = [];
eddy.yc(indEliminate_2)   = [];
eddy.cval(indEliminate_2) = [];


end
