%% skrypt umożliwiający podgląd zdefiniowanego scenariusza bez uruchamiania algorytmu
function podglad(PSC,granica,x0,y0,teta_t0,teta_c0)

dn = 13.5; % długość naczepy w metrach
dc = 6; % długość ciągnika w metrach
dszer = 2.5; % szerokość ciężarówki
dsic = 1; % odległość od końca ciągnika do siodła
dsin = 1; % odległość od początku naczepy do siodła
dosc = 1; % odległość od przedniej osi do przodu ciągnika
dosn = 1.5; % odległość od tylnej osi do tyłu naczepy
dnos = dn - dosn - dsin; % odległość od tylnej osi naczepy do siodła
dcos = dc - dsic - dosc; % odległość od przedniej osi ciągnika do siodła
dk = 2.3; % długość kabiny ciągnika w metrach
dcel = 1; % odległość od celu dla której kończy się algorytm
dskrajnia = 0.3; % odległość od przeszkody którą musi zachować ciągnik

x=x0;
y=y0;

for jy=1:size(PSC,1)
    for ju=1:size(PSC,2)
        if(ju > 1 && PSC(jy,ju,1) == 0 && PSC(jy,ju,2) == 0)
            PSC(jy,ju,:) = PSC(jy,ju-1,:);
        end
    end
end

if(granica >= 90)
    szer1 = 12;
    szer2 = 6;
elseif(granica >= 80)
    szer1 = 14;
    szer2 = 8;
elseif(granica >= 70)
    szer1 = 16;
    szer2 = 10;
elseif(granica >= 60)
    szer1 = 18;
    szer2 = 12;
elseif(granica >= 50)
    szer1 = 20;
    szer2 = 14;
elseif(granica >= 40)
    szer1 = 26;
    szer2 = 20;
else
    szer1 = 32;
    szer2 = 26;
end

teta_t=teta_t0;
teta_c=teta_c0;

u=0; %kat skretu kół

r = 0;

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

PCT(2) = -dsic*sin(teta_c)+PP(2);
PCT(1) = -dsic*cos(teta_c)+PP(1);

PNP(2) = (dnos+dsin)*sin(teta_t)+y;
PNP(1) = (dnos+dsin)*cos(teta_t)+x;

PCK(2) = dk*sin(teta_c)+PP(2);
PCK(1) = dk*cos(teta_c)+PP(1);

hs = plot([PCP(1),PP(1)],[PCP(2),PP(2)]);
hold on;
hc = plot([PNP(1),PNT(1)],[PNP(2),PNT(2)]);
hs2 = plot([PCP(1),PCK(1)],[PCP(2),PCK(2)]);

set(hs,'LineWidth',szer2);
set(hc,'LineWidth',szer1);
set(hs2,'LineWidth',szer1);
set(hs,'Color', 'k');
set(hc,'Color', 'k');
set(hs2,'Color', 'k');
axis([0 granica 0 granica]);
set(gcf, 'Position',  [50, 50, 600, 600], 'Resize', 'off');

axis square;
set(gca,'xtick',[],'ytick',[]);
pause(0.01);

for jy=1:size(PSC,1)
    for ju=1:size(PSC,2)-1
        hp(jy,ju) = plot([PSC(jy,ju+1,1),PSC(jy,ju,1)],[PSC(jy,ju+1,2),PSC(jy,ju,2)]);
        set(hp(jy,ju),'Color', 'k');
        set(hp(jy,ju),'LineWidth',1);
    end
end
end