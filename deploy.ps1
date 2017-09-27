$adminPassword = read-host "AdminPassword" -AsSecureString
$resourceGroupName = "FTE_Networking"
$location = "West Europe"
New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
#VNET
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name "VNET" -TemplateFile .\VNET\VNET.azuredeploy.json -TemplateParameterFile .\VNET\FTE-Net.parameters.json

#Diagnostic Storage Account
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name "Diagnostic_Storage_Account" -TemplateFile .\Storage\Storage.azuredeploy.json -TemplateParameterFile .\Storage\Storage.parameters.json

#Management VM
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name "Management_VM" -TemplateFile .\Centos-MGMT\linuxMGMT.azuredeploy.json -TemplateParameterFile .\Centos-MGMT\FTE-MGMT-01.parameters.json -adminPassword $adminPassword

#FW VM
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name "FW_VM" -TemplateFile .\Centos-FW\linuxFW.azuredeploy.json -TemplateParameterFile .\Centos-FW\FTE-FW-01.parameters.json -adminPassword $adminPassword

#Server VMs
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name "Server_VMs" -TemplateFile .\Centos-SRV\linuxSRV.azuredeploy.json -TemplateParameterFile .\Centos-SRV\FTE-DATA-01.parameters.json -adminPassword $adminPassword

New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name "Server_VMs" -TemplateFile .\Centos-SRV\linuxSRV.azuredeploy.json -TemplateParameterFile .\Centos-SRV\FTE-WEB-01.parameters.json -adminPassword $adminPassword

New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name "Server_VMs" -TemplateFile .\Centos-SRV\linuxSRV.azuredeploy.json -TemplateParameterFile .\Centos-SRV\FTE-DMZOUT-01.parameters.json -adminPassword $adminPassword

New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name "Server_VMs" -TemplateFile .\Centos-SRV\linuxSRV.azuredeploy.json -TemplateParameterFile .\Centos-SRV\FTE-DMZIN-01.parameters.json -adminPassword $adminPassword

#alternative way to deploy from a template but specify all parameters in PowerShell
$subnets = @(
	@{name="Web";addressPrefix="10.1.1.0/24"};
	@{name="Business";addressPrefix="10.1.2.0/24"};
	@{name="Data";addressPrefix="10.1.3.0/24"};
	@{name="Management";addressPrefix="10.1.4.0/24"};
	@{name="GatewaySubnet";addressPrefix="10.1.0.0/24"}
	)
	
$params = @{ 
	vnetName = "FTA-NET1-VNET"; 
	vnetAddressPrefix = "10.1.0.0/16"; 
	subnets = $subnets
}

New-AzureRmResourceGroupDeployment -Name "VNETA" -ResourceGroupName "FTA-VNETPeering-rg" -TemplateUri https://raw.githubusercontent.com/tvuylsteke/azure-arm/master/VNET/VNET.azuredeploy.json -TemplateParameterObject $params