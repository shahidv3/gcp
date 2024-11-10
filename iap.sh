# Enable IAP API
gcloud services enable iap.googleapis.com

# Create firewall rule for IAP
gcloud compute firewall-rules create allow-iap-ingress \
    --network=[YOUR_NETWORK] \
    --direction=INGRESS \
    --priority=1000 \
    --source-ranges=35.235.240.0/20 \
    --target-tags=allow-iap \
    --action=ALLOW \
    --rules=tcp:22

# Connect using IAP
gcloud compute ssh [INSTANCE_NAME] \
    --project=[PROJECT_ID] \
    --zone=[ZONE] \
    --tunnel-through-iap
