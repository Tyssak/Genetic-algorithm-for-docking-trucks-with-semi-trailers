# Dokumentacja w toku
# ENG Documenatation in progess
---
# PL
---

# System Genetycznego Wspomagania Dokowania Ciężarówek z Naczepami

<div align="left">    

## Opis
Projekt ten ma na celu rozwiązanie problemu dokowania ciężarówek z naczepami, wykorzystując klasyczny algorytm genetyczny. Problem ten polegał na znalezieniu jakiejkolwiek drogi przejazdu do miejsca docelowego unikając przy tym kolizji. W celu jego rozwiązania przyjęto strategię zgodnie z którą algorytm sterował kątem skrętu kół ciągnika oraz jego prędkością. Program można uruchomić za pomocą skryptu `uruchom.m` lub interfejsu graficznego `GUI.mlapp`. Projekt pozwala na wybór między 2 metodami selekcji: turniejową oraz rankingową. Dodatkowo umożliwia również zastosowanie krzyżowania wielopunktowego, oraz strategii elitarnej. Przygotowano 10 gotowych scenariuszy o różnym stopniu trudności, które posłużyły do przetestowania skuteczności algorytmu. Dla użytkownika dostępny jest graficzny interfejs umożliwiający dostosowanie najważniejszych parametrów algorytmu, wybór przygotowanego scenariusza, bądź też dodanie własnego. Uzyskane przez algorytm rozwiązania przedstawiane są za pomocą prostej animacji oraz wykresów. 

---

## Struktura Programu

Projekt składa się z dziewięciu głównych plików:

- **`uruchom.m`** – skrypt do uruchomienia algorytmu.
- **`GUI.mlapp`** – aplikacja graficzna GUI do uruchomienia algorytmu.
- **`Instrukcja.mlapp`** – skrócona instrukcja użytkownika, dostępna z aplikacji głównej.
- **`algorytm_rank.m`** – algorytm genetyczny z metodą selekcji rankingowej.
- **`algorytm_tur.m`** – algorytm genetyczny z metodą selekcji turniejowej.
- **`wyswietl.m`** – skrypt do animacji parkowania ciężarówki oraz wyświetlania wykresów.
- **`linexline.m`** – funkcja do sprawdzania, czy dwa odcinki się przecinają (używana do wykrywania kolizji).
- **`podglad.m`** – skrypt umożliwiający podgląd scenariusza bez uruchamiania algorytmu.
- **`scenariusze_bonus.m`** – dodatkowe scenariusze do wykorzystania w `uruchom.m`.

---

## Uproszczona Struktura Programu
![image](https://github.com/user-attachments/assets/05820a48-5f1f-4e2f-bd02-1056cce963d4)

**Uwaga:** Niektóre skrypty funkcjonują jako funkcje, które wymagają podania wielu zmiennych przy wywołaniu. Poniżej przedstawiono główne funkcje i ich parametry.

### Funkcje i Parametry

```matlab
function algorytm_tur(pk, pm, M, MAX_Pokolen, opcja, granica, x0, y0, teta_t0, teta_c0, u0, PSC)
function algorytm_rank(pk, pm, M, MAX_Pokolen, opcja, granica, x0, y0, teta_t0, teta_c0, u0, PSC)
function podglad(PSC, granica, x0, y0, teta_t0, teta_c0)
```

#### Parametry funkcji:
- **pk** – prawdopodobieństwo krzyżowania
- **pm** – prawdopodobieństwo mutacji
- **M** – liczba genotypów w każdym pokoleniu
- **MAX_Pokolen** – maksymalna liczba pokoleń
- **opcja** – wybrany scenariusz
- **granica** – wielkość planszy
- **[x0, y0]** – punkt początkowy algorytmu
- **teta_t0, teta_c0** – kąty początkowe naczepy i ciągnika
- **u0** – początkowy kąt kół (w radianach od -1 do 1)
- **PSC** – tablica trójwymiarowa definiująca punkty kolizji

---

## Wyniki
**Porównanie wyników dla algorytmów stosujących selekcję turniejową i różne rodzaje krzyżowań (maksymalna liczba pokoleń – 80, wielkość populacji – 800, wielkość turniejów - 20)**
![image](https://github.com/user-attachments/assets/c957bd69-547b-4e18-af47-5b4ac8b006ea)

**Porównanie wyników dla algorytmów z zaimplementowaną strategią elitarną i przy braku tej strategii (zastosowane krzyżowanie pięciopunktowe, maksymalna liczba pokoleń – 80, wielkość populacji – 800, wielkość turniejów - 20)**
![image](https://github.com/user-attachments/assets/7aff5f01-0eee-4998-9f29-c890facf8ceb)

**Skuteczność algorytmu wykorzystującego metodę turniejową dla 12 scenariuszy testowych**
![image](https://github.com/user-attachments/assets/6f02fcf5-6e62-45b8-a1a6-7b23a001b274)


**Przykłady rozwiązań dla wszystkich z przygotowanych scenariuszy ( pk = 0.95, pm=0.01, liczba osobników w pokoleniu = 800), oraz 2 scenariuszy własnych**
![image](https://github.com/user-attachments/assets/443d33d6-1b57-42c0-906f-e704dec540dd)
![image](https://github.com/user-attachments/assets/a684be37-59be-4133-b668-428e4e6007f8)
![image](https://github.com/user-attachments/assets/fb2e3a4b-dc98-49df-9753-467e9e7e839d)
![image](https://github.com/user-attachments/assets/a7885671-5157-4e05-8d81-1147dc0e6128)


https://github.com/user-attachments/assets/c20dc4b8-bd26-4b0c-b3c8-61c4ee327604



https://github.com/user-attachments/assets/1b327596-8999-4a50-8eab-26314543556d





---

## Jak Uruchomić

Można uruchomić program za pomocą pliku `uruchomGUI.mlapp` lub `uruchom.m`.

### **Interfejs GUI**

Poniżej przedstawiono wygląd interfejsu graficznego programu:

![image](https://github.com/user-attachments/assets/bd5ec12c-5171-4e89-805b-fd50c188d3e5)

- **Panel górny** – umożliwia ustawienie podstawowych parametrów algorytmu (zmiany mogą wpływać na wydajność).
- **Panel boczny** – wybór metody selekcji oraz jednego z 12 przygotowanych scenariuszy.
- **Panel dolny** – definiowanie własnych scenariuszy.

#### Dodaj Własny Scenariusz:
- **Krawędź** – ustawia wielkość planszy (zalecane wartości od 30 do 80).
- **Warunki początkowe** – konfiguracja pozycji i orientacji ciężarówki oraz naczepy.
- **Dodaj punkt kolizji** – wprowadzenie punktów kolizji, które definiują wierzchołki obiektów.


https://github.com/user-attachments/assets/412a851d-0e95-48a1-ad87-18640905a113


**Przykładowy scenariusz:**

![image](https://github.com/user-attachments/assets/9ab092fc-8845-463b-9493-3deb3718c557)

W celu przetestowania scenariusza bez uruchamiania algorytmu, wybierz opcję **Podgląd**. Uruchomienie algorytmu rozpocznie animację, a po jej zakończeniu wyświetlą się wykresy.


### **Skrypt uruchom**

Alternatywnie, program można uruchomić za pomocą skryptu `uruchom.m`, który oferuje możliwość ustawienia kąta skrętu kół oraz innych parametrów początkowych.

---



