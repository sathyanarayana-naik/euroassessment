//ARM Template Deployment - Virtual Network

Prerequisites
1. Install Azure CLI

2. Login to Azure: 'az login'

3. Set the desired subscription: `az account set --subscription <subscription_id>`

Deployment Steps
1. Navigate to the local folder containing the ARM template:
   cd /path/to/arm-template

2. Deploy the ARM template using Azure CLI:
   az deployment group create --resource-group <resource_group> \  
     --template-file vnet-template.json \  
     --parameters @vnet-parameters.json

3. Verify deployment in Azure Portal under Virtual Networks.

Parameters
dnsServers: Option to set default or custom DNS

nsgAssociation: Option to associate Network Security Groups

serviceEndpoints: Option to enable service endpoints on subnets

Powershell script execution:
1. Open windows powershell->navigate to script path
2. Run ./powershellinstall.ps1



![image](https://github.com/user-attachments/assets/bfa87421-af09-47fc-b4a6-b3dfaf197b69)




