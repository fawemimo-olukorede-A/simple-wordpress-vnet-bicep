$date = Get-Date -Format "MM-dd-yyyy"
$rand = Get-Random -Maximum 1000
$deploymentName = "InfinionsWPDepmentss-"+"$date"+"-"+"$rand"

$VerbosePreference = "Continue"
$InformationPreference = "Continue"
$ErrorActionPreference = 'Stop'

Write-Information "Deploying infra"

New-AzResourceGroupDeployment -Name $deploymentName `
-ResourceGroupName ugwulo.codes `
-TemplateFile .\main.bicep `
-TemplateParameterFile .\test.bicepparam `
-Debug `
-Mode Incremental