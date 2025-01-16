param location string
param prefix string
param dbSubnet string
param appServiceSubnet string
param additionalSubnet string
param vnetPrefix string

param vnetSettings array


module core 'modules/core.bicep' = [for (vnet, index) in vnetSettings: {
  name: '${index}-core'
  params: {
    location: location
    prefix: prefix
    vnetPrefix: vnetPrefix
    dbSubnet: dbSubnet
    appServiceSubnet: appServiceSubnet
    additionalSubnet: additionalSubnet
    vnetSettings: vnetSettings
  }
  scope: resourceGroup(vnet.subscriptionID, vnet.resourceGroupName)
}]
