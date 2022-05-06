
    % Sorting CSV data of precepitation based on months for years 2000-2020 and 
% paste it into new dataset named PRR
PRCP= importfile('PRCP.csv');      
for i=1:12
   PRR(i,:)=PRCP.pr(i:12:end)';
end

% Three-sigma rule (68–95–99.7) to detect outliers and anomalies
for i=1:12
    roww=PRR(i,:);
    [TF,L,U,C]  = isoutlier(roww,'gesd')

    e=find(TF>0);   %detecting outliers
    

    if isempty(e)==1   %if there was no outliers, the test is done 

    else        
      for j=1:size(e,2)     %move on founded outlier values
     
          %Replace the outliers with the mean of two previous and
          % afterwards values
     roww(1,e(j))=mean(roww(1,[e(j)-2 e(j)-1 e(j)+1 e(j)+2]));
     end
        
    end

    clear e TF L U C 
    PRR_new(i,:)=roww;    %new modified dataset with no outlier values
 
end

Precipitation=PRCP;    %original values
Precipitation.pr=PRR_new(:);    %modified and usable values
    
    
%%%

%%Finding NDVI data Outliers

% Sorting CSV data of NDVI based on months for years 2000-2020 and 
% paste it into new dataset named NDD
NDVI= importfile1('NDVI.csv');

 for i=1:12
   NDD(i,:)=NDVI.NDVI(i:12:end)';   
end

% Three-sigma rule (68–95–99.7) to detect outliers and anomalies
for i=1:12
    roww=NDD(i,:);
     [TF,L,U,C]   = isoutlier(roww,'gesd')

    e=find(TF>0);   %detecting outliers
    
    
    if isempty(e)==1     %if there was no outliers, the test is done 
    else
      for j=1:size(e,2)   %move on founded outlier values

          %Replace the outliers with the mean of two previous and
          % afterwards values
     roww(1,e(j))=mean(roww(1,[e(j)-2 e(j)-1 e(j)+1 e(j)+2]));
     end
 
    end
    
    clear e TF L U C 
    NDD_new(i,:)=roww;    %new modified dataset with no outlier values
end

NDVI_NEW=NDVI;            %original values
NDVI_NEW.NDVI=NDD_new(:);       %modified and usable values


