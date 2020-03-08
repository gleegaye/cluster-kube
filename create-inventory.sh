#!/bin/sh
PROJECT_ID=$1
gcloud config set project $PROJECT_ID
cat > hosts <<EOF
[all]
$(gcloud compute instances list | grep -v NAME | awk '{ print $5 }')

[workers]
$(gcloud compute instances list --filter="(tags.items:kube-worker)" | grep -v NAME | awk '{ print $5 }')

[masters]
$(gcloud compute instances list --filter="(tags.items:kube-master)" | grep -v NAME | awk '{ print $5 }')

[master]
$(gcloud compute instances list --filter="(name:master)" | grep -v NAME | awk '{ print $5 }')
EOF
