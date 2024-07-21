from airflow import DAG
from airflow.operators.bash_operator import BashOperator
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
    'etl_dwh_process',
    default_args=default_args,
    schedule_interval='@daily',
)

extract_task = BashOperator(
    task_id='extract_data',
    bash_command='python /opt/airflow/scripts/etl.py extract',
    dag=dag,
)

transform_task = BashOperator(
    task_id='transform_data',
    bash_command='python /opt/airflow/scripts/etl.py transform',
    dag=dag,
)

load_task = BashOperator(
    task_id='load_data',
    bash_command='python /opt/airflow/scripts/etl.py load',
    dag=dag,
)

extract_task >> transform_task >> load_task
