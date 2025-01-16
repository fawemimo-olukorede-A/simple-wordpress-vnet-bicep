// sample module for a wordpress app service VNET config

param location string
param prefix string
param dbSubnet string
param appServiceSubnet string
param additionalSubnet string
param vnetPrefix string

param vnetSettings array = [
  {
    addressPrefixes: [
      vnetPrefix
    ]
    subnets: [
      {
        name: additionalSubnet
        addressPrefix: ''
      }
      { 
        name: appServiceSubnet
        addressPrefix: ''
      }
      { 
        name: dbSubnet
        addressPrefix: ''
      }
    ]
  }
]

// Get the dbSubnet address prefix
var dbSubnetPrefix = [for vnet in vnetSettings: first(filter(vnet.subnets, subnet => subnet.name == dbSubnet)).addressPrefix]

// Define the rules with subnet-specific destination addresses
var securityRules = [
  {
    name: 'allowhttpsinbound'
    port: '443'
    priority: 200
    description: 'Allow https traffic into App subnet/others'
    destinationAddressPrefix: '*'
  }
  {
    name: 'allowmysqlinbound'
    port: '3306'
    priority: 210
    description: 'Allow MySQL DB traffic'
    destinationAddressPrefix: dbSubnetPrefix[0]
  }
]

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: '${prefix}-nsg'
  location: location
  properties: {
    securityRules: [for rule in securityRules: {
      name: rule.name
      properties: {
        direction: 'Inbound'
        access: 'Allow'
        protocol: 'Tcp'
        description: rule.description
        sourceAddressPrefix: '*'
        sourcePortRange: '*'
        destinationPortRange: rule.port
        destinationAddressPrefix: rule.destinationAddressPrefix
        priority: rule.priority
      }
    }]
  }
}


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-07-01' = {
  location: location
  name: '${prefix}-vnet'
  properties: {
    addressSpace: {
      addressPrefixes: vnetSettings[0].addressPrefixes
    }
    subnets: [
      for subnet in vnetSettings[0].subnets: {
        name: subnet.name
        properties: {
          addressPrefix: subnet.addressPrefix
          networkSecurityGroup: {
            id: networkSecurityGroup.id
          }
          delegations: subnet.name == dbSubnet ? [
            {
              name: '${dbSubnet}-dlg'
              properties: {
                serviceName: 'Microsoft.DBforMySQL/flexibleServers'
              }
            }
          ]: subnet.name == appServiceSubnet ? [
            {
              name: '${appServiceSubnet}-dlg'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]: []
          privateEndpointNetworkPolicies: 'disabled'
        }
      }
    ]
  }
  dependsOn: []
}


output vNetId string = virtualNetwork.id
output appSubnetId string = virtualNetwork.properties.subnets[1].id
output dbSubnetId string = virtualNetwork.properties.subnets[2].id
output additionalSubnetId string = virtualNetwork.properties.subnets[0].id
