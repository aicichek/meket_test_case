import pandas as pd
import sqlalchemy
import sys

def extract_data():
    engine = sqlalchemy.create_engine('postgresql+psycopg2://airflow:airflow@postgres_source:5432/source_db')
    streams = pd.read_sql("SELECT * FROM source.stream WHERE deleted_at IS NULL", engine)
    courses = pd.read_sql("SELECT * FROM source.course WHERE deleted_at IS NULL", engine)
    modules = pd.read_sql("SELECT * FROM source.stream_module WHERE deleted_at IS NULL", engine)
    lessons = pd.read_sql("SELECT * FROM source.stream_module_lesson WHERE deleted_at IS NULL", engine)
    streams.to_csv('/tmp/streams.csv', index=False)
    courses.to_csv('/tmp/courses.csv', index=False)
    modules.to_csv('/tmp/modules.csv', index=False)
    lessons.to_csv('/tmp/lessons.csv', index=False)

def transform_data():
    streams = pd.read_csv('/tmp/streams.csv')
    courses = pd.read_csv('/tmp/courses.csv')
    modules = pd.read_csv('/tmp/modules.csv')
    lessons = pd.read_csv('/tmp/lessons.csv')
    
    fact_lessons = lessons.copy()
    fact_lessons['stream_id'] = fact_lessons['stream_module_id'].map(modules.set_index('id')['stream_id'])
    fact_lessons['course_id'] = fact_lessons['stream_id'].map(streams.set_index('id')['course_id'])
    
    dim_stream = streams[['id', 'name', 'start_at', 'end_at', 'is_open']].copy()
    dim_course = courses[['id', 'title', 'icon_url', 'is_auto_course_enroll', 'is_demo_enroll']].copy()
    dim_module = modules[['id', 'title', 'order_in_stream']].copy()
    dim_teacher = lessons[['teacher_id']].drop_duplicates().reset_index(drop=True)
    
    fact_lessons.to_csv('/tmp/fact_lessons.csv', index=False)
    dim_stream.to_csv('/tmp/dim_stream.csv', index=False)
    dim_course.to_csv('/tmp/dim_course.csv', index=False)
    dim_module.to_csv('/tmp/dim_module.csv', index=False)
    dim_teacher.to_csv('/tmp/dim_teacher.csv', index=False)

def load_data():
    engine = sqlalchemy.create_engine('postgresql+psycopg2://airflow:airflow@postgres_target:5432/target_db')
    fact_lessons = pd.read_csv('/tmp/fact_lessons.csv')
    dim_stream = pd.read_csv('/tmp/dim_stream.csv')
    dim_course = pd.read_csv('/tmp/dim_course.csv')
    dim_module = pd.read_csv('/tmp/dim_module.csv')
    dim_teacher = pd.read_csv('/tmp/dim_teacher.csv')
    
    fact_lessons.to_sql('fact_lessons', engine, schema='dwh', if_exists='replace', index=False)
    dim_stream.to_sql('dim_stream', engine, schema='dwh', if_exists='replace', index=False)
    dim_course.to_sql('dim_course', engine, schema='dwh', if_exists='replace', index=False)
    dim_module.to_sql('dim_module', engine, schema='dwh', if_exists='replace', index=False)
    dim_teacher.to_sql('dim_teacher', engine, schema='dwh', if_exists='replace', index=False)

if __name__ == "__main__":
    task = sys.argv[1]
    if task == 'extract':
        extract_data()
    elif task == 'transform':
        transform_data()
    elif task == 'load':
        load_data()
