-- Создание базы данных
CREATE DATABASE WebAppDB;
GO

USE WebAppDB;
GO

-- Создание таблицы Items
CREATE TABLE Items (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500)
);

-- Добавление тестовых данных
INSERT INTO Items (Title, Description) VALUES 
('Первая запись', 'Это описание первой записи'),
('Вторая запись', 'Пример описания для второй записи'),
('Тест', 'Тестовый элемент для демонстрации');
GO
