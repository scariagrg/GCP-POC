"""Example Airflow DAG that kicks off a Cloud Dataproc Template that runs a
Spark Pi Job.

This DAG relies on an Airflow variable
https://airflow.apache.org/docs/apache-airflow/stable/concepts/variables.html
* project_id - Google Cloud Project ID to use for the Cloud Dataproc Template.
"""

import datetime

from airflow import models
from airflow.providers.google.cloud.operators.dataproc import DataprocInstantiateWorkflowTemplateOperator
from airflow.utils.dates import days_ago
from airflow.operators.python_operator import PythonOperator
from airflow.operators.bash_operator import BashOperator
from scripts import dataproc_start_cluster

project_id = models.Variable.get("project_id")

    
default_args = {
    # Tell airflow to start one day ago, so that it runs as soon as you upload it
    "start_date": days_ago(1),
    "project_id": project_id,
}

# Define a DAG (directed acyclic graph) of tasks.
# Any task you create within the context manager is automatically added to the
# DAG object.
with models.DAG(
    # The id you will see in the DAG airflow page
    "dataproc_workflow_dag",
    default_args=default_args,
    # The interval with which to schedule the DAG
    schedule_interval=datetime.timedelta(days=1),  # Override to match your needs
) as dag:

    start_cluster = PythonOperator(
        task_id="start_cluster",
        python_callable=dataproc_start_cluster.sample_start_cluster,
    )

    start_template_job = DataprocInstantiateWorkflowTemplateOperator(
        # The task id of your job
        task_id="dataproc_workflow_task", 
        # The template id of your workflow
        template_id="gcp_prj_2022_demo_4_dataproc",
        project_id=project_id,
        # The region for the template
        region="us-central1",
    )
    
    stop_cluster = BashOperator(
        task_id="stop_cluster",
        bash_command="gcloud dataproc clusters stop cluster-c654 --region=us-central1 ",
    )
    start_cluster >> start_template_job >> stop_cluster