Deploy a VNET by specifying the Name, Addressrange and Subnets

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftvuylsteke%2Fazure-arm%2Fmaster%2FFullSolution%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

![topology](overview.png)

The only remaining tasks to make this NVA demonstration to work are:

* Enable forwarding on both NICs of the router VM
* create the Route Tables for both the frontend and backend subnet.