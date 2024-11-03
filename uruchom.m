%% skrypt uruchomieniowy - za jego pomocą lub aplikacji algorytmGUI należy włączać algorytm

clear all;
close all;
clc;

%% zmienne do edycji

pk = 0.95; % prawdopodobieństwo krzyżowania
pm = 0.01; % prawdopodobieństwo mutacji

M = 200; % liczba genotypów
MAX_Pokolen = 60; % maksymalna liczba pokoleń

scenariusz = 1; % wybrany scenariusz od 1 do 12 (wybrać 0, aby uruchomić scenariusz zdefiniowany poniżej)


%% Zdefiniuj swój scenariusz (dla opcji = 0)

% wielkość planszy (zaleca się wartości od 30 do 100)
granica = 50;

% współrzędne punktu startowego
x0 = 10;
y0 = 30;

% początkowy kąt kół w radainach (od -1 do 1)
u0 = 0;

% teta_t0 - kąt między naczepą, a osią x kartezjańskiego ukł. wsp
% teta_c0 - kąt między ciągnikiem, a osią x kartezjańskiego ukł. wsp
teta_t0 = pi/2;
teta_c0 = pi/2;

% Punkty definiujące obiekty na planszy
% dla PSC(i,j,:) i oznacza nr obiektu, a j nr kolejnego punktu
% PSC(i,j,:) łączy się z PSC(i,j-1,:) i PSC(i,j+1,:)
% z czego punkt PSC(i,1,:) łączy się jedynie z PSC(i,2,:)

PSC(1,1,:) = [50 8];
PSC(1,2,:) = [35 8];
PSC(1,3,:) = [35 7];
PSC(1,4,:) = [50 7];
PSC(2,1,:) = [50 12];
PSC(2,2,:) = [35 12];
PSC(2,3,:) = [35 13];
PSC(2,4,:) = [50 13];


%% Opcja umożliwiająca oglądnięcie zdeiniowanego scenariusza bez
%% uruchamiania algorytmu

%podglad(PSC,granica,x0,y0,teta_t0,teta_c0);

%% Uruchom algorytm

% metoda rankingowa
algorytm_rank(pk ,pm ,M ,MAX_Pokolen, scenariusz, granica, x0, y0, teta_t0, teta_c0, u0, PSC);

% metoda turniejowa
%algorytm_tur(pk ,pm ,M ,MAX_Pokolen, scenariusz, granica, x0, y0, teta_t0, teta_c0, u0, PSC);