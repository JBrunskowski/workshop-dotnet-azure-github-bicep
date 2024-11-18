targetScope = 'resourceGroup'

@allowed(['dev','prod'])
param environment string

var location = 'centralus'
var myName = 'JBrunskowski'
var appNameWithEnvironment = 'workshop-dnazghbicep-${myName}-${environment}'

module appService 'appservice.bicep' = {
  name: location
  params: {
     appName: 'workshop-dnazghbicep-${myName}'
     location: 'centralus'
     environment: environment
  }
}

module keyvault './keyvault.bicep' = {
    name: 'keyvault'
    params: {
    appId: appService.outputs.appServiceInfo.appId
    slotId: appService.outputs.appServiceInfo.slotId
    location: location
    appName: '${myName}-${environment}' // key vault has 24 char max so just doing your name, usually would do appname-env but that'll conflict for everyone
    }
}

module monitor './monitor.bicep' = {
    name: 'monitor'
    params: {
    appName: appNameWithEnvironment
    keyVaultName: keyvault.outputs.keyVaultName
    location: location
    }
}