
PROJECT_ID=gcp-project-2022-${RANDOM}
gcloud projects create $PROJECT_ID --set-as-default

# Billing account can't be created through command
# To get the list of billing accounts - gcloud beta billing accounts list

gcloud beta billing projects link gcp-project-2022-4701 --billing-account=01D7D3-39965F-DC631F

#gcloud auth application-default login

#gcloud projects delete PROJECT_ID


