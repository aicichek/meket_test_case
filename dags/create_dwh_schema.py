from airflow import DAG
from airflow.operators.postgres_operator import PostgresOperator
from airflow.operators.dummy_operator import DummyOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 7, 20),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'create_dwh_schema',
    default_args=default_args,
    schedule_interval='@once',
    template_searchpath = '/opt/airflow/scripts/'
)


create_schema_task = PostgresOperator(
    task_id='create_schema',
    postgres_conn_id='target_db',
    sql='create_dwh_schema.sql',
    dag=dag,
)
create_schema_task