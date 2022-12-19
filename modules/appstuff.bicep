param location string = resourceGroup().location
param ServiceAppName string = 'aperez-assignement-be'
param appServiceAppName string = 'aperez-assignment-fe'
param appServicePlanName string = 'aperez-asssignment-asp'
@allowed([
  'nonprod'
  'prod'
])
param enviormentType string = 'nonprod'
var appServicePlanSkuName = (enviormentType == 'nonprod') ? 'P2V3' : 'F1'

resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

resource ServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: ServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

output appServiceAppHostName string = appServiceApp.properties.defaultHostName
output ServiceAppName string = ServiceApp.properties.defaultHostName
