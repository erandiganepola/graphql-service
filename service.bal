import wso2sa/getcountrybycode;
import ballerina/log;
import ballerina/graphql;

configurable string secret = ?;
configurable string clientId = ?;

service /graphql on new graphql:Listener(9090) {
    resource function get countries(string countryCode) returns error|Country {
        getcountrybycode:Client getcountrybycodeEp = check new (config = {
            auth: {
                clientId: clientId,
                clientSecret: secret
            }
        });
        getcountrybycode:CountryResponse res = check getcountrybycodeEp->getCountriesCountrycode(countryCode = countryCode);
        Country country = new(res.name);
        return country;
    }
}

service class Country {
    private string name;
    
    function init(string name) {
        self.name = name;
    }

    resource function get name () returns string {
        return self.name;
    }

    resource function get gdp () returns decimal {
        log:printInfo("Sending request to world bank API");
        return 10;
    }
}