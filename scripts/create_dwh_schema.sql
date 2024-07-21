CREATE SCHEMA IF NOT EXISTS dwh;

CREATE TABLE IF NOT EXISTS dwh.fact_lessons (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    start_at TIMESTAMP,
    end_at TIMESTAMP,
    homework_url VARCHAR(500),
    teacher_id INTEGER,
    stream_module_id INTEGER,
    stream_id INTEGER,
    course_id INTEGER,
    online_lesson_join_url VARCHAR(255),
    online_lesson_recording_url VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS dwh.dim_stream (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    start_at TIMESTAMP,
    end_at TIMESTAMP,
    is_open BOOLEAN
);

CREATE TABLE IF NOT EXISTS dwh.dim_course (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    icon_url VARCHAR(255),
    is_auto_course_enroll BOOLEAN,
    is_demo_enroll BOOLEAN
);

CREATE TABLE IF NOT EXISTS dwh.dim_module (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    order_in_stream INTEGER
);

CREATE TABLE IF NOT EXISTS dwh.dim_teacher (
    id INTEGER PRIMARY KEY
);
