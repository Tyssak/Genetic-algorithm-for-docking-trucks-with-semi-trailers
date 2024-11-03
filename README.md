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

Najgorsze rezultaty otrzymano dla przyjętej początkowo metody koła ruletki. Próby poprawy tej
metody poprzez skalowanie funkcji przystosowania nie przyniosły zamierzonego rezultatu. Lepsze
wyniki otrzymano dla selekcji metodą turniejową oraz rankingową. Poprawę zanotowano również
po zastosowaniu krzyżowania wielopunktowego, oraz strategii elitarnej.
W przypadku wykorzystania metody opartej o dodawnie klatek i klasyfikatora AlexNet osiągnięta dokładność dla bazy RAVDESS wyniosła 70,09%. Pozostałe wyniki przedstawiono w poniższych tabelach.

Wyniki dla baz danych ze zdjęciami (klasyfikator CNN2D):

| **Baza danych** | **Dokładność bazowa** | **Normalizacja bez maski** | **Normalizacja z maską** | **Normalizacja + SOBEL** | **Normalizacja + CANNY** | **Normalizacja + CLAHE** |
|-----------------|-----------------------|----------------------------|--------------------------|--------------------------|--------------------------|--------------------------|
| **CK+**         | 0,8283                | 0,8788                     | 0,8485                   | **0,9040**                | 0,8030                   | 0,8788                   |
| **FER2013**     | 0,6967                | **0,6987**                 | 0,6928                   | 0,6562                   | 0,6240                   | 0,6920                   |
| **RAFDB**       | 0,8338                | 0,8342                     | **0,8344**               | 0,7120                   | 0,6932                   | 0,8322                   |

Wyniki dla materiałów wideo (baza RAVDESS - 7 emocji: spokój, radość, smutek, złość, strach, zniesmaczenie, zaskoczenie):

| **Klasyfikator** | **Dokładność bazowa** | **Normalizacja bez maski** | **Normalizacja z maską** | **Normalizacja + SOBEL** | **Normalizacja + CANNY** | **Normalizacja + CLAHE** |
|------------------|-----------------------|----------------------------|--------------------------|--------------------------|--------------------------|--------------------------|
| **CNN2D**        | 0,6006                | 0,6147                     | 0,6086                   | 0,6256                   | 0,6343                   | **0,6352**               |
| **AlexNet**      | 0,6845                | 0,6842                     | 0,6537                   | 0,5138                   | 0,4502                   | **0,6928**               |

| **Klasyfikator** | **Dokładność bazowa** | **Odejmowanie klatek z maską** | **Odejmowanie klatek (brak maski)** | **Dodawanie klatek z maską** | **Dodawanie klatek (brak maski)** |
|------------------|-----------------------|--------------------------------|------------------------------------|------------------------------|----------------------------------|
| **CNN2D**        | 0,6006                | 0,4567                         | 0,4922                             | **0,6492**                    | 0,6274                           |
| **AlexNet**      | 0,6552                | 0,5931                         | 0,6200                             | **0,7009**                    | 0,6804                           |



# Jak uruchomić
Najpierw zainstaluj wymagane zależności: 
```bash
# Sklonuj repozytorium  
git clone https://github.com/Tyssak/pracamagisterska.git

# Zainstaluj projekt   
cd pracamagisterska
pip install -e .   
pip install -r requirements.txt

# Pobierz plik model_eq.h5 i umieść go w katalogu projektu lub samemu wytrenuj model (patrz rozdział trening własnego modelu)
# Uruchom moduł (domyślnie używa pliku model_eq.h5 jako modelu)
python main.py

 ```   
# Lista wszystkich skryptów:
- clasyficate.py: Zawiera klasę Clasyficator, która klasyfikuje emocje na podstawie dostarczonej klatki. Wywoływana przez klasę PreProcessor ze skryptu pre_processor_classify.
- filters.py: Zawiera klasę FiltersOption implementującą różne filtry zastosowane w algorytmie.
- main.py: Skrypt odpowiedzialny za GUI oraz wywołujący klasę PreProcessor ze skryptu pre_processor_classify.
- model_training.ipynb: Skrypt do trenowania modelu. Domyślnie wykorzystuje dataset znajdujący się w folderze /kaggle/input/laczone/wszystkie, który został uprzednio podzielony na dwa podfoldery: jeden w folderze train oraz drugi w folderze test. Domyślna liczba klas w datasecie wynosi 7, a rozmiar obrazów to (227, 227) z trzema kanałami. Domyślnym klasyfikatorem jest AlexNet. Po odkomentowaniu oznaczonej części kodu, można użyć klasyfikatora CNN2D.
- pre_processor_classify.py: Zawiera klasę PreProcessor, implementującą główną logikę przetwarzania wstępnego oraz kilka innych przydatnych funkcji podczas przetwarzania wstępnego.
- pre_processor_prepare_dataset.py: Nieznacznie zmodyfikowana wersja klasy PreProcessor, przystosowana do przygotowania datasetu do treningu.
- prepare_dataset_from_photos.py: Skrypt pobierający zdjęcia ze ścieżki input_directory, a następnie wykonujący na nich preprocessing za pomocą klasy PreProcessor ze skryptu pre_processor_prepare_dataset. Przetworzone zdjęcia są zapisywane do ścieżki save_directory.
- prepare_dataset_from_video.py: Skrypt działający analogicznie jak prepare_dataset_from_photos.py, ale dla folderu z materiałami wideo.
- folder other_useful_scripts: Inne skrypty niewymagane do działania programu, ale przydatne podczas przygotowywania datasetów (np. wyrównanie wielkości klas, parsery, wykreślanie wykresów, czy archiwalne wersje algorytmu wykonującego preprocessing).
# 

# Przygotowanie datasetu

## Dla datasetu ze zdjęciami:
W skrypcie prepare_dataset_from_photos.py zmienić:
- input_directory - folder z datasetem treningowym bądź testowym uprzednio podzielonym na klasy - każda z klas w osobnym podfolerze.
- filter_option - wybrany filer z listy 'Enum' klasy 'FilterOption'
- save_directory - folder, do którego zostaną zapisane zdjęcia po wykonaniu preprocessingu
# 
## Dla datasetu z materiałami wideo  (obsługiwane formaty: mp4 i mkv)
W skrypcie prepare_dataset_from_photos.py wybrać:
- input_directory - folder z datasetem treningowym bądź testowym uprzednio podzielonym na klasy - każda z klas w osobnym podfolerze (chyba, że wartość w dataset = 0 lub dataset = 1)
- filter_option - wybrany filer z listy 'Enum' klasy 'FilterOption'
- save_directory - folder do którego zostaną zapisane zdjęcia po wykonaniu preprocessingu
- dataset - domyślna wartość 2. Dla wartości 0 i 1 wykonywany jest podział na klasy na podstawie nazwy pliku (tylko dla datasetu damevo: datset = 0 i RAVDESS: dataset = 1).
# 
# Trening własnego modelu
# 
Po przygotowaniu datasetu można przystąpić do treningu modelu wykorzystując skrypt model_treining.ipynb. Przed uruchomieniem skryptu należy dostosować następujące parametry na poczatku skryptu: 
- nr_classes - liczba klas w przygotowanych danych treningowych i testowych
- dataset_size - rozdzielczość zdjęć do których obrazy z datasetu zostaną przeskalowane w celu wytrenowania modelu. Modelowo (227, 227) dla AlexNet i (48,48) dla CNN2D. Najlepsze rezultaty osiąga się dla datasetów o zdjęciach w tej samej rozdzielczości, co docelowa
- nr_of_channel - liczba kanałów. 3 dla zbiorów danych w RGB (domyslnie), 1 dla zbiorów danych w skali szarości
- batch_size - 64 dla większości zbiorów danych wydaje się optymalne, jednak dla małych datsetów należy rozważyć zmniejszenie tej wartości
- dataset_path - ścieżka do zbioru z danymi (folder podzielony na 2 podfoldery - train oraz test, te z kolei powinny zawierać podfolder ze zdjęciami dla każdej z klas)
- nr_epochs - liczba epok dla których sieć będzie trenowana - dla AlexNet optymalna wartość to 30, dla CNN2D zazwyczaj w przedziale 50 - 100 w zależności od zbioru danych
# 

# Bibliografis:
 - Vadim Pisarevsky. Opencv - haarcascades subdirectory, 2020. URL https://github.com/opencv/opencv/blob/master/data/haarcascades/haarcascade_frontalface_default.
xml.
- Shubham Rath. face-detection-with-opencv-and-dnn, 2018. URL https://github.com/sr6033/face-detection-with-OpenCV-and-DNN.git.
- Farneet Singh. Ck+ facial emotion recognition - notebook, 2023. URL https://www.kaggle.com/code/farneetsingh24/ck-facial-emotion-recognition-96-46-accuracy. [Online; accessed 12 May, 2024, APACHE LICENSE, VERSION 2.0].
