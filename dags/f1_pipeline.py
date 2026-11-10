from datetime import datetime
from airflow.sdk import DAG
from airflow.providers.standard.operators.bash import BashOperator

DB_ENV = {
    "DB_HOST": "postgres",
    "DB_PORT": "5432",
    "DB_NAME": "f1",
    "DB_USER": "airflow",
    "DB_PASSWORD": "airflow",
}
VENV = "/tmp/f1_venv"

with DAG(
    dag_id="f1_pipeline",
    start_date=datetime(2026, 1, 1),
    schedule=None,
    catchup=False,
    tags=["f1"],
) as dag:
    setup_env = BashOperator(
        task_id="setup_env",
        bash_command=f"[ -x {VENV}/bin/dbt ] || (python -m venv {VENV} && {VENV}/bin/pip install -q pandas psycopg2-binary dbt-postgres)",
    )
    extract_load = BashOperator(
        task_id="extract_load",
        bash_command=f"cd /opt/airflow/EL && {VENV}/bin/python load.py",
        env=DB_ENV,
        append_env=True,
    )
    dbt_run = BashOperator(
        task_id="dbt_run",
        bash_command=f"cd /opt/airflow/T/f1_dbt && {VENV}/bin/dbt run --profiles-dir .",
        env=DB_ENV,
        append_env=True,
    )

    setup_env >> extract_load >> dbt_run
