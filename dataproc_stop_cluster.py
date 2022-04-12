# [START dataproc_v1_generated_ClusterController_StartCluster_sync]
from google.cloud import dataproc_v1


def sample_stop_cluster():
    # Create a client
    client = dataproc_v1.ClusterControllerClient()

    # Initialize request argument(s)
    request = dataproc_v1.StartClusterRequest(
        project_id="gcp-project-2022",
        region="us-central1",
        cluster_name="cluster-c654",
    )

    # Make the request
    operation = client.stop_cluster(request=request)

    print("Waiting for operation to complete...")

    response = operation.result()

    # Handle the response
    print(response)
