PROJECT_ID=gcp-project-2022-${RANDOM}
BILLING_ACCOUNT=01D7D3-39965F-DC631F

echo "--------------------------------------------------------------"
echo "Start - Configuring new project"
gcloud projects create $PROJECT_ID --set-as-default
rc=$?

echo "--------------------------------------------------------------"
if [ $rc -eq 0 ]
then
    echo "Project $PROJECT_ID created successfully"
else
    echo "Couldn't create project $PROJECT_ID"
fi

# Billing account can't be created through command
# To get the list of billing accounts - gcloud beta billing accounts list

gcloud beta billing projects link $PROJECT_ID --billing-account=${BILLING_ACCOUNT}
rc=$?

echo "--------------------------------------------------------------"
if [ $rc -eq 0 ]
then
    echo "Billing enabled for project $PROJECT_ID with billing account ${BILLING_ACCOUNT}"
else
    echo "Failed to enable billing for project $PROJECT_ID with billing account ${BILLING_ACCOUNT}"
fi

gcloud services enable dataproc.googleapis.com
rc=$?

echo "--------------------------------------------------------------"
if [ $rc -eq 0 ]
then
    echo "Successfully enables dataproc API"
else
    echo "Failed to enable dataproc API"
fi

#gcloud dataproc clusters create cluster-29ae \
#--region us-central1 \
#--subnet default \
#--zone us-central1-a \
#--master-machine-type n1-standard-2 \
#--master-boot-disk-size 500 \
#--num-workers 2 \
#--worker-machine-type n1-standard-2 \
#--worker-boot-disk-size 500 \
#--image-version 2.0-debian10 \
#--project gcp-project-2022-24401
#
#rc=$?
#
#echo "--------------------------------------------------------------"
#if [ $rc -eq 0 ]
#then
#    echo "Successfully created dataproc cluster"
#else
#    echo "Failed to create dataproc cluster"
#fi

echo "--------------------------------------------------------------"
echo "End - Configuring new project"
echo "--------------------------------------------------------------"

#gcloud auth application-default login

#gcloud projects delete $PROJECT_ID