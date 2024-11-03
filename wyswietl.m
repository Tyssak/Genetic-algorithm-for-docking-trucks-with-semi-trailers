%% skrypt odpowiedzialny za wizualizację rozwiązania (animacja i wykresy)
function wyswietl(rt,u0,kara,pk ,pm ,M ,MAX_Pokolen,przegrana,u_zm, r_zm,NajWybor,srednia,Rmax,Rconst,Rmin,PCEL,PCEL2,N,k,PSC,granica,x0,y0,teta_t0,teta_c0,we,dsic,dsin,dosc,dosn,dnos,dcos,dcel, ktora_proba, czas)
clear x_all y_all;

dk = 2.3; % długość kabiny ciągnika w metrach

x=x0;
y=y0;

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

u=u0; %kat skretu kół

r = Rconst;

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

set(hs,'LineWidth',10);
set(hc,'LineWidth',18);
set(hs2,'LineWidth',18);
set(hs,'Color', 'k');
set(hc,'Color', 'k');
set(hs2,'Color', 'k');
axis([0 granica 0 granica]);
set(gcf, 'Position',  [50, 50, 600, 600], 'Resize', 'off');

hText2=annotation('textbox', [0.34, 0, 0.1, 0.1], 'String', "Pozycja kół:");
hText=annotation('textbox', [0.5, 0, 0.1, 0.1], 'String', "0");
hText3=annotation('textbox', [0.64,0, 0.1, 0.1], 'String', "Prędkość:");
hText4=annotation('textbox', [0.8, 0, 0.1, 0.1], 'String', "0");
hText5=annotation('textbox', [0.64, 0.87, 0.1, 0.1], 'String', "Liczba generacji:");
hText6=annotation('textbox', [0.84, 0.87, 0.1, 0.1], 'String', num2str(k));
hText7=annotation('textbox', [0.38, 0.87, 0.1, 0.1], 'String', "Licznik kolizji:");
hText8=annotation('textbox', [0.55, 0.87, 0.1, 0.1], 'String', num2str(kara));
hText9=annotation('textbox', [0.05, 0, 0.1, 0.1], 'String', "Czas [s]:");
hText10=annotation('textbox', [0.17, 0, 0.1, 0.1], 'String', num2str(round(czas,2)));
hText12=annotation('textbox', [0.13, 0.87, 0.1, 0.1], 'String', 'Nr próby: ');
hText13=annotation('textbox', [0.255, 0.87, 0.1, 0.1], 'String', num2str(ktora_proba));

axis square;
set(gca,'xtick',[],'ytick',[]);
pause(0.01);
hold off;

ij = 1;
h = 1;
for j=1:N

    if(sqrt( (PCEL(1)-PNT(1))^2 + (PCEL(2)-PNT(2))^2 ) < dcel && sqrt( (PCEL2(1)-PP(1))^2 + (PCEL2(2)-PP(2))^2 ) < dcel )
        r = 0;
    end

    if(we(h)==0) % skręć koła w prawo
        u = u + u_zm; %o 1st
    elseif(we(h)==1) % skręć koła w lewo
        u = u - u_zm; %o 1st
    end
    h = h + 1;
    if(we(h)==0) % skręć koła w prawo
        r = r + r_zm; %o 1st
    elseif(we(h)==1) % skręć koła w lewo
        r = r - r_zm; %o 1st
    end
    h = h + 1;
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

    A = r*cos(u);
    B = A*cos(teta_c-teta_t);
    C = A*sin(teta_c-teta_t);
    x = x - B*cos(teta_t);
    y = y - B*sin(teta_t);

    %zapisuję ścieżkę
    x_all(j) = x;
    y_all(j) = y;

    Lc=(dcos*sin(teta_c)-r*cos(teta_c)*sin(u));
    Mc=(dcos*cos(teta_c)+r*sin(teta_c)*sin(u));

    Lt=dnos*sin(teta_t)-C*cos(teta_t);
    Mt=dnos*cos(teta_t)+C*sin(teta_t);

    teta_c = mod(atan2(Lc,Mc),2*pi);
    teta_t = mod(atan2(Lt,Mt),2*pi);

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
    delete(hText);
    delete(hText4);
    hText=annotation('textbox', [0.5, 0, 0.1, 0.1], 'String', num2str(round(u,1)));
    hText4=annotation('textbox', [0.8, 0, 0.1, 0.1], 'String', num2str(round(r,1)));

    set(hs,'LineWidth',szer2);
    set(hc,'LineWidth',szer1);
    set(hs2,'LineWidth',szer1);
    set(hs,'Color', 'k');
    set(hc,'Color', 'k');
    set(hs2,'Color', 'k');
    axis([0 granica 0 granica])
    set(gcf, 'Position',  [50, 50, 600, 600], 'Resize', 'off');

    if(mod(j,40)==1)
        Pcien1(ij,:) = [PCP(1),PP(1),PCP(2),PP(2)];
        Pcien2(ij,:) = [PNP(1),PNT(1),PNP(2),PNT(2)];
        Pcien3(ij,:) = [PCP(1),PCK(1),PCP(2),PCK(2)];
        ij = ij + 1;
    end

    for jy=1:size(PSC,1)
        for ju=1:size(PSC,2)-1
            hp(jy,ju) = plot([PSC(jy,ju+1,1),PSC(jy,ju,1)],[PSC(jy,ju+1,2),PSC(jy,ju,2)]);
            set(hp(jy,ju),'Color', 'k');
            set(hp(jy,ju),'LineWidth',1);
        end
    end

    axis square;
    set(gca,'xtick',[],'ytick',[]);
    pause(0.02);
    hold off;
end
hold on;
plot(x_all,y_all);
for ij=1:size(Pcien1,1)
    hscien(ij) = plot([Pcien1(ij,1),Pcien1(ij,2)],[Pcien1(ij,3),Pcien1(ij,4)]);
    hccien(ij) = plot([Pcien2(ij,1),Pcien2(ij,2)],[Pcien2(ij,3),Pcien2(ij,4)]);
    hs2cien(ij) = plot([Pcien3(ij,1),Pcien3(ij,2)],[Pcien3(ij,3),Pcien3(ij,4)]);
    set(hscien(ij),'LineWidth',szer2);
    set(hccien(ij),'LineWidth',szer1);
    set(hs2cien(ij),'LineWidth',szer1);
    set(hscien(ij),'Color', [0.3, 0.3, 0.3, 0.2]);
    set(hccien(ij),'Color', [0.3, 0.3, 0.3, 0.2]);
    set(hs2cien(ij),'Color', [0.3, 0.3, 0.3, 0.2]);
end

hold off;
pause;
delete(hText);
delete(hText2);
delete(hText3);
delete(hText4);
delete(hText5);
delete(hText6);
delete(hText7);
delete(hText8);
delete(hText9);
delete(hText10);
delete(hText12);
delete(hText13);
srednia(k+1)=srednia(k);
O = 1:length(srednia);
subplot(2,1,1);
stairs(O,srednia);
%set(gca,'YScale','log');
hold on;
title('Zmiana średniej funkcji przystosowania w zależności od liczby generacji N');
xlabel('N');
ylabel('F(ch)');
NajWybor(k+1)=NajWybor(k);
subplot(2,1,2);
stairs(O,NajWybor);
%set(gca,'YScale','log');
title({'Zmiana funkcji przystosowania najlepszego chromosomu', 'w zależności od liczby generacji N'});
xlabel('N');
ylabel('F(ch)');
pause;
hold off;
close all;
if(przegrana && kara == 0)
    tak_nie = input('Czy chcesz spróbować kontunować rozwiązanie? (T / N): ',"s");
    pytaj = true;
    while pytaj
        try
            val_0 =  double(tak_nie);
            switch val_0
                case {84,116, 89, 121}
                    pytaj = false;
                    if(rt==0)
                        algorytm_tur(pk ,pm ,M ,MAX_Pokolen, 0, granica, x, y, teta_t, teta_c, u, PSC);
                    else
                        algorytm_rank(pk ,pm ,M ,MAX_Pokolen, 0, granica, x, y, teta_t, teta_c, u, PSC);
                    end
                case {78,110}
                    pytaj = false;
                otherwise
                    disp('Czy chcesz spróbować kontunować rozwiązanie?');
                    tak_nie = input('Naciśnij T - tak  / N - nie : ',"s");
            end
        catch
            disp('Czy chcesz spróbować kontunować rozwiązanie?');
            tak_nie = input('Naciśnij T - tak  / N - nie : ',"s");
        end
    end
end