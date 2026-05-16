# Отчет по лабораторной работе 02: Изучение систем контроля версий на примере Git

## 1.  Настройка аутентификации утилиты hub
Для управления репозиториями из консоли были экспортированы конфигурационные переменные и сформирован локальный файл авторизации для утилиты hub с использованием токена доступа:

```bash
export GITHUB_USERNAME=Ваша_Учетка_GitHub
export GITHUB_EMAIL=Ваша_Почта_GitHub
export GITHUB_TOKEN=ghp_ВашТокенСПравамиRepo
alias edit=nano

cd ${GITHUB_USERNAME}/workspace
source scripts/activate

mkdir -p ~/.config
cat > ~/.config/hub <<EOF
github.com:
- user: ${GITHUB_USERNAME}
  oauth_token: ${GITHUB_TOKEN}
  protocol: https
EOF

git config --global hub.protocol https
```
## 2.  Инициализация локального репозитория и синхронизация с сервером
Локальный каталог projects/lab02 был объявлен Git-репозиторием. Настроены глобальные параметры пользователя, добавлена связь с удаленным сервером и стянуты файлы лицензии (MIT License), созданной ранее через веб-интерфейс GitHub. После этого выполнен первый тестовый коммит:

```Bash
mkdir -p projects/lab02 && cd projects/lab02
git init
git config --global user.name ${GITHUB_USERNAME}
git config --global user.email ${GITHUB_EMAIL}

git remote add origin [https://github.com/$](https://github.com/$){GITHUB_USERNAME}/lab02.git
git pull origin master

touch README.md
git status
git add README.md
git commit -m "added README.md"
git push origin master
```
## 3. Разработка исходного кода библиотеки печати на C++
Была создана структура директорий проекта (sources/, include/, examples/). С помощью потокового вывода командной строки cat написаны исходные файлы и заголовочные файлы библиотеки:

```Bash
mkdir sources
mkdir include
mkdir examples

cat > sources/print.cpp <<EOF
#include <print.hpp>

void print(const std::string& text, std::ostream& out)
{
  out << text;
}

void print(const std::string& text, std::ofstream& out)
{
  out << text;
}
EOF

cat > include/print.hpp <<EOF
#include <fstream>
#include <iostream>
#include <string>

void print(const std::string& text, std::ofstream& out);
void print(const std::string& text, std::ostream& out = std::cout);
EOF
```
## 4. Создание примеров использования разработанной функции
Были подготовлены файлы example1.cpp и example2.cpp для демонстрации работы перегруженной функции вывода в стандартный поток (std::cout) и в текстовый файл:

````Bash
cat > examples/example1.cpp <<EOF
#include <print.hpp>

int main(int argc, char** argv)
{
  print("hello");
}
EOF

cat > examples/example2.cpp <<EOF
#include <print.hpp>
#include <fstream>

int main(int argc, char** argv)
{
  std::ofstream file("log.txt");
  print(std::string("hello"), file);
}
EOF
```
## 5. Сохранение изменений и отправка проекта в репозиторий
Файл README.md был отредактирован. Все созданные исходные коды на С++ были добавлены в индекс Git, зафиксированы коммитом в истории проекта и отправлены в удаленную ветку на сервер GitHub:

```Bash
edit README.md
git status
git add .
git commit -m "added sources"
git push origin master
```
## 6. Автоматическая генерация отчета по лабораторной работе
```Bash
cd ~/workspace/
export LAB_NUMBER=02
git clone [https://github.com/tp-labs/lab$](https://github.com/tp-labs/lab$){LAB_NUMBER}.git tasks/lab${LAB_NUMBER}
mkdir -p reports/lab${LAB_NUMBER}
cp tasks/lab${LAB_NUMBER}/README.md reports/lab${LAB_NUMBER}/REPORT.md
cd reports/lab${LAB_NUMBER}

edit REPORT.md
gist REPORT.md
```
