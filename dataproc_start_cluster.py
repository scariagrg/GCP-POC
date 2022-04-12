# [START dataproc_v1_generated_ClusterController_StartCluster_sync]
from google.cloud import dataproc_v1
#from google.cloud.dataproc_v1.gapic.transports import cluster_controller_grpc_transport


def sample_start_cluster():
    
    #transport = cluster_controller_grpc_transport.ClusterControllerGrpcTransport(address='us-central1-dataproc.googleapis.com:443')
    # Create a client
    client = dataproc_v1.ClusterControllerClient(client_options={"api_endpoint": "us-central1-dataproc.googleapis.com:443"})
    #   cluster_client = dataproc.ClusterControllerClient(
    #    client_options={"api_endpoint": f"{region}-dataproc.googleapis.com:443"}
    #)

    # Initialize request argument(s)
    request = dataproc_v1.StartClusterRequest(
        project_id="gcp-project-2022",
        region="us-central1",
        cluster_name="cluster-c654",
    )

    # Make the request
    operation = client.start_cluster(request=request)

    print("Waiting for operation to complete...")

    response = operation.result()

    # Handle the response
    print(response)
