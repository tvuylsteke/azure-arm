Deploy a Web App

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftvuylsteke%2Fazure-arm%2Fmaster%2FApp%20Service%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

This will deploy two Azure Web Apps. One in West Europe and one in Central US with a customized homepage to show in which region the Web App is running.

![topology](overview.png)

The only remaining tasks to make this NVA demonstration to work are:

* Create and configure a Traffic Manager profile
