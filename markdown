# Simple Delphi Web Application

Простое веб-приложение на Delphi с использованием WebBroker, IIS и MS SQL Server.

## Технологии

- RAD Studio 12.3 (Delphi)
- Microsoft SQL Server
- Internet Information Services (IIS)
- WebBroker Framework

## Функциональность

- Отображение списка элементов из базы данных
- Добавление новых элементов через веб-форму

## Установка

1. Установите необходимые компоненты (см. [docs/setup_instructions.md](docs/setup_instructions.md))
2. Импортируйте базу данных из файла [database/WebAppDB_script.sql](database/WebAppDB_script.sql)
3. Скомпилируйте проект в RAD Studio
4. Настройте IIS как описано в инструкции

## Использование

- Просмотр списка: `http://yourserver/scripts/SimpleWebApp.dll/items`
- Добавление нового элемента: `http://yourserver/scripts/SimpleWebApp.dll/add`

## Лицензия

MIT License
