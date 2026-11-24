% =========================================================================
% SEASCAPE MAP GENERATOR
% This script downloads monthly seascape data from NOAA CoastWatch THREDDS
% and plots a specific seascape map overlaid with sampling stations.
%
% REQUIRED VARIABLES & FILES:
% - custom.csv: A CSV file containing a 33x3 RGB colormap matrix for the 33 
%               possible seascape classes (loaded into the 'cmap2' variable).
% - ctd_meta_v4.csv: A table or struct containing coordinates for stations 
%                 (plotted as circles).
%
% DEPENDENCIES:
% - M_Map Toolbox: Must be installed and added to the MATLAB path (requires 
%                  m_proj, m_pcolor, m_gshhs_i, m_grid_v2, and m_plot).
%
% Written by: Enrique Montes (enrique.montes@noaa.gov)
% November 4, 2024.
% =========================================================================

%Loads metadata table
fileID = 'ctd_meta_v4.csv'; % % Only for CPICS sampling events
metadata_table = readtable(fileID); 
station_list = groupsummary(metadata_table, 'Station', {'mean'}, {'dec_lat', 'dec_lon'});

% % Define general domain
n_lat = '29'; s_lat = '24'; e_lon = '-79'; w_lon = '-86';
start_date = '2022-01';
end_date = '2024-12';

% % Getting the data from THREDDS
% % MONTHLY
urlfile=strcat('https://cwcgom.aoml.noaa.gov/thredds/ncss/SEASCAPE_MONTH/SEASCAPES.nc?var=CLASS&var=P&north=',n_lat,'&west=',w_lon,'&east=',e_lon,'&south=',s_lat,'&disableProjSubset=on&horizStride=1&time_start=',start_date,'-15T12%3A00%3A00Z&time_end=',end_date,'-15T12%3A00%3A00Z&timeStride=1&addLatLon=true&accept=netcdf');
options = weboptions('CertificateFilename', '', 'Timeout',180); % this command is necessary in how matlab looks for bigger data files
websave('dummy.nc',urlfile,options); % note in matlab this saves the url exactly as the file that it is, not a text or html

lat=double(ncread('dummy.nc','lat'));
lon=double(ncread('dummy.nc','lon'));
CLASS=double(ncread('dummy.nc','CLASS'));
[lat1,lon1]=meshgrid(lat,lon);

cmap2 = csvread('custom.csv'); % color palette for seascapes
example_seascape = CLASS(:,:,33); % September 2024 (matching Figure 1)

figure();
    m_proj('robinson','lon',[str2num(w_lon) str2num(e_lon)],'lat',[str2num(s_lat) str2num(n_lat)]); 
    m_pcolor(lon1,lat1, example_seascape);
    colormap(cmap2);
    shading flat;  
    m_gshhs_i('patch',[0 0 0],'edgecolor','none'); 
    m_grid('box','fancy','fontsize',30,'fontweight','bold'); 
    caxis([1 33]);
    colorbar('FontSize', 18, 'Ticks', 1:33, 'TickLabels', 1:33); 
hold on;
    m_plot(station_list.mean_dec_lon, station_list.mean_dec_lat, 'ko', ...
        'MarkerFaceColor', 'w', ...
        'MarkerSize', 18, ...  
        'LineWidth', 0.5);
