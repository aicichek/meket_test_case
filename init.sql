
-- Создание схемы и таблиц

CREATE SCHEMA IF NOT EXISTS source;
CREATE TABLE IF NOT EXISTS source.stream (
    id INTEGER PRIMARY KEY,
    course_id INTEGER,
    start_at TIMESTAMP,
    end_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    is_open BOOLEAN,
    name VARCHAR(255),
    homework_deadline_days INTEGER
);

CREATE TABLE IF NOT EXISTS source.course (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    icon_url VARCHAR(255),
    is_auto_course_enroll BOOLEAN,
    is_demo_enroll BOOLEAN
);

CREATE TABLE IF NOT EXISTS source.stream_module (
    id INTEGER PRIMARY KEY,
    stream_id INTEGER,
    title VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    order_in_stream INTEGER,
    deleted_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS source.stream_module_lesson (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    start_at TIMESTAMP,
    end_at TIMESTAMP,
    homework_url VARCHAR(500),
    teacher_id INTEGER,
    stream_module_id INTEGER,
    deleted_at TIMESTAMP,
    online_lesson_join_url VARCHAR(255),
    online_lesson_recording_url VARCHAR(255)
);

-- Заполнение тестовыми данными
INSERT INTO source.course (id, title, created_at, updated_at, deleted_at, icon_url, is_auto_course_enroll, is_demo_enroll)
VALUES 
(1, 'Data Science', NOW(), NOW(), NULL, 'http://example.com/icon1.png', TRUE, FALSE),
(2, 'Web Development', NOW(), NOW(), NULL, 'http://example.com/icon2.png', TRUE, TRUE);

INSERT INTO source.stream (id, course_id, start_at, end_at, created_at, updated_at, deleted_at, is_open, name, homework_deadline_days)
VALUES 
(1, 1, NOW(), NOW() + INTERVAL '1 year', NOW(), NOW(), NULL, TRUE, 'DS2024', 7),
(2, 2, NOW(), NOW() + INTERVAL '1 year', NOW(), NOW(), NULL, TRUE, 'WD2024', 7);

INSERT INTO source.stream_module (id, stream_id, title, created_at, updated_at, order_in_stream, deleted_at)
VALUES 
(1, 1, 'Python Basics', NOW(), NOW(), 1, NULL),
(2, 1, 'Machine Learning', NOW(), NOW(), 2, NULL),
(3, 2, 'HTML & CSS', NOW(), NOW(), 1, NULL),
(4, 2, 'JavaScript', NOW(), NOW(), 2, NULL);

INSERT INTO source.stream_module_lesson (id, title, description, start_at, end_at, homework_url, teacher_id, stream_module_id, deleted_at, online_lesson_join_url, online_lesson_recording_url)
VALUES 
(1, 'Introduction to Python', 'Learn the basics of Python.', NOW(), NOW() + INTERVAL '1 hour', 'http://example.com/homework1', 1, 1, NULL, 'http://example.com/join1', 'http://example.com/recording1'),
(2, 'Advanced Python', 'Dive deeper into Python.', NOW(), NOW() + INTERVAL '1 hour', 'http://example.com/homework2', 2, 1, NULL, 'http://example.com/join2', 'http://example.com/recording2'),
(3, 'Introduction to ML', 'Learn the basics of Machine Learning.', NOW(), NOW() + INTERVAL '1 hour', 'http://example.com/homework3', 3, 2, NULL, 'http://example.com/join3', 'http://example.com/recording3'),
(4, 'Advanced ML', 'Dive deeper into Machine Learning.', NOW(), NOW() + INTERVAL '1 hour', 'http://example.com/homework4', 4, 2, NULL, 'http://example.com/join4', 'http://example.com/recording4'),
(5, 'HTML Basics', 'Learn the basics of HTML.', NOW(), NOW() + INTERVAL '1 hour', 'http://example.com/homework5', 5, 3, NULL, 'http://example.com/join5', 'http://example.com/recording5'),
(6, 'CSS Basics', 'Learn the basics of CSS.', NOW(), NOW() + INTERVAL '1 hour', 'http://example.com/homework6', 6, 3, NULL, 'http://example.com/join6', 'http://example.com/recording6'),
(7, 'Introduction to JS', 'Learn the basics of JavaScript.', NOW(), NOW() + INTERVAL '1 hour', 'http://example.com/homework7', 7, 4, NULL, 'http://example.com/join7', 'http://example.com/recording7'),
(8, 'Advanced JS', 'Dive deeper into JavaScript.', NOW(), NOW() + INTERVAL '1 hour', 'http://example.com/homework8', 8, 4, NULL, 'http://example.com/join8', 'http://example.com/recording8');
