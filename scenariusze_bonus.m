%% przygotowane 2 dodatkowe scenariusze do wklejenia w sklypt uruchom

%% scenariusz 1
granica = 30;

%punkt startowy
x0 = 21;
y0 = 15;

u0 = 0;
 
teta_t0 = pi/2;
teta_c0 = pi/2;

PSC(1,1,:) = [11 -50]; 
PSC(1,2,:) = [27 -50];
PSC(2,1,:) = [11 53]; 
PSC(2,2,:) = [11 53]; 
PSC(3,1,:) = [0 5]; 
PSC(3,2,:) = [11 5];
PSC(3,3,:) = [11 0]; 
PSC(3,4,:) = [30 0];
PSC(3,5,:) = [30 20];


%% scenariusz 2
granica = 70;

% punkt startowy
x0 = 50;
y0 = 53;

u0 = 0;

teta_t0 = 0;
teta_c0 = 0;

PSC(1,1,:) = [0 3]; 
PSC(1,2,:) = [13 3]; 
PSC(1,3,:) = [13 0];
PSC(2,1,:) = [0 7]; 
PSC(2,2,:) = [13 7]; 
PSC(2,3,:) = [13 70];
PSC(3,1,:) = [70 40]; 
PSC(3,2,:) = [32 40]; 
PSC(3,3,:) = [32 25];
PSC(3,4,:) = [70 25];
PSC(4,1,:) = [13 25]; 
PSC(4,2,:) = [26 25]; 
PSC(4,3,:) = [26 40];
PSC(4,4,:) = [13 40];