%% algorytm genetyczny stosujący metodę selekcji rankingową
function algorytm_rank(pk ,pm ,M ,MAX_Pokolen, opcja, granica, x0, y0, teta_t0, teta_c0, u0, PSC)
koniec = false; % jeśli koniec = true zakończ algorytm
pokaz = false; % jeśli pokaz = true wyświetl rozwiązanie

% licznik prób (ile razy ponownie uruchamiano algorytm za pomocą komend z linii 785, 800
ktora_proba = 0;

%% stałe
Rconst = 0.6; % standardowa dłuogść jednego kroku
Rmin = 0; % minimalna dłuogść jednego kroku
Rmax = 1.4; % maksymalna dłuogść jednego kroku
sila_kary = 1; % jak silnie funkcja kary oddziaływuje na funkcję celu
u_zm = 0.1; % o ile kąt skrętu u(t) zmienia się w każdym kroku
r_zm = 0.2; % o ile prędkość r(t) zmienia się w każdym kroku


% wymiary ciężarówki
dn = 13.5; % długość naczepy w metrach
dc = 6; % długość ciągnika w metrach
dszer = 2.5; % szerokość ciężarówki
dsic = 1; % odległość od końca ciągnika do siodła
dsin = 1; % odległość od początku naczepy do siodła
dosc = 1; % odległość od przedniej osi do przodu ciągnika
dosn = 1.5; % odległość od tylnej osi do tyłu naczepy
dnos = dn - dosn - dsin; % odległość od tylnej osi naczepy do siodła
dcos = dc - dsic - dosc; % odległość od przedniej osi ciągnika do siodła

% inne odległości
dcel = 1; % odległość od celu dla której kończy się algorytm
dskrajnia = 0.3; % odległość od przeszkody którą musi zachować ciągnik

%% przygotowanie scenariusze
if (opcja == 7)
    clear PSC;
    % wielkość planszy
    granica = 60;
    % współrzędne punktu startowego
    x0 = 44;
    y0 = 55;

    % teta_t0 - kąt między naczepą, a osią x kartezjańskiego ukł. wsp
    % teta_c0 - kąt między ciągnikiem, a osią x kartezjańskiego ukł. wsp
    teta_t0 = 0;
    teta_c0 = 0;

    % Punkty definiujące obiekty na planszy
    % dla PSC(i,j,:) i oznacza nr obiektu, a j nr kolejnego punktu
    % PSC(i,j,:) łączy się z PSC(i,j-1,:) i PSC(i,j+1,:)
    % z czego punkt PSC(i,1,:) łączy się jedynie z PSC(i,2,:)
    PSC(1,1,:) = [0 27];  
    PSC(1,2,:) = [15 27]; 
    PSC(1,3,:) = [15 0];
    PSC(2,1,:) = [0 32];
    PSC(2,2,:) = [15 32];
    PSC(2,3,:) = [15 70];
    PSC(3,1,:) = [60 50];
    PSC(3,2,:) = [30 50];
    PSC(3,3,:) = [30 0];
elseif (opcja == 3)
    clear PSC;
    granica = 70;

    x0 = 16;
    y0 = 30;

    teta_t0 = pi;
    teta_c0 = pi;

    PSC(2,2,:) = [51 15]; 
    PSC(2,1,:) = [51 0];  
    PSC(1,2,:) = [56 15];
    PSC(1,1,:) = [56 0];
    PSC(2,3,:) = [0 15];
    PSC(1,3,:) = [70 15];
    PSC(3,1,:) = [50 70];
    PSC(3,2,:) = [50 27];
    PSC(3,3,:) = [70 27];
elseif (opcja == 1)
    clear PSC;
    granica = 50;

    x0 = 35;
    y0 = 33;

    teta_t0 = pi/2;
    teta_c0 = pi/2;

    PSC(1,1,:) = [0 8];  
    PSC(1,2,:) = [15 8]; 
    PSC(1,3,:) = [15 0];
    PSC(2,1,:) = [0 12];
    PSC(2,2,:) = [15 12];
    PSC(2,3,:) = [15 70];

elseif(opcja == 2)
    clear PSC;
    granica = 70;
    %punkt startowy
    x0 = 16;
    y0 = 40;

    teta_t0 = pi;
    teta_c0 = pi;

    PSC(2,2,:)=[40 20]; 
    PSC(2,1,:)=[40 0];  
    PSC(1,2,:)=[45 20];
    PSC(1,1,:)=[45 0];
    PSC(2,3,:)=[0 20];
    PSC(1,3,:)=[70 20];
elseif(opcja == 8)
    clear PSC;
    granica = 50;

    x0 = 30;
    y0 = 30;

    teta_t0 = 0;
    teta_c0 = 0;

    PSC(1,2,:) = [10 8]; 
    PSC(1,1,:) = [0 8];  
    PSC(2,2,:) = [10 13];
    PSC(2,1,:) = [0 13];
    PSC(1,3,:) = [10 0];
    PSC(2,3,:) = [10 70];
elseif(opcja == 4)
    clear PSC;
    granica = 70;

    x0 = 30;
    y0 = 16;

    teta_t0 = -pi/2;
    teta_c0 = -pi/2;


    PSC(1,2,:) = [40 55]; 
    PSC(1,1,:) = [40 70]; 
    PSC(2,2,:) = [45 55];
    PSC(2,1,:) = [45 70];
    PSC(1,3,:) = [0 55];
    PSC(2,3,:) = [70 55];
elseif(opcja == 6)
    clear PSC;
    granica = 50;

    x0 = 35;
    y0 = 35;

    teta_t0 = pi/4;
    teta_c0 = pi/4;

    PSC(1,2,:) = [12 8];
    PSC(1,1,:) = [0 8];  
    PSC(2,2,:) = [12 12];
    PSC(2,1,:) = [0 12];
    PSC(1,3,:) = [12 0];
    PSC(2,3,:) = [12 70];
elseif(opcja == 5)
    clear PSC;
    granica = 50;

    x0 = 33;
    y0 = 35;

    teta_t0 = 0;
    teta_c0 = 0;

    PSC(2,2,:) = [7 10]; 
    PSC(2,1,:) = [0 3];  
    PSC(1,2,:) = [10 7];
    PSC(1,1,:) = [3 0];
    PSC(2,3,:) = [7 70];
    PSC(1,3,:) = [70 7];
elseif(opcja == 9)
    clear PSC;
    granica = 50;

    x0 = 16;
    y0 = 35;

    teta_t0 = pi;
    teta_c0 = pi;

    PSC(2,2,:) = [38 35]; 
    PSC(2,1,:) = [50 47];  
    PSC(1,2,:) = [35 38];
    PSC(1,1,:) = [47 50];
    PSC(2,3,:) = [38 0];
    PSC(1,3,:) = [0 38];
elseif(opcja == 10)
    clear PSC;
    granica = 50;

    x0 = 20;
    y0 = 33;

    teta_t0 = pi/2;
    teta_c0 = pi/2;

    PSC(1,1,:) = [0 8];  
    PSC(1,2,:) = [15 8]; 
    PSC(1,3,:) = [15 0];
    PSC(2,1,:) = [0 12];
    PSC(2,2,:) = [15 12];
    PSC(2,3,:) = [15 70];
    PSC(3,1,:) = [30 50];
    PSC(3,2,:) = [30 0];
    PSC(3,3,:) = [50 0];
elseif (opcja ==11)
    clear PSC
    granica = 70;

    x0 = 10;
    y0 = 55;

    teta_t0 = 3*pi/5;
    teta_c0 = pi/2;

    PSC(1,1,:) = [0 9];
    PSC(1,2,:) = [20 9];
    PSC(1,3,:) = [20 35];
    PSC(1,4,:) = [0 40];
    PSC(2,1,:) = [0 4];
    PSC(2,2,:) = [20 4];
    PSC(2,3,:) = [20 0];
    PSC(3,1,:) = [70 40];
    PSC(3,2,:) = [24 40];
    PSC(3,3,:) = [37 25];
    PSC(3,4,:) = [37 0];
elseif (opcja == 12)
    clear PSC
    granica = 70;

    x0 = 10;
    y0 = 30;

    teta_t0 = pi/2;
    teta_c0 = pi/2;

    PSC(1,1,:) = [70 6];
    PSC(1,2,:) = [0 6];
    PSC(1,3,:) = [0 6];
    PSC(1,4,:) = [0 6];
    PSC(2,1,:) = [70 12];
    PSC(2,2,:) = [55 12];
    PSC(2,3,:) = [55 70];
    PSC(2,4,:) = [55 70];
    PSC(3,1,:) = [35 40];
    PSC(3,2,:) = [17 26];
    PSC(3,2,:) = [17 26];
    PSC(3,3,:) = [35 21];
    PSC(3,4,:) = [35 40];

    PSC(4,1,:) = [35 12];
    PSC(4,2,:) = [35 6];
    PSC(4,3,:) = [35 6];
    PSC(4,4,:) = [35 6];
else
    % zabezpieczenie jeśli we własnym scenariuszu zdefiniuje się grupy
    % punktów o różniej wielkości 
    for jy=1:size(PSC,1)
        for ju=1:size(PSC,2)
            if(ju > 1 && PSC(jy,ju,1) == 0 && PSC(jy,ju,2) == 0)
                PSC(jy,ju,:) = PSC(jy,ju-1,:);
            end
        end
    end
end

% używane w kolizjach
siz1 = size(PSC,1);
siz2 = size(PSC,2)-1;

%% Wyliczenie PCEL i PCEL2
PCEL(:,:) = (PSC(1,1,:) + PSC(2,1,:)) / 2;

if (PSC(1,2,2) == PSC(1,1,2)) % jeśli miejsce parkingow ustytuowane w pionie
    if (PSC(1,2,1) > PSC(1,1,1))
        PCEL2 = PCEL + [dn-dsin; 0];
    else
        PCEL2 = PCEL - [dn-dsin; 0];
    end
elseif(PSC(1,2,1) == PSC(1,1,1)) % jeśli miejsce parkingow ustytuowane w poziomie
    if (PSC(1,2,2) > PSC(1,1,2))
        PCEL2 = PCEL + [0; dn-dsin];
    else
        PCEL2 = PCEL - [0; dn-dsin];
    end
else % jeśli miejsce parkingowe na ukos
    a_sc = (PSC(1,2,2) - PSC(1,1,2)) / (PSC(1,2,1) - PSC(1,1,1));
    b_sc = PCEL(2) - a_sc*PCEL(1);
    a = 1 + a_sc^2;
    b = 2*(b_sc - PCEL(2))*a_sc - 2*PCEL(2);
    c = PCEL(1)^2 + (b_sc-PCEL(2))^2 - (dn-dsin)^2;
    delta = b^2 - 4*a*c;
    if (delta > 0)
        if ( abs((- b - sqrt(delta))/(2*a) - (PSC(1,2,1) + PSC(2,2,1)) / 2 ) ...
                < abs((- b + sqrt(delta))/(2*a) - (PSC(1,2,1) + PSC(2,2,1)) / 2))
            PCEL2(1) = (- b - sqrt(delta))/(2*a);
        else
            PCEL2(1) = (- b + sqrt(delta))/(2*a);
        end
        PCEL2(2) = a_sc*PCEL2(1) + b_sc;
    else
        % uproszczona formuła, która dla prawidłowo zdefiniowanych punktów
        % nigdy nie zostanie wywołana
        PCEL2 = PCEL + [(PSC(1,2,1) + PSC(2,2,1)) / 2 ; (PSC(1,2,2) + PSC(2,2,2)) / 2];
    end
end

%% zewnętrzna pętla uruchamiająca algorytm od nowa jeśli nie znaleziono rozwiązania
%% a użytkownik nie wprowadził jeszcze N w oknie komend na pytanie, czy powtórzyć
%% algorytm
while koniec == false
    tStart = tic; % pomiar czasu wykonania algorytmu
    disp('Proszę czekać');
    clear we we_n f_tur index_n index ini

    % zmiana długości chromosomu dla kolejnych prób
    switch(ktora_proba)
        case 2
            % formuła obliczająca długość chromosomu
            N = ceil(sqrt((x0-PCEL(1))^2 + (y0-PCEL(2))^2)/Rconst*1.7);
        case 3
            N = ceil(sqrt((x0-PCEL(1))^2 + (y0-PCEL(2))^2)/Rconst*1.4);
        case 4
            N = ceil(sqrt((x0-PCEL(1))^2 + (y0-PCEL(2))^2)/Rconst*2.2);
        case 5
            N = ceil(sqrt((x0-PCEL(1))^2 + (y0-PCEL(2))^2)/Rconst*1.6);
        otherwise
            N = ceil(sqrt((x0-PCEL(1))^2 + (y0-PCEL(2))^2)/Rconst*1.5);
    end
    % we(i,h),  we_n(i,h) - h - oznacza jeden chromosom, i - każdy kolejny gen w chromosomie
    % we - aktualne chromosomy
    % we_n - chromosomy przechodzące do nastepnego pokolenia
    we = zeros(2*N,M); 
    we_n = zeros(2*N,M);
    % index(n) nr w tablicy chromosomu o n-tej najlepszej funkcji
    % przystosowania
    index = zeros(1,M);
    % index_n(n) nr w tab. chromosomu wybranego w selekcji/krzyżowaniu itp.
    index_n = zeros(1,M);

    clear NajWybor srednia

    %% Inicjalizajca
    % losuj kierunek skrętu u(t) i zmianę prędkości r(t)
    ini= randi([0 3], N,M);

    % zamień na reprezentację binarną (nieparzyste h -geny zmieniające u(t), parzyste h - r(t))
    h = 1;
    for i=1:N
        for j=1:M
            if(ini(i,j)==0)
                we(h,j) = 0;
                we(h+1,j) = 0;
                we_n(h,j) = 0;
                we_n(h+1,j) = 0;
            elseif(ini(i,j)==1)
                we(h,j) = 0;
                we(h+1,j) = 1;
                we_n(h,j) = 0;
                we_n(h+1,j) = 1;
            elseif(ini(i,j)==2)
                we(h,j) = 1;
                we(h+1,j) = 0;
                we_n(h,j) = 1;
                we_n(h+1,j) = 0;
            else
                we(h,j) = 1;
                we(h+1,j) = 1;
                we_n(h,j) = 1;
                we_n(h+1,j) = 1;
            end
        end
        h = h + 2;
    end

    petla = true; % false jeśli zakończono algorytm
    k = 0; % k+1 - nr pokolenia

    %% pętla odpowiedzialna za przetworzenie jednego pokolenia
    while petla
        % ostateczny warunek zakończenia algorytmu 
        % (przekroczona maksymalna liczba pokoleń)
        if k >= MAX_Pokolen-1
            petla = false;
        end

        if k > 0
            %% selekcja rankingowa
            rank = zeros(M,1); % nadana ranga
            prob = zeros(M,1); % wyznaczone prawdopodobieństwo wylosowania
            rank(index(1)) = 1;
            ziw = 2;
            % nadawanie rangi kolejnym indeksom
            for wii=2:M
                if(wyborDec(wii)==wyborDec(wii-1))
                    rank(index(wii)) = rank(index(wii-1));
                else
                    rank(index(wii)) = ziw;
                    ziw = ziw + 1;
                end
            end
            wii = 1;
            while wii<=M
                prob(wii) = rank(index(round(M/8))) - rank(index(wii)) + 1;
                if(prob(wii) < 0)
                    prob(wii) = 0;
                end
                wii = wii + 1;
            end
            Fch = 0;
            %% algorytm ruletki
            for i=1:M
                Fch = Fch + prob(i); % sumuje F(ch) (Fch = 100% ruletki)
            end
            for i=1:M
                losuw = Fch*rand; % losuje los z ruletki
                j = 1;
                Fch1 = 0; % zeruje, aby wylosować kolejnego rodzica
                while (j <= M)
                    Fch1 = Fch1 + prob(j); % dodaje kolejne F(ch)
                    if (Fch1 >= losuw)          % aż będzie >= wylosowanej liczbie
                        index_n(i) = index(j);   % wtedy zapisuje id tej liczby, jako rodzic
                        j = M + 1;
                    else
                        j = j + 1;
                    end
                end
            end

            % elityzm - zachowaj najlepszego osobnika z poprzediego
            % pokolenia
            we_n(:,1) = we(:,index(1));

            %% krzyżowanie
            for j=2:2:M-1
                if(rand < pk) %sprwdzam, czy nastąpi krzyżowanie
                    % wyznaczam miejsca krzyżowania (tutaj 5-punktowe)
                    miejsce_krzyzowania = sort([floor(2*N*rand),floor(2*N*rand),floor(2*N*rand),floor(2*N*rand),floor(2*N*rand)]);
                    for i=1:2*N
                        if i <= miejsce_krzyzowania(1) % biorę chromosomy z pierwszego potomka
                            we_n(i,j)=we(i,index_n(j));
                            we_n(i,j+1)=we(i,index_n(j+1));
                        elseif i <= miejsce_krzyzowania(2) % biorę chromosomy z drugiego potomka
                            we_n(i,j)=we(i,index_n(j+1));
                            we_n(i,j+1)=we(i,index_n(j));
                        elseif i <= miejsce_krzyzowania(3) % i tak dalej na przemian
                            we_n(i,j)=we(i,index_n(j));
                            we_n(i,j+1)=we(i,index_n(j+1));
                        elseif i <= miejsce_krzyzowania(4)
                            we_n(i,j)=we(i,index_n(j+1));
                            we_n(i,j+1)=we(i,index_n(j));
                        elseif i <= miejsce_krzyzowania(5)
                            we_n(i,j)=we(i,index_n(j));
                            we_n(i,j+1)=we(i,index_n(j+1));
                        else
                            we_n(i,j)=we(i,index_n(j+1));
                            we_n(i,j+1)=we(i,index_n(j));
                        end
                    end
                else % jak nie ma krzyżowania, to przepisuję rodziców
                    we_n(:,j) = we(:,index_n(j));
                    we_n(:,j+1) = we(:,index_n(j+1));
                end
            end

            %% mutacja
            for j=2:M
                for i=1:2*N
                    if(rand < pm) % sprawdzam czy nastąpi mutacja
                        % jak zajdzie to zamieniam allel na przeciwny
                        if we_n(i,j) == 0
                            we_n(i,j) = 1;
                        else
                            we_n(i,j) = 0;
                        end
                    end
                end
            end
        end

        %% pętla - przetwórz rozwiązanie dla 1 chromosomu
        for i=1:M
            % przepisuję warunki początkowe
            x=x0;
            y=y0;

            teta_t=teta_t0;
            teta_c=teta_c0;

            u=u0;
            kara = 0;
            r = Rconst;

            % równania dynamiczne
            A = r*cos(u);
            B = A*cos(teta_c-teta_t);
            C = A*sin(teta_c-teta_t);
            x = x - B*cos(teta_t);
            y = y - B*sin(teta_t);

            Lc=(dcos*sin(teta_c)-r*cos(teta_c)*sin(u));
            Mc=(dcos*cos(teta_c)+r*sin(teta_c)*sin(u));

            Lt=dnos*sin(teta_t)-C*cos(teta_t);
            Mt=dnos*cos(teta_t)+C*sin(teta_t);

            teta_c = mod(atan2(Lc,Mc),2*pi);
            teta_t = mod(atan2(Lt,Mt),2*pi);
            teta_d = mod(teta_c-teta_t, 2*pi);

            % punkt przegub
            PP(2) = dnos*sin(teta_t)+y;
            PP(1) = dnos*cos(teta_t)+x;

            % punkt ciągnik przód
            PCP(2) = (dcos+dosc)*sin(teta_c)+PP(2);
            PCP(1) = (dcos+dosc)*cos(teta_c)+PP(1);

            % punkt naczepa tył
            PNT(2) = -dosn*sin(teta_t)+y;
            PNT(1) = -dosn*cos(teta_t)+x;

            h = 1;
            for j=1:N
                if(we_n(h,i)==0) % skręć koła w prawo
                    u = u + u_zm; % o 1 rad
                    we(h,i) = 0;
                elseif(we_n(h,i)==1) % skręć koła w lewo
                    u = u - u_zm; % o 1 rad
                    we(h,i) = 1;
                end
                h = h + 1;
                if(we_n(h,i)==0) % skręć koła w lewo
                    r = r + r_zm; % o 1st
                    we(h,i) = 0;
                elseif(we_n(h,i)==1) % skręć koła w lewo
                    r = r - r_zm; % o 1st
                    we(h,i) = 1;
                end
                h = h + 1;

                % ogranicz maksymalny kat skrętu i prędkość
                if (u > 1)
                    u = u - u_zm;
                elseif (u < -1)
                    u = u + u_zm;
                end
                if (r > Rmax)
                    r = r - r_zm;
                elseif (r < Rmin)
                    r = r + r_zm;
                end

                % równania dynamiczne
                A = r*cos(u);
                B = A*cos(teta_c-teta_t);
                C = A*sin(teta_c-teta_t);
                x = x - B*cos(teta_t);
                y = y - B*sin(teta_t);

                Lc=(dcos*sin(teta_c)-r*cos(teta_c)*sin(u));
                Mc=(dcos*cos(teta_c)+r*sin(teta_c)*sin(u));

                Lt=dnos*sin(teta_t)-C*cos(teta_t);
                Mt=dnos*cos(teta_t)+C*sin(teta_t);

                teta_c = mod(atan2(Lc,Mc),2*pi);
                teta_t = mod(atan2(Lt,Mt),2*pi);
                teta_d = mod(teta_c-teta_t, 2*pi);

                PP(2) = dnos*sin(teta_t)+y;
                PP(1) = dnos*cos(teta_t)+x;

                PCP(2) = (dcos+dosc)*sin(teta_c)+PP(2);
                PCP(1) = (dcos+dosc)*cos(teta_c)+PP(1);

                PNT(2) = -dosn*sin(teta_t)+y;
                PNT(1) = -dosn*cos(teta_t)+x;

                %% obliczenie prostych symbolizujących krawędzie ciężarówki
                % PCPp - punkt ciągnik przód prawo
                % PCPl - punkt ciągnik przód lewo
                % PCTp - punkt ciągnik przód prawo
                % PNTl - punkt naczepa tył lewo 
                % itd.
                if( r > 0.05 || r < -0.05)
                    %dla ciągnika
                    if ((PP(1)<=1.001*PCP(1) && PP(1)>=0.999*PCP(1)) || (PP(2)>=0.999*PCP(2) && PP(2)<=1.001*PCP(2)))
                        PCPp = PCP; 
                        PCPl = PCP;
                        PCTp = PP;
                        PCTl = PP;
                    else
                        ac = (PP(2)-PCP(2)) / (PP(1) - PCP(1));
                        ac_prostopadle = -1/ac;
                        bc_prostopadle = PCP(2) - ac_prostopadle*PCP(1);
                        a = 1 + ac_prostopadle^2;
                        b = 2*(bc_prostopadle - PCP(2))*ac_prostopadle - 2*PCP(1);
                        c = PCP(1)^2 + (bc_prostopadle-PCP(2))^2 - (dszer/2 + dskrajnia)^2;
                        delta = b^2 - 4*a*c;
                        if (delta > 0)
                            PCPp(1) = (- b - sqrt(delta))/(2*a);
                            PCPl(1) = (- b + sqrt(delta))/(2*a);
                        else
                            PCPp(1) = PCP(1);
                            PCPl(1) = PCP(1);
                        end
                        PCPp(2) = ac_prostopadle*PCPp(1) + bc_prostopadle;
                        PCPl(2) = ac_prostopadle*PCPl(1) + bc_prostopadle;

                        bc_prostopadle = PP(2) - ac_prostopadle*PP(1);
                        b = 2*(bc_prostopadle - PP(2))*ac_prostopadle - 2*PP(1);
                        c = PP(1)^2 + (bc_prostopadle-PP(2))^2 - (dszer/2 + dskrajnia)^2;
                        delta = b^2 - 4*a*c;
                        if (delta > 0)
                            PCTp(1) = (- b - sqrt(delta))/(2*a);
                            PCTl(1) = (- b + sqrt(delta))/(2*a);
                        else
                            PCTp(1) = PP(1);
                            PCTl(1) = PP(1);
                        end
                        PCTp(2) = ac_prostopadle*PCTp(1) + bc_prostopadle;
                        PCTl(2) = ac_prostopadle*PCTl(1) + bc_prostopadle;
                    end

                    %dla naczepy
                    if ((PP(1)<=1.001*x && PP(1)>=0.999*x) || (PP(2)>=0.999*y && PP(2)<=1.001*y))
                        PNPp = PP;
                        PNPl = PP;
                        PNTp = PNT;
                        PNTl = PNT;
                    else
                        an = (PP(2)-y) / (PP(1) - x);
                        an_prostopadle = -1/an;
                        bn_prostopadle = PP(2) - an_prostopadle*PP(1);
                        a = 1 + an_prostopadle^2;
                        b = 2*(bn_prostopadle - PP(2))*an_prostopadle - 2*PP(1);
                        c = PP(1)^2 + (bn_prostopadle-PP(2))^2 - (dszer/2 + dskrajnia)^2;
                        delta = b^2 - 4*a*c;
                        if (delta > 0)
                            PNPp(1) = (- b - sqrt(delta))/(2*a);
                            PNPl(1) = (- b + sqrt(delta))/(2*a);
                        else
                            PNPp(1) = PP(1);
                            PNPl(1) = PP(1);
                        end
                        PNPp(2) = an_prostopadle*PNPp(1) + bn_prostopadle;
                        PNPl(2) = an_prostopadle*PNPl(1) + bn_prostopadle;

                        bn_prostopadle = PNT(2) - an_prostopadle*PNT(1);
                        b = 2*(bn_prostopadle - PNT(2))*an_prostopadle - 2*PNT(1);
                        c = PNT(1)^2 + (bn_prostopadle-PNT(2))^2 - (dszer/2 + dskrajnia)^2;
                        delta = b^2 - 4*a*c;
                        if (delta > 0)
                            PNTp(1) = (- b - sqrt(delta))/(2*a);
                            PNTl(1) = (- b + sqrt(delta))/(2*a);
                        else
                            PNTp(1) = PNT(1);
                            PNTl(1) = PNT(1);
                        end
                        PNTp(2) = an_prostopadle*PNTp(1) + bn_prostopadle;
                        PNTl(2) = an_prostopadle*PNTl(1) + bn_prostopadle;
                    end
                    %% sprawdzanie kolizji
                    % sprawdzanie kolizji z obiektami na planszy
                    for jy=1:siz1
                        for ju=1:siz2
                            if ((PSC(jy,ju,1)==PSC(jy,ju+1,1) && abs(PP(1) - PSC(jy,ju,1)) < (dn - dsin))...
                                    || (PSC(jy,ju,2)==PSC(jy,ju+1,2) && abs(PP(2) - PSC(jy,ju,2)) < (dn - dsin))...
                                    || PSC(jy,ju,1)~=PSC(jy,ju+1,1) && PSC(jy,ju,2)~=PSC(jy,ju+1,2))

                                % Pkpn - punkt kolizja prawo naczepa
                                % Pkln - punkt kolizja lewo naczepa
                                % Pktn - punkt kolizja tył naczepa
                                [Pkpn(1),Pkpn(2)] = linexline([PNPp(1), PNTp(1)],[PNPp(2), PNTp(2)],...
                                    [PSC(jy,ju+1,1), PSC(jy,ju,1)], [PSC(jy,ju+1,2), PSC(jy,ju,2)],0);
                                [Pkln(1),Pkln(2)] = linexline([PNPl(1), PNTl(1)],[PNPl(2), PNTl(2)],...
                                    [PSC(jy,ju+1,1), PSC(jy,ju,1)], [PSC(jy,ju+1,2), PSC(jy,ju,2)],0);

                                if((PSC(jy,ju,1)==PSC(jy,ju+1,1) && abs(PNT(1) - PSC(jy,ju,1)) < dszer)...
                                        || (PSC(jy,ju,2)==PSC(jy,ju+1,2) && abs(PNT(2) - PSC(jy,ju,2)) < dszer)...
                                        || PSC(jy,ju,1)~=PSC(jy,ju+1,1) && PSC(jy,ju,2)~=PSC(jy,ju+1,2))

                                    [Pktn(1),Pktn(2)] = linexline([PNTp(1), PNTl(1)],[PNTp(2), PNTl(2)],...
                                        [PSC(jy,ju+1,1), PSC(jy,ju,1)], [PSC(jy,ju+1,2), PSC(jy,ju,2)],0);
                                    if(isnan(Pktn(1)) == false && isnan(Pktn(2)) == false)
                                        kara = kara + 1;
                                    end
                                end
                                % jeśli nie ma kolizji Pkpn - NaN
                                if(isnan(Pkpn(1)) == false && isnan(Pkpn(2)) == false)
                                    kara = kara + 1;
                                end
                                if(isnan(Pkln(1)) == false && isnan(Pkln(2)) == false)
                                    kara = kara + 1;
                                end
                                if ((PSC(jy,ju,1)==PSC(jy,ju+1,1) && abs(PP(1) - PSC(jy,ju,1)) < (dc - dsic))...
                                        || (PSC(jy,ju,2)==PSC(jy,ju+1,2) && abs(PP(2) - PSC(jy,ju,2)) < (dc - dsic))...
                                        || PSC(jy,ju,1)~=PSC(jy,ju+1,1) && PSC(jy,ju,2)~=PSC(jy,ju+1,2))

                                    % Pkpc - punkt kolizja prawo ciągnik
                                    % Pklc - punkt kolizja lewo ciągnik
                                    [Pkpc(1),Pkpc(2)] = linexline([PCPp(1), PCTp(1)],[PCPp(2), PCTp(2)],...
                                        [PSC(jy,ju+1,1), PSC(jy,ju,1)], [PSC(jy,ju+1,2), PSC(jy,ju,2)],0);
                                    [Pklc(1),Pklc(2)] = linexline([PCPl(1), PCTl(1)],[PCPl(2), PCTl(2)],...
                                        [PSC(jy,ju+1,1), PSC(jy,ju,1)], [PSC(jy,ju+1,2), PSC(jy,ju,2)],0);

                                    if(isnan(Pkpc(1)) == false && isnan(Pkpc(2)) == false)
                                        kara = kara + 1;
                                    end
                                    if(isnan(Pklc(1)) == false && isnan(Pklc(2)) == false)
                                        kara = kara + 1;
                                    end
                                end
                            end
                        end
                    end

                    % sprawdzanie czy ciężarówka nie wyjechała poza planszę
                    if (PNT(1) < 0 || PCP(1) < 0 || PNT(1) > granica || PCP(1) > granica)
                        kara = kara + 1;
                    end
                    if (PNT(2) < 0 || PCP(2) < 0 || PNT(2) > granica || PCP(2) > granica)
                        kara = kara + 1;
                    end

                    %jeśli kąt między ciągnikiem, a naczepą zbyt mały to kara
                    if (teta_d > pi/2 && teta_d < 3*pi/2) || (teta_d < -pi/2 && teta_d > -3*pi/2)
                        kara = kara + 10;
                    end
                end
                % warunek zakończenia rozwiązania dla danego chromosomu (chromosom osiągnął punkt docelowy)
                if(sqrt( (PCEL(1)-PNT(1))^2 + (PCEL(2)-PNT(2))^2 ) < dcel ...
                        && sqrt( (PCEL2(1)-PP(1))^2 + (PCEL2(2)-PP(2))^2 ) < dcel )
                    j = N;
                end
            end
            karaOverall(i) = kara;
            %% funkcja przystosowania (jej odwrotność)
            wybor(i) = sqrt((PCEL(1) - PNT(1))^2 + (PCEL(2) - PNT(2))^2) ...
                + 0.25 *sqrt((PCEL2(1) - PP(1))^2 + (PCEL2(2) - PP(2))^2) ...
                + sila_kary*kara;

            %% sprawdź warunek końca algorytmu
            if(sqrt( (PCEL(1)-PNT(1))^2 + (PCEL(2)-PNT(2))^2 ) < dcel ...
                    && sqrt( (PCEL2(1)-PP(1))^2 + (PCEL2(2)-PP(2))^2 ) < dcel )
                if (karaOverall(i) == 0)
                    petla = false;
                end
            end
        end
        %% uszereguj i przekształć funkcję wybor w funkcję przystosowania (wyborDec)
        [wyborInc,index]=sort(wybor);
        wyborDec = 1./wyborInc;
        NajWybor(k+1) = wyborDec(1); % najwyższa funkcja przystosowania
        srednia(k+1) = sum(wyborDec)/M;  % średnia arytmetyczna funkcji przystosowania
        k = k + 1;
    end

    %% obsługa wyświetlanych komend i decyzji użytkownika
    ktora_proba = ktora_proba + 1;
    tEnd = toc(tStart); % zakończ pomiar czasu działania
    % jeśli osiągnięto cel zakończ algorytm i wyświetl rozwiązanie
    if (karaOverall(index(1))==0 && wyborInc(1) <= (dcel+0.25*dcel)^2)
        koniec = true;
        pokaz = true;
        przegrana = false;
    else
        przegrana = true;
        pytaj = true;
        disp('Nie udało się znaleźć rozwiązania');
        tak_nie = input('Czy chcesz wyświetlić najlepsze znalezione rozwiązanie? (T / N): ',"s");
        while pytaj
            try
                val_0 =  double(tak_nie);
                switch val_0
                    case {84,116, 89, 121}
                        pokaz = true;
                        pytaj = false;
                    case {78,110}
                        pokaz = false;
                        pytaj = false;
                    otherwise
                        disp('Czy chcesz wyświetlić najlepsze znalezione rozwiązanie?');
                        tak_nie = input('Naciśnij T - tak  / N - nie : ',"s");
                end
            catch
                disp('Czy chcesz wyświetlić najlepsze znalezione rozwiązanie?');
                tak_nie = input('Naciśnij T - tak  / N - nie : ',"s");
            end
        end
    end
    if(pokaz)
        wyswietl(1,u0, karaOverall(index(1)),pk ,pm ,M ,MAX_Pokolen,przegrana, u_zm, r_zm,NajWybor, ...
            srednia,Rmax,Rconst,Rmin,PCEL,PCEL2,N,k,PSC,granica,x0,y0,teta_t0,teta_c0,we(:,index(1)), ...
            dsic,dsin,dosc,dosn,dnos,dcos,dcel, ktora_proba, tEnd);
    end
    % spytaj użytkownika, czy chce uruchomić algorytm od nowa
    if(przegrana == true)
        tak_nie = input('Czy chcesz spróbować jeszcze raz? (T / N): ',"s");
        pytaj = true;
        while pytaj
            try
                val_0 =  double(tak_nie);
                switch val_0
                    case {84,116, 89, 121}
                        koniec = false;
                        pokaz = false;
                        pytaj = false;
                    case {78,110}
                        koniec = true;
                        pokaz = false;
                        pytaj = false;
                    otherwise
                        tak_nie = input('Czy chcesz spróbować jeszcze raz? (T / N): ',"s");
                end
            catch
                disp('Czy chcesz wyświetlić najlepsze znalezione rozwiązanie?');
                tak_nie = input('Naciśnij T - tak  / N - nie : ',"s");
            end
        end
    end
    if (koniec == true)
        break;
    end
end
end