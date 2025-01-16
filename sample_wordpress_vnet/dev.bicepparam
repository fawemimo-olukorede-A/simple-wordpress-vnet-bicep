using 'main.bicep'

param location = 'uksouth'
param prefix = 'dev202132012dep'

param dbSubnet = 'dbSubnet'
param appServiceSubnet = 'appSubnet'
param additionalSubnet = 'additionalSubnet'
param vnetPrefix = '10.0.0.0/16'

param vnetSettings = [
  {
  addressPrefixes: [
    vnetPrefix
  ]
  subnets: [
    {
      name: additionalSubnet
      addressPrefix: '10.0.128.0/18'
    }
    { 
      name: appServiceSubnet
      addressPrefix: '10.0.0.0/18'
    }
    { 
      name: dbSubnet
      addressPrefix: '10.0.64.0/18'
    }
  ]
  //resourceGroupName: 'SAP-RG'
  //subscriptionID: '6bb6e027-47ca-4088-8ba8-0f027066e7b7'
}
{
  addressPrefixes: [
    vnetPrefix
  ]
  subnets: [
    {
      name: additionalSubnet
      addressPrefix: '10.0.128.0/18'
    }
    { 
      name: appServiceSubnet
      addressPrefix: '10.0.0.0/18'
    }
    { 
      name: dbSubnet
      addressPrefix: '10.0.64.0/18'
    }
  ]
  //resourceGroupName: 'ugwulo.codes'
  //subscriptionID: '8c67470f-7b3b-4cfa-9296-dd120f0da9bf'
}
]
