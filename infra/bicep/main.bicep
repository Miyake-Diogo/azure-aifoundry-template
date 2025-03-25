// Execute this main file to depoy Azure AI Foundry resources in the basic security configuraiton
targetScope = 'subscription'

@description('The name of the resource group to create [ Acronmym  rg will be added automatically!]')
param resourceGroupName string = 'aifoundry-demo'

// Parameters
@minLength(2)
@maxLength(12)
@description('Name for the AI resource and used to derive name of dependent resources.')
param aiHubName string = 'demo'

@description('Friendly name for your Azure AI resource')
param aiHubFriendlyName string = 'Demo AI resource'

@description('Description of your Azure AI resource dispayed in AI Foundry')
param aiHubDescription string = 'This is an example AI resource for use in Azure AI Foundry.'

// List of 7 regions that are supported by Azure AI Foundry
@allowed([
  'eastus'
  'eastus2'
  'westus2'
  'westeurope'
  'southeastasia'
  'nort'
  'australiaeast'
])
@description('Azure region used for the deployment of all resources.')
param location string = 'eastus2'

@description('Specifies the name for the Azure AI Foundry Hub Project workspace.')
param aiProjectName string = 'prj'

@description('Specifies the friendly name for the Azure AI Foundry Hub Project workspace.')
param aiProjectFriendlyName string = 'AI Foundry Hub Project'

@description('Specifies the public network access for the Azure AI Project workspace.')
param projectPublicNetworkAccess string = 'Enabled'

@description('Set of tags to apply to all resources.')
param tags object = {
  'environment': 'sandbox'
  'purpose': 'demo'
  'customer': 'contoso'
}


// Variables
var name = toLower('${aiHubName}')

// Create a short, unique suffix, that will be unique to each resource group
var uniqueSuffix = substring(uniqueString(resourceGroupName), 0, 4)

// Create a resource group for the deployment
resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-${resourceGroupName}'
  location: location
}


// Dependent resources for the Azure Machine Learning workspace
module aiDependencies 'modules/dependent-resources.bicep' = {
  scope: rg
  name: 'dependencies-${name}-${uniqueSuffix}-deployment'
  params: {
    location: location
    storageName: 'st${name}${uniqueSuffix}'
    keyvaultName: 'kv-${name}-${uniqueSuffix}'
    applicationInsightsName: 'appi-${name}-${uniqueSuffix}'
    containerRegistryName: 'cr${name}${uniqueSuffix}'
    aiServicesName: 'ais${name}${uniqueSuffix}'
    tags: tags
  }
}

module aiHub 'modules/ai-hub.bicep' = {
  scope: rg
  name: 'ai-${name}-${uniqueSuffix}-deployment'
  params: {
    // workspace organization
    aiHubName: 'aih-${name}-${uniqueSuffix}'
    aiHubFriendlyName: aiHubFriendlyName
    aiHubDescription: aiHubDescription
    aiProjectName: 'ai${aiProjectName}-${name}-${uniqueSuffix}'
    aiProjectFriendlyName: aiProjectFriendlyName
    projectPublicNetworkAccess: projectPublicNetworkAccess
    location: location
    tags: tags

    // dependent resources
    aiServicesId: aiDependencies.outputs.aiservicesID
    aiServicesTarget: aiDependencies.outputs.aiservicesTarget
    applicationInsightsId: aiDependencies.outputs.applicationInsightsId
    containerRegistryId: aiDependencies.outputs.containerRegistryId
    keyVaultId: aiDependencies.outputs.keyvaultId
    storageAccountId: aiDependencies.outputs.storageId

  }
}
