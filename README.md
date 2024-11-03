---
# PL
---

# System Genetycznego Wspomagania Dokowania Ciężarówek z Naczepami

<div align="left">    

## Opis
Projekt ten ma na celu rozwiązanie problemu dokowania ciężarówek z naczepami, wykorzystując klasyczny algorytm genetyczny. Problem ten polegał na znalezieniu jakiejkolwiek drogi przejazdu do miejsca docelowego unikając przy tym kolizji. W celu jego rozwiązania przyjęto strategię zgodnie z którą algorytm sterował kątem skrętu kół ciągnika oraz jego prędkością. Program można uruchomić za pomocą skryptu `uruchom.m` lub interfejsu graficznego `GUI.mlapp`. 

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

Po uruchomieniu algorytmu uzyskujemy animację oraz wykresy związane z parkowaniem ciężarówki.

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

**Przykładowy scenariusz:**

![image](https://github.com/user-attachments/assets/9ab092fc-8845-463b-9493-3deb3718c557)

W celu przetestowania scenariusza bez uruchamiania algorytmu, wybierz opcję **Podgląd**. Uruchomienie algorytmu rozpocznie animację, a po jej zakończeniu wyświetlą się wykresy.

### **Skrypt uruchom**

Alternatywnie, program można uruchomić za pomocą skryptu `uruchom.m`, który oferuje możliwość ustawienia kąta skrętu kół oraz innych parametrów początkowych.

---

## Bibliografia
- [Preetham Manjunatha: Line 2 Line intersection point (two line segments), GitHub, 2022](https://github.com/preethamam/Line2LineIntersectionPoint/releases/tag/1.1.0)

---


