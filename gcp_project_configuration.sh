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
echo "--------------------------------------------------------------"
echo "End - Configuring new project"
echo "--------------------------------------------------------------"

#gcloud auth application-default login

#gcloud projects delete $PROJECT_ID