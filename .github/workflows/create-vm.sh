az group create --name MyResourceGroup --location eastus
az vm create \
    --resource-group MyResourceGroup \
    --name MyWindowsVM \
    --image Win2019Datacenter \
    --admin-username azureuser \
    --admin-password YourSecurePassword123!
    
