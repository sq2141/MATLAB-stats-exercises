clear all;
clc;

%ask user to select stock .csv files
[file,folder] = uigetfile('*','Select .csv files','Multiselect','on');

%if only one file is selected (if 'file' is a string), convert to cell to
%be consistent with selecting multiple files
if isstr(file)==1;
    file={file};
end

numFiles=size(file,2);

%loop each stock file
for n=1:numFiles;
    curFile=fullfile(folder,file{n});
    [pathstr,filename,ext]=fileparts(fullfile(folder,file{n}));
    
    %get stock symbol
    sym = strtok(filename);
    
    %store stock symbol in a row vector 
    symList{n} = sym;
    
    %read csv data file
    sheet = xlsread(curFile);
    
    %calculate per cent daily change
    dailyChange(:,n) = ((sheet(:,4)-sheet(:,1))./sheet(:,1))*100;
end

save('dailyChange.mat','dailyChange');
save('symList.mat', 'symList');