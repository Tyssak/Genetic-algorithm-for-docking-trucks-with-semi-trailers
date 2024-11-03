---
# ENG
---
<div align="center">    
 
#  Analysis of video processing algorithms with face recordings to improve emotion recognition

</div>
 
# Description   
The goal of this work was to examine the impact of various image preprocessing methods on the effectiveness of emotion recognition by neural networks based on photos and video recordings. The methods examined include spatial normalization combined with techniques such as intensity normalization using CLAHE, edge detection with Sobel and Canny filters, and frame addition and subtraction. The study employed the AlexNet classifiers and a dedicated CNN2D network. Among all tested methods, the most effective was the frame addition method, which involves assigning 3 consecutive frames at short time intervals to the R, G, and B channels. This method also uses spatial normalization to position and scale the face based on the location of facial landmarks. The overall solution model is as follows:
#

![SolutionModel](https://github.com/user-attachments/assets/b797227f-ab93-4f9b-a134-84d727d9fc17)


# Results
Using the frame addition method and the AlexNet classifier, an accuracy of 70.09% was achieved for the RAVDESS dataset. Other results are presented in the tables below.

Results for image datasets (CNN2D classifier):

| **Dataset** | **Base Accuracy** | **Normalization without Mask** | **Normalization with Mask** | **Normalization + SOBEL** | **Normalization + CANNY** | **Normalization + CLAHE** |
|-----------------|-----------------------|----------------------------|--------------------------|--------------------------|--------------------------|--------------------------|
| **CK+**         | 0,8283                | 0,8788                     | 0,8485                   | **0,9040**                | 0,8030                   | 0,8788                   |
| **FER2013**     | 0,6967                | **0,6987**                 | 0,6928                   | 0,6562                   | 0,6240                   | 0,6920                   |
| **RAFDB**       | 0,8338                | 0,8342                     | **0,8344**               | 0,7120                   | 0,6932                   | 0,8322                   |

Wyniki dla materiałów wideo (baza RAVDESS - 7 emocji: spokój, radość, smutek, złość, strach, zniesmaczenie, zaskoczenie):

| **Classifier** | **Base Accuracy** | **Normalization without Mask** | **Normalization with Mask** | **Normalization + SOBEL** | **Normalization + CANNY** | **Normalization + CLAHE** |
|------------------|-----------------------|----------------------------|--------------------------|--------------------------|--------------------------|--------------------------|
| **CNN2D**        | 0,6006                | 0,6147                     | 0,6086                   | 0,6256                   | 0,6343                   | **0,6352**               |
| **AlexNet**      | 0,6845                | 0,6842                     | 0,6537                   | 0,5138                   | 0,4502                   | **0,6928**               |

| **Classifier** | **Base Accuracy** | **Frame Subtraction with Mask** | **Frame Subtraction (no Mask)** | **Frame Addition with Mask** | **Frame Addition (no Mask)** |
|------------------|-----------------------|--------------------------------|------------------------------------|------------------------------|----------------------------------|
| **CNN2D**        | 0,6006                | 0,4567                         | 0,4922                             | **0,6492**                    | 0,6274                           |
| **AlexNet**      | 0,6552                | 0,5931                         | 0,6200                             | **0,7009**                    | 0,6804                           |

# Demo

https://github.com/user-attachments/assets/36b7143b-1af6-4ac0-87e8-28c4e0d6439e

How to Run
First, install the required dependencies:
```bash
# Clone the repository  
git clone https://github.com/Tyssak/pracamagisterska.git

# Install the project   
cd pracamagisterska
pip install -e .   
pip install -r requirements.txt

# Download the model_eq.h5 file and place it in the project directory or train your own model (see the "Training Your Own Model" section)
# Run the module (by default, it uses the model_eq.h5 file as the model)
python main.py

 ```   
# List of All Scripts:
- clasyficate.py: Contains the Clasyficator class, which classifies emotions based on the provided frame. It is called by the PreProcessor class from the pre_processor_classify script.
- filters.py: Contains the FiltersOption class, implementing various filters used in the algorithm.
- main.py: Script responsible for the GUI and calling the PreProcessor class from the pre_processor_classify script.
- model_training.ipynb: Script for training the model. By default, it uses a dataset located in the /kaggle/input/laczone/wszystkie folder, which has been previously divided into two subfolders: one in the train folder and the other in the test folder. The default number of classes in the dataset is 7, and the image size is (227, 227) with three channels. The default classifier is AlexNet. After uncommenting the marked section of the code, the CNN2D classifier can be used.
- pre_processor_classify.py: Contains the PreProcessor class, implementing the main preprocessing logic and several other useful functions during preprocessing.
- pre_processor_prepare_dataset.py: A slightly modified version of the PreProcessor class, adapted for preparing the dataset for training.
- prepare_dataset_from_photos.py: Script that takes photos from the input_directory path and then preprocesses them using the PreProcessor class from the pre_processor_prepare_dataset script. The processed photos are saved to the save_directory path.
- prepare_dataset_from_video.py: Script that works similarly to prepare_dataset_from_photos.py but for a folder with video materials.
folder other_useful_scripts: Other scripts not required for the program to function, but useful during dataset preparation (e.g., class size balancing, parsers, plotting graphs, or archival versions of the preprocessing algorithm).
# 

# Preparing the Dataset

## For Image Dataset:
In the prepare_dataset_from_photos.py script, select:
- input_directory - the folder with the training or test dataset previously divided into classes - each class in a separate subfolder.
- filter_option - the selected filter from the Enum list of the FilterOption class.
- save_directory - the folder where the images will be saved after preprocessing.
# 
## For Video Dataset (supported formats: mp4 and mkv)
In the prepare_dataset_from_photos.py script, select:
- input_directory - the folder with the training or test dataset previously divided into classes - each class in a separate subfolder (unless the value in dataset = 0 or dataset = 1).
- filter_option - the selected filter from the Enum list of the FilterOption class.
- save_directory - the folder where the images will be saved after preprocessing.
- dataset - default value 2. For values 0 and 1, the division into classes is made based on the file name (only for damevo dataset with
# 
# Training Your Own Model
# 
After preparing the dataset, you can proceed to train the model using the model_treining.ipynb script. Before running the script, adjust the following parameters at the beginning of the script:
- nr_classes - the number of classes in the prepared training and test data.
- dataset_size - the resolution to which the images from the dataset will be scaled to train the model. Typically (227, 227) for AlexNet and (48,48) for CNN2D. The best results are achieved for datasets with images of the same resolution as the target.
- nr_of_channel - the number of channels. 3 for RGB datasets (default), 1 for grayscale datasets.
- batch_size - 64 for most datasets seems optimal, but for small datasets, consider reducing this value.
- dataset_path - the path to the data set (folder divided into 2 subfolders - train and test, which should contain a subfolder with images for each class).
- nr_epochs - the number of epochs for which the network will be trained - for AlexNet, the optimal value is 30, for CNN2D, usually in the range of 50 - 100, depending on the dataset.
# 

# Bibliography:
 - Vadim Pisarevsky. Opencv - haarcascades subdirectory, 2020. URL https://github.com/opencv/opencv/blob/master/data/haarcascades/haarcascade_frontalface_default.
xml.
- Shubham Rath. face-detection-with-opencv-and-dnn, 2018. URL https://github.com/sr6033/face-detection-with-OpenCV-and-DNN.git.
- Farneet Singh. Ck+ facial emotion recognition - notebook, 2023. URL https://www.kaggle.com/code/farneetsingh24/ck-facial-emotion-recognition-96-46-accuracy. [Online; accessed 12 May, 2024, APACHE LICENSE, VERSION 2.0].


---
# PL
---
<div align="center">    
 
#  Analiza algorytmów przetwarzania obrazu wideo z nagraniami twarzy w celu poprawy jakości wykrywania emocji
<!--
[![Paper](http://img.shields.io/badge/paper-arxiv.1001.2234-B31B1B.svg)](https://www.nature.com/articles/nature14539)
[![Conference](http://img.shields.io/badge/NeurIPS-2019-4b44ce.svg)](https://papers.nips.cc/book/advances-in-neural-information-processing-systems-31-2018)
[![Conference](http://img.shields.io/badge/ICLR-2019-4b44ce.svg)](https://papers.nips.cc/book/advances-in-neural-information-processing-systems-31-2018)
[![Conference](http://img.shields.io/badge/AnyConference-year-4b44ce.svg)](https://papers.nips.cc/book/advances-in-neural-information-processing-systems-31-2018)  

ARXIV   
[![Paper](http://img.shields.io/badge/arxiv-math.co:1480.1111-B31B1B.svg)](https://www.nature.com/articles/nature14539)

![CI testing](https://github.com/PyTorchLightning/deep-learning-project-template/workflows/CI%20testing/badge.svg?branch=master&event=push)
-->

<!--  
Conference   
-->   
</div>
 
# Opis   
Celem pracy było zbadanie wpływu różnych metod wstępnego przetwarzania obrazu na skuteczność rozpoznawania emocji przez sieci neuronowe na podstawie zdjęć i materiałów wideo. Zbadane metody to normalizacja przestrzenna łączona z takimi metodami jak normalizacja intensywności metodą CLAHE, wykrywanie krawędzi filtrem Sobela i metodą Canny, oraz dodawanie i odejmowanie klatek. W pracy wykorzystano klasyfikatory AlexNet oraz dedykowaną sieć CNN2D. Spośród wszystkich przetestowanych metod najskuteczniejsza okazała się ta, oparta o dodawanie klatek, polegająca na przypidsywaniu 3 kolejnych klatek w małych odstępach czasu do kanałów R, G i B. Metoda ta, do działania wykorzystuje także normalizację przestrzenną, pozycjonującą i skalującą twarz w oparciu o pozycję punktów charakterysytcznych twarzy. Ogólny model rozwiązania prezentuje się następująco: 
#

![ModelRoziwazania](https://github.com/user-attachments/assets/05c95074-30d5-4596-9cce-79f8b4bb4965)


# Wyniki
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
