clear
tmax=100000;
N=[1050,10500,150500];
Na_simulated=zeros(tmax,length(N)); %ορισμός κενών διανυσμάτων για να τοποθετηθούν οι τιμές
Nb_simulated=zeros(tmax,length(N));
Na_theoretical=zeros(tmax,length(N));
Nb_theoretical=zeros(tmax,length(N));
cpu_times=[]; %χρόνος cpu

%Υπολογισμός θεωρητικής εξέλιξης
for i =1:3 
    for t = 1:tmax
Na_theoretical(t,i) = N(i)*(1+exp(-2*t/N(i)))/2;
Nb_theoretical(t,i) = N(i) - Na_theoretical(t,i);
    end
end
% Προσομοίωση εξέλιξης
for i=1:3
tic; %Έναρξη μέτρησης

    N_a = N(i); %Αρχικά σωματίδια στο α
    N_b = 0;
    for t=1:tmax
    P = N_a/N(i); %πιθανότητα να περάσει σωατίδιο από το α στο β ανάλογη του αριθμού σωματιδίων
    r = rand; %τυχαίος αριθμός στο διάστημα 0 εως 1
    if r<P && N_a>0 %τυχαίος αριθμός απο το 0 στο 1, κίνηση από το α στο β
        N_a=N_a-1; %μείωση σωματιδίων στο α
        N_b=N_b+1; %Αυξηση σωματιδίων στο β 
    elseif r >= P && N_b > 0
        N_a=N_a +1; %Αυξηση σωματιδίων στο α
        N_b=N_b-1; %μειωση σωματιδίων στο β 
    end 
Na_simulated(t,i)=N_a;
Nb_simulated(t,i)=N_b;
    end
cpu_times(i)=toc; %Τέλος μέτρησης
end
for i=1:3
fprintf('Για αρχικό αριθμό σωματιδίων N_a = %.1f \n', N(i))
fprintf('Ο τελικός αριθμός σωματιδίων είναι Na = %.1f και Nb = %.1f \n', Na_simulated(tmax,i),Nb_simulated(tmax,i))
fprintf('Χρόνος CPU: %.4f δευτερόλεπτα\n\n', cpu_times(i));
end
%Διαγράμματα
for i = 1:3
figure(2*i-1) %Συνολικά διαγράμματα
plot(1:tmax,Na_simulated(:,i),'b-','LineWidth',1.5)
hold on;
plot(1:tmax,Na_theoretical(:,i),'green--')
hold on;
plot(1:tmax,Nb_simulated(:,i),'r-','LineWidth',1.5)
hold on;
plot(1:tmax,Nb_theoretical(:,i),'yellow--')
grid on;
title(sprintf('Διάγραμμα αριθμού σωματιδίων με τον χρόνο\nΝ = %d συνολικά σωματίδια.', N(i)));
xlabel('t (sec)')
ylabel('Αριθμός σωματιδίων')
legend('Προσομοιωμένη εξέλιξη στο (α)','Θεωρητική εξέλιξη στο (α)', 'Προσομοιωμένη εξέλιξη στο (β)', 'Θεωριτική εξέλιξη στο (β)')
hold off;

    figure(2*i) %Χωρισμένα διαγράμματα
    subplot(1,2,1)
    plot(1:tmax,Na_simulated(:,i),'b-','LineWidth',1.5)
    hold on;
    plot(1:tmax,Nb_simulated(:,i),'r-','LineWidth',1.5)
    grid on
    title(sprintf('Προσομοιωμένα σωματίδια\n Ν = %d συνολικά σωματίδια.', N(i)));
    xlabel('t (sec)')
    ylabel('Αριθμός σωματιδίων')
    legend('Προσομοιωμένη εξέλιξη στο (α)','Προσομοιωμένη εξέλιξη στο (β)')
    hold off;
    subplot(1,2,2)
   plot(1:tmax,Na_theoretical(:,i),'green--')
   hold on;
   plot(1:tmax,Nb_theoretical(:,i),'yellow--')
    grid on
    title(sprintf('Θεωρητικά σωματίδια\n Ν = %d συνολικά σωματίδια.', N(i)));
    xlabel('t (sec)')
    ylabel('Αριθμός σωματιδίων')
    legend('Θεωρητική εξέλιξη εξέλιξη στο (α)','Θεωρητική εξέλιξη στο (β)')
    hold off;

end

%Ερώτημα 2
disp('Ερώτημα Β');
prompt='Πληκτρολογήστε το όνομα σας:';
name = input(prompt, 's');
answer_1=char(name);
numbers_1=double(answer_1);
ON=sum(numbers_1);
prompt='Πληκτρολογήστε το επίθετο σας:';
surname = input(prompt, 's');
answer_2=char(surname);
numbers_2=double(answer_2);
EP=sum(numbers_2);

if ON<EP
    b=ON/EP;
    disp('N1>N2')
elseif ON>EP
    b=EP/ON;
    disp('N2>N1')
end 

Na_simulated_b=zeros(tmax,length(N)); %ορισμός κενών διανυσμάτων για να τοποθετηθούν οι τιμές
Nb_simulated_N=zeros(tmax,length(N));
Na_theoretical_b=zeros(tmax,length(N));
Nb_theoretical_b=zeros(tmax,length(N));
cpu_times_b=[]; %χρόνος cpu
Na_b=[length(N)]; %ορισμός αρχικών σωματιδίων στα α και β
Nb_b=[length(N)];
Na_th_b=[length(N)];
Nb_th_b=[length(N)];
%Υπολογισμός θεωρητικής εξέλιξης
for i = 1:3
   Nb_th_b(i) = N(i) / (1 + b); % Αρχικό N2
   Na_th_b(i) = N(i) - Nb_th_b(i); % Αρχικό N1
    for t = 1:tmax
        Na_theoretical_b(t, i) = Na_th_b(i) + (Nb_th_b(i) - Na_th_b(i)) * (1 - exp(-2 * t / N(i))) / 2;
        Nb_theoretical_b(t, i) = N(i) - Na_theoretical_b(t, i);
    end
end
for i=1:3
   tic; %Έναρξη μέτρησης
   Nb_b=N(i)/(1+b);
   Na_b=N(i)-Nb_b;
   for t=1:tmax
   r_b = rand();
   P_b=Na_b/N(i);
if r_b<P_b && Na_b>0 %μετακίνηση από το α στο β
   Na_b=Na_b-1;
   Nb_b=Nb_b+1;
elseif r_b>=P_b && Nb_b>0 %Μετακίνηση από το β στο α
   Na_b=Na_b+1;
   Nb_b=Nb_b-1;
end
Na_simulated_b(t,i)=Na_b;
Nb_simulated_b(t,i)=Nb_b;
    end
cpu_times_b(i)=toc; %Τέλος μέτρησης
end 
for i=1:3
fprintf('Για αρχικό αριθμό σωματιδίων N1 = %.1f και N2 = %.1f \n', Na_simulated_b(1,i),Nb_simulated_b(1,i))
fprintf('Ο τελικός αριθμός σωματιδίων είναι Na = %.1f και Nb = %.1f \n', Na_simulated_b(tmax,i),Nb_simulated_b(tmax,i))
fprintf('Χρόνος CPU: %.4f δευτερόλεπτα\n\n', cpu_times_b(i));
end

%Διαγράμματα
for i = 1:3
figure(6+(2*i-1)) %Διαγράμματα μόνο για την περίπτωση β
plot(1:tmax,Na_simulated_b(:,i),'b-')
hold on;
plot(1:tmax,Na_theoretical_b(:,i),'green--')
hold on;
plot(1:tmax,Nb_simulated_b(:,i),'r-')
hold on;
plot(1:tmax,Nb_theoretical_b(:,i),'yellow--')
grid on;
title(sprintf('Διάγραμμα αριθμού σωματιδίων με τον χρόνο\n Περίπτωση (β)\n Ν = %d συνολικά σωματίδια.', N(i)));
xlabel('t (sec)')
ylabel('Αριθμός σωματιδίων')
legend('Προσομοιωμένη εξέλιξη στο (α)','Θεωρητική εξέλιξη στο (α)', 'Προσομοιωμένη εξέλιξη στο (β)', 'Θεωριτική εξέλιξη στο (β)')
hold off;
end
for i = 1:3
    figure(6+(2*i)); % Δημιουργία νέου διαγράμματος
    % Πρώτη υποκαμπύλη για (α)
    subplot(1, 2, 1);
    plot(1:tmax, Na_simulated(:, i), 'b-'); 
    hold on;
    plot(1:tmax, Na_theoretical(:, i), 'g--'); 
    hold on;
    plot(1:tmax, Nb_simulated(:, i), 'r-'); 
    hold on;
    plot(1:tmax, Nb_theoretical(:, i), 'y--'); 
    grid on;
    title(sprintf('Σωμάτια στην περίπτωση α) \n N = %d', N(i)));
    xlabel('Χρόνος t (sec)');
    ylabel('Αριθμός σωματιδίων');
    legend('Προσομοίωση α μέρος κουτιού', 'Θεωρία α μέρος κουτιού','Προσομοίωση β μέρος κουτιού', 'Θεωρία β μέρος κουτιού');
    hold off;

    % Δεύτερη υποκαμπύλη για (β)
    subplot(1, 2, 2);
    plot(1:tmax, Na_simulated_b(:, i), 'c-'); 
    hold on;
    plot(1:tmax, Na_theoretical_b(:, i), 'm--');
    hold on;
    plot(1:tmax, Nb_simulated_b(:, i), 'k-'); 
    hold on;
    plot(1:tmax, Nb_theoretical_b(:, i), 'r--');
    grid on;
    title(sprintf('Σωμάτια στην περίπτωση β \n N = %d', N(i)));
    xlabel('Χρόνος t (sec)');
    ylabel('Αριθμός σωματιδίων');
    legend('Προσομοίωση α μέρος κουτιού', 'Θεωρία α μέρος κουτιού', 'Προσομοίωση β μέρος κουτιού', 'Θεωρία β μέρος κουτιού');
    hold off;
end

