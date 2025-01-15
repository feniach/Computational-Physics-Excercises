clear;
% Εισαγωγή ΑΕΜ
prompt = 'Εισάγετε το ΑΕΜ σας: ';
aem = input(prompt);

if mod(aem,2)==0
    fprintf('Χρήση δεδομένων από τον σταθμό 2\n');
    station = 'station_2';
else 
    fprintf('Χρήση δεδομένων από τον σταθμό 1\n');
    station = 'station_1';
end

data = xlsread("Weibull data.xlsx", station);
data(:,5) = 0.51 * data(:,5); %knots σε m/s

year_min = min(data(:,1));
year_max = max(data(:,1));
year_1 = randi([year_min, year_max-7], 1);
year_8 = year_1 + 7;

% Επιλογή δεδομένων 8ετίας
eight_year_data = data(data(:,1) >= year_1 & data(:,1) <= year_8, :);
wind_speed = eight_year_data(:,5);

% Υπολογισμός κατανομής ταχυτήτων
wind_speed(wind_speed == 0) = []; % Αγνοούμε μηδενικές τιμές
[unique_speeds, ~, idx] = unique(wind_speed); %εύρεση κάθε τιμής ταχύτητας
n_each_speed = histc(idx, 1:length(unique_speeds)); %καταμέτρηση ποσού εμφάνισης κάθε τιμής

%πιθανότητας εμφάνισης ταχυτήτων
prob = n_each_speed / sum(n_each_speed);
cumulative_prob = cumsum(prob);

% αφαίρεση μηδενικών ταχυτήτων
valid_idx = unique_speeds > 0;
unique_speeds = unique_speeds(valid_idx);
cumulative_prob = cumulative_prob(valid_idx);

log_speed = log(unique_speeds); %ln(V0)
log_cumulative_prob = log(-log(1 - cumulative_prob)); %ln(-l(1-F(V<V0)))

%NaN ή Inf
valid_idx = ~isinf(log_cumulative_prob) & ~isnan(log_cumulative_prob);
log_speed = log_speed(valid_idx);
log_cumulative_prob = log_cumulative_prob(valid_idx);

% Αν δεν υπάρχουν αρκετά δεδομένα
if length(log_speed) < 2
    error('Δεν υπάρχουν αρκετά έγκυρα δεδομένα για την προσαρμογή Weibull.');
end

params = polyfit(log_speed, log_cumulative_prob, 1);
k = params(1);
C = exp(-params(2) / k);
fprintf('Υπολογισμένες τιμές: k = %.4f, C = %.4f\n', k, C);

% Υπολογισμός θεωρητικής κατανομής Weibull
weibull_theoretical = (k / C) * (unique_speeds / C).^(k - 1) .* exp(-(unique_speeds / C).^k);

disp(ispc); %ελεγχος οτι τρεχει στα windows
name=getenv('COMPUTERNAME');
disp(name);

% Γραφική παράσταση
figure;
h = histogram(wind_speed, 'Normalization', 'probability', 'FaceColor', 'r');
hold on;
plot(unique_speeds, weibull_theoretical, 'b', 'LineWidth', 2);
xlim([min(wind_speed), max(wind_speed)]);
title(sprintf('Δεδομένα από %d έως %d για πλήθος μετρήσεων: %d', year_1, year_8, length(wind_speed)));
xlabel('Ταχύτητα ανέμου [m/s]');
ylabel('Πιθανότητα');
legend('Ανεμολογικά δεδομένα από σταθμούς', 'Κατανομή Weibull');
annotation('textbox', [0.7, 0.05, 0.2, 0.05], 'String', ['Computer: ', name], 'FitBoxToText', 'on', 'EdgeColor', 'none', 'FontSize', 10);
annotation('textbox', [0.7, 0.0, 0.2, 0.05], 'String', 'Effrosyni Chronopoulou', 'FitBoxToText', 'on', 'EdgeColor', 'none', 'FontSize', 10);
hold off;
