%% procedure to read data from nc file
file='agulhas.nc';

UT   = ncread(file,'u');
VT   = ncread(file,'v');
lat   = ncread(file,'latitude');
lon  = ncread(file,'longitude');
time   = ncread(file,'time');

lat=double(lat); lon=double(lon); time=double(time); 

UT(isnan(UT)) = 0;
VT(isnan(VT)) = 0;
