---
# ENG
---
 
#  Genetic support system for docking trucks with semi-trailers

</div>
 
# Description   

#




# Results

# Demo


How to Run

 ```   
# List of All Scripts:

# 

# 
 ```   
# Bibliography:


---
# PL
---
<div align="center">    
 
#  System genetycznego wspomagania dokowania ciężarówek znaczepami
 
# Opis   
Program ma na celu rozwiązanie problemu dokowania ciężarówek z naczepami za pomocą klasycznego algorytmu genetycznego. Program należy uruchomiać za pomocą skryptu `uruchom.m` lub `GUI.mlapp`. Na program składa się łącznie 9 plików:

```plaintext
- uruchom.m – skrypt uruchomieniowy - za jego pomocą lub aplikacji GUI należy włączać algorytm
- GUI.mlapp – aplikacja GUI umożliwiająca uruchomienie algorytmu
- Instrukcja.mlapp – okno do otwarcia z aplikacji głównej zawierające skróconą instrukcję użytkownika
- algorytm_rank.m – główny program wraz z całym algorytmem genetycznym (metoda selekcji rankingowa)
- algorytm_tur.m – to samo co wyżej (metoda selekcji turniejowa)
- wyswietl.m – skrypt odpowiedzialny za animację parkowania ciężarówki i wyświetlenie wykresów
- linexline.m – zewnętrzna funkcja sprawdzająca, czy dwa odcinki się ze sobą przecinają (zaimplementowana w algorytmie do wykrywania kolizji) [Preetham Manjunatha: Line 2 Line intersection point (two line segments), 2022, https://github.com/preethamam/Line2LineIntersectionPoint/releases/tag/1.1.0, GitHub.]
- podglad.m – skrypt wyświetlający przygotowany scenariusz bez uruchamiania algorytmu
- scenariusze_bonus.m – przygotowane dodatkowe scenariusze do wklejenia do skryptu uruchom.m
```
Uproszczoną strukturę w programu można opisać w następujący sposób:
![image](https://github.com/user-attachments/assets/05820a48-5f1f-4e2f-bd02-1056cce963d4)

Uwaga: część skryptów występuje jako funkcje, które do wywołania często wymagają podania
wielu zmiennych:
```plaintext 
function algorytm_tur(pk, pm, M, MAX_Pokolen, opcja, granica, x0, y0, teta_t0, teta_c0, u0, PSC)
function algorytm_rank(pk, pm, M, MAX_Pokolen, opcja, granica, x0, y0, teta_t0, teta_c0, u0, PSC)
function podglad(PSC, granica, x0, y0, teta_t0, teta_c0)

gdzie:
pk – prawdopodobieństwo krzyżowania
pm – prawdopodobieństwo mutacji
M – liczba genotypów w każdym pokoleniu
MAX_Pokolen – maksymalna liczba pokoleń
opcja – wybrany scenariusz
[x0, y0] – punkt początkowy algorytmu (środek tylnej osi naczepy)
teta_t0 – początkowy kąt między naczepą, a osią x kartezjańskiego ukł. wsp
teta_c0 – początkowy kąt między ciągnikiem, a osią x kartezjańskiego ukł. Wsp
u0 – początkowy kąt kół w radainach (od -1 do 1)
PSC – trójwymiarowa tablica definiująca punkty kolizji
dla PSC(i,j,:) i oznacza nr obiektu, a j nr kolejnego punktu
PSC(i,j,:) łączy się z PSC(i,j-1,:) i PSC(i,j+1,:)
z czego punkt PSC(i,1,:) łączy się jedynie z PSC(i,2,:)
np.
 PSC(1,1,:) = [50 8];
 PSC(1,2,:) = [35 8];
 PSC(1,3,:) = [35 7];
 PSC(1,4,:) = [50 7];
 PSC(2,1,:) = [50 12];
 PSC(2,2,:) = [35 12];
 PSC(2,3,:) = [35 13];
 PSC(2,4,:) = [50 13];
function wyswietl(rt, u0, kara, pk , pm , M , MAX_Pokolen, przegrana, u_zm, r_zm, NajWybor,
srednia, Rmax, Rconst, Rmin, PCEL, PCEL2, N, k, PSC, granica, x0, y0, teta_t0, teta_c0, we, dsic,
dsin, dosc, dosn, dnos, dcos, dcel, ktora_proba, czas)
gdzie:
rt – wybrany algorytm (rt = 0 – algorytm_tur, rt = 1 – algorytm rank)
u0, pk, pm, M, MAX_Pokolen, PSC, x0, y0, teta_t0, teta_c0 – jak w algorytm_tur i algorytm_rank
kara – kara najlepszego wylosowanego osobnika (wynikająca z kolizji)
przegrana – true jeśli nie znaleziono rozwiązania, false jeśli znaleziono
u_zm – stały kąt w radianach o jaką zmienia się kąt skrętu kół u(t) w każdym kroku
r_zm – stała zmiana prędkości r(t) z każdym kolejnym krokiem (można interpretować również jako
długość każdego kroku)
NajWybor – funkcja przystosowania najlepszego osobnika wylosowanego w algorytmie
srednia – średnia funkcji przystosowania osobników z ostatniego pokolenia
<Rmax, Rmin> – przedział w którym algorytm zmienia r(t)
Rconst – wartość początkowa r(t)
PCEL – punkt celu do którego dąży tylna oś naczepy
PCEL2 – punkt celu do którego dąży przegub między naczepą, a ciężarówką
N – długość chromosomów
k – nr pokolenia dla którego algorytm zakończył działanie
granica – wielkość planszy
we – chromosom, którego rozwiązanie chcemy wyświetlić
dsic – odległość od końca ciągnika do siodła
dsin - odległość od początku naczepy do siodła
dosc - % odległość od przedniej osi do przodu ciągnika
dosn - % odległość od tylnej osi do tyłu naczepy
dnos -% odległość od tylnej osi naczepy do siodła
dcos - % odległość od przedniej osi ciągnika do siodła
ktora_proba – nr próby podczas której znaleziono rozwiązanie
czas – czas znalezienia rozwiązania przez algorytm 
 ``` 
# Wyniki


# Jak uruchomić
Program uruchamiać za pomocą pliku `uruchomGUI.mlapp` bądź uruchom.m

**uruchomGUI**
Wygląd GUI prezentuje się następująco:

![image](https://github.com/user-attachments/assets/bd5ec12c-5171-4e89-805b-fd50c188d3e5)
Do wyboru mamy kilka opcji.
Opcje na górze panelu pozwalają ustawić podstawowe parametry algorytmu, chociaż nie zaleca się ich zbyt dużej zmiany, gdyż może to wpłynąć negatywnie na szybkość działania algorytmu, bądź też jego skuteczność.
Opcje po lewej stronie pozwalają na wybranie spośród dwóch metod stosujących różne metody selekcji oraz na wybranie jednego z 12 przygotowanych scenariuszy przedstawionych na poniższym rysunku:
![image](https://github.com/user-attachments/assets/9ab092fc-8845-463b-9493-3deb3718c557)

Scenariusze te cechują się różnym stopniem trudności. Możliwe jest również zdefiniowanie własnego scenariusza. Do tego celu służy dolny panel.

**Dodaj własny scenariusz:**
Krawędź – definiuje wielkość planszy (zalecane wartości od 30 do 80)
Warunki początkowe:
Punkt startowy - pozwalają na zmianę położenia początkowego ciężarówki oraz naczepy
Orientacja:
teta_c - kąt między ciężarówką, a osią x kartezjańskiego układu współrzędnych.
teta_t - kąt pomiędzy naczepą, a osią x kartezjańskiego układu współrzędnych.
Dodaj punkt kolizji:
Punkty wprowadzone w oknie "dodaj punkt kolizji" oznaczją kolejne wierzchołki obiektu. Punkty łączą się jedynie z punktami sąsiednimi z tego samego obiektu tj. Punkt j Obiektu 1 łączyć się będzie jedynie z Punktami j-1 oraz j+1 Obiektu 1. Oznacza to, że chcąc stwrozyć zamkniętą pętlę, czyli np. trójkąt lub czworościan, jeden z punktów należy zdefiniować dwukrotnie - jako pierwszy i jako ostatni. 
Maksymlanie można zdefiniować 5 obiektów. Każdy z obiektów może składać się z maksymalnie 5 punktów. 
Sposób w jaki łączone są poszczególne punkty przedstawia poniższy rysunek:
![image](https://github.com/user-attachments/assets/895bfad1-61aa-4078-af6a-089299f05383)

Chcąc sprawdzić wygląd zdefiniowanego scenariusza bez uruchamiania algorytmu należy wybrać przycisk Podgląd.
Chcąc uruchomić algorytm należy kliknąć w przycisk Uruchom i postępować zgodnie z instrukcjami wyświetlającymi się w oknie komend (Command Window).
Przykład takich instrukcji pokazano poniżej.
![image](https://github.com/user-attachments/assets/5f92aa44-9239-4e2a-968d-7749818a92a5)

Jeśli algorytm znalazł rozwiązanie rozpocznie się animacja parkowania ciężarówki. Po zakończeniu animacji parkowania należy wcisnąć spację w celu przejścia dalej i wyświetlenia wykresów. Zamykanie okna z wykresami również odbywa się za pomocą spacji.
W sytuacji w której rozwiązanie nie zostało znalezione program pyta użytkownika, czy chce, aby dane rozwiązanie zostało wyświetlone, a następnie, w określonych sytuacjach czy użytkownik chce aby program spróbował kontynuować rozwiązanie. Jeśli użytkownik wciśnie tak, algorytm odpali się ponownie przyjmując jako pozycję początkową, pozycję końcową z poprzedniego algorytmu. W przypadku braku zgody użytkownika program umożliwia ponowne uruchomienie algorytmu od nowa, bądź też porzucenie danego przykładu.

**uruchom**
Jako alternatywę do graficznego interfejsu użytkownika przygotowano prosty skrypt `uruchom.m`, za pomocą którego wykonać można te same operacje. Skrypt ten jest bogatszy o możliwość zmiany początkowego kąta skrętu kół. Należy jednak bardziej uważać na wprowadzane parametry, gdyż w odróżnieniu od graficznego interfejsu, tutaj nie są one w żaden sposób ograniczone.
![image](https://github.com/user-attachments/assets/f5a8082d-35b9-4dd9-beda-d41882464655)

Odkomentowując odpowiedni ze skryptów możemy wybrać odpowiedni program do uruchomienia:
![image](https://github.com/user-attachments/assets/f147d622-6369-4814-8faa-058653e01632)


# Bibliografia:

