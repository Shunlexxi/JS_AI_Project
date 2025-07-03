metadata description = 'Creates an Azure Container Registry and an Azure Container Apps environment.'
param name string
param location string = resourceGroup().location
param tags object = {}

param containerAppsEnvironmentName string
param containerRegistryName string
param containerRegistryResourceGroupName string = ''
param containerRegistryAdminUserEnabled bool = false
param logAnalyticsWorkspaceName string
param applicationInsightsName string = ''

module containerAppsEnvironment 'container-apps-environment.bicep' = {
  name: '${name}-container-apps-environment'
  params: {
    name: containerAppsEnvironmentName
    location: location
    tags: tags
    logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
    applicationInsightsName: applicationInsightsName
  }
}


// Deploy to a custom resource group if specified
module containerRegistryCustom 'container-registry.bicep' = if (!empty(containerRegistryResourceGroupName)) {
  name: '${name}-container-registry-custom'
  scope: resourceGroup(containerRegistryResourceGroupName)
  params: {
    name: containerRegistryName
    location: location
    adminUserEnabled: containerRegistryAdminUserEnabled
    tags: tags
  }
}

// Deploy to the current resource group if no custom group is specified
module containerRegistryDefault 'container-registry.bicep' = if (empty(containerRegistryResourceGroupName)) {
  name: '${name}-container-registry-default'
  scope: resourceGroup()
  params: {
    name: containerRegistryName
    location: location
    adminUserEnabled: containerRegistryAdminUserEnabled
    tags: tags
  }
}

output defaultDomain string = containerAppsEnvironment.outputs.defaultDomain
output environmentName string = containerAppsEnvironment.outputs.name
output environmentId string = containerAppsEnvironment.outputs.id

output registryLoginServer string = !empty(containerRegistryResourceGroupName) ? containerRegistryCustom.outputs.loginServer : containerRegistryDefault.outputs.loginServer
output registryName string = !empty(containerRegistryResourceGroupName) ? containerRegistryCustom.outputs.name : containerRegistryDefault.outputs.name
