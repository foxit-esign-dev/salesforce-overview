public with sharing class LayoutRetrieval {
    @AuraEnabled
    public static List<String> getLayoutNamesForObject(String objectName) {
        set<String>  setObjNames = new Set<String>{objectName}; 

        List<String> layOutNames = new List<String>();

        MetadataService.MetadataPort service = createService();

        // Implement code to retrieve and populate the sorted names of the layouts here

        return layoutNames; 
    }

    public static MetadataService.MetadataPort createService() {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = retrieveConnectedApp();
        return service;
    }

    public static String  retrieveConnectedApp() {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        
        PageReference PageSessionId = Page.SessionIdPage;
        String pageContent = PageSessionId.getContent().toString();
        String SESSION_ID_START = 'SESSION_ID_START';
        String SESSION_ID_END = 'SESSION_ID_END';
        Integer startIndex = pageContent.indexOf(SESSION_ID_START) + SESSION_ID_START.length();
        Integer endIndex = pageContent.indexOf(SESSION_ID_END);
        String sessionId = pageContent.substring(startIndex, endIndex);
        service.SessionHeader.sessionId = sessionId;
           
        return sessionId;
    }

    @AuraEnabled
    public static void connectToFoxiteSign(String region){
        try {
            MetadataService.MetadataPort service = createService();

            MetadataService.AuthProvider provider = new MetadataService.AuthProvider();
            provider.fullName = 'FoxiteSignAuthProvider';
            provider.authorizeUrl = 'https://login.foxitesign.foxit.com/oauth2/authorize';
            provider.consumerKey = '10d6154ade2148e28ce62bfa89967fa0';
            provider.consumerSecret = 'ejrfEvLZqswg2cvHa+HaH+fxdaTcSdyjrUm0IEuyk2FwQRj3Ygtq1w==';
            provider.friendlyName = 'FoxiteSignAuthProvider';
            provider.includeOrgIdInIdentifier = false;
            provider.providerType = 'OpenIdConnect';
            provider.generateAuthorizationHeader = true;
            provider.sendAccessTokenInHeader = true;
            provider.sendClientCredentialsInHeader = false;
            provider.sendSecretInApis = true;
            // TODO: make instance EU or NA.
            provider.tokenUrl = 'https://' + region + '.foxitesign.foxit.com/api/oauth2/access_token';
                    
            List<MetadataService.SaveResult> providerResults = service.createMetadata(
                    new MetadataService.Metadata[] { provider });

            System.debug(providerResults);

            MetadataService.NamedCredential credential = new MetadataService.NamedCredential();
            credential.fullName = 'FoxiteSignNamedCredential';
            credential.label = 'Foxit eSign Named Credential';
            credential.allowMergeFieldsInBody = true;
            credential.allowMergeFieldsInHeader = true;
            credential.authProvider = 'FoxiteSignAuthProvider';
            // TODO: allow user to specify/change instance via UI!
            credential.endpoint = 'https://' + region + '.foxitesign.foxit.com/api';
            credential.oauthScope = 'read-write';

            // Allow user to modify this via UI! (NamedUser: One user, PerUser: Multiple Users)
            credential.principalType = 'NamedUser';
            credential.generateAuthorizationHeader = true;
            credential.protocol = 'Oauth';
                    
            List<MetadataService.SaveResult> credentialResults = service.createMetadata(
                    new MetadataService.Metadata[] { credential });

            System.debug(credentialResults);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}