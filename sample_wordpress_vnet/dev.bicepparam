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

}
]
