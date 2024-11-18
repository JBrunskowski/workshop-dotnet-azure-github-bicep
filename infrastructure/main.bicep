targetScope = 'resourceGroup'

@allowed(['dev','prod'])
param environment string

module appService 'appservice.bicep' = {
  name: 'appservice'
  params: {
     appName: 'workshop-dnazghbicep-JBrunskowski'
     location: 'centralus'
     environment: environment
  }
}