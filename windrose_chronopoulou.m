clear;
data=xlsread('Wind data.xlsx');
data(:,5)=0.51*data(:,5); %knots to m/s
year_min=min(data(:,1));
year_max=max(data(:,1));
year_1=randi([year_min,year_max-9],1);
year_10=year_1+9;
%Επιλογή των δεδομένων της δεκαετίας
ten_year_data = data(data(:,1) >= year_1 & data(:,1) <= year_10, :);
%ΑΕΜ: 16012 οπότε υπολογίζονται οι εαρινοί μήνες
spring_data = ten_year_data(ten_year_data(:,2) == 3 | ten_year_data(:,2) == 4 | ten_year_data(:,2) == 5, :);
month = spring_data(:,2);
day = spring_data(:,3);
hour = spring_data(:,4);
wind_speed=spring_data(:,5);
wind_direction=spring_data(:,6);
%Δημιουργία 16 τομέων
Spaces=zeros(size(wind_direction)); %ορισμός κενού διανύσματος
for i=1:16 %ανάθεση αριθμού τομέα σε κάθε τιμή διεύθυνσης
    Spaces((i-1)*22.5<=wind_direction & wind_direction<i*22.5)=i;
end
most_frequent_wd=(mode(Spaces))*22.5; %πιο συχνή τιμή σε μοίρες
fprintf('Η πιο συχνή διεύθυνση ανέμου είναι ανάμεσα σε %.2f - %.2f μοίρες\n',(most_frequent_wd-22.5),most_frequent_wd);
mean_ws=mean(wind_speed); % μέση ταχύτητα ανέμου
fprintf('Η μέση ταχύτητα του ανέμου είναι: %.2f m/s\n',mean_ws);

disp(ispc);
name=getenv('COMPUTERNAME');
disp(name);

options = {'anglenorth',0,'angleeast',90,'labels',{'N (0)', 'E (90)', 'S (180)', 'W(270)'},'freqlabelangle',30};
WindRose(wind_direction,wind_speed,options);
hold on
title(sprintf('Ροδόγραμμα ανέμου για την δεκαετία: %d - %d\n Συχνότερη διεύθυνση ανέμου: %2.f - %.2f μοίρες\n Μέση ταχύητα ανέμου: %.2f m/s\n',year_1,year_10,(most_frequent_wd-22.5),most_frequent_wd,mean_ws))
annotation('textbox', [0.7, 0.05, 0.2, 0.05], 'String', ['Computer: ', name], 'FitBoxToText', 'on', 'EdgeColor', 'none', 'FontSize', 10);
annotation('textbox', [0.7, 0.0, 0.2, 0.05], 'String', 'Effrosyni Chronopoulou', 'FitBoxToText', 'on', 'EdgeColor', 'none', 'FontSize', 10);
