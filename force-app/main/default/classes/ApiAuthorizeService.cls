public with sharing class ApiAuthorizeService {
  @AuraEnabled
  public static String authorize() {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
    request.setMethod('POST');
    request.setHeader('Content-Type', 'application/x-www-form-urlencoded');

    Map<String, String> bodyMap = new Map<String, String>();
    bodyMap.put('grant_type', 'password');
    bodyMap.put('client_id', '3MVG9wt4IL4O5wvI0_EVi4GtHFCpgMQJo1ztdi0KoG3EAyiRri3kTg6vQvubTWzWWpCpEEzF5FtxlZpp1odJj');
    bodyMap.put('client_secret', '441659E41BFCB34812197D2AF2DB147C629D94E34E02CCB232272A4102F3906C');
    bodyMap.put('username', 'apitarossato@circlace.com');
    bodyMap.put('password', 'pass2023dquOmBwip3AjEjmHnjtQau642');

    List<String> bodyDetails = new List<String>();
    for (String key : bodyMap.keySet()) {
      String encodedKey = EncodingUtil.urlEncode(key, 'UTF-8');
      String encodedValue = EncodingUtil.urlEncode(bodyMap.get(key), 'UTF-8');
      bodyDetails.add(encodedKey + '=' + encodedValue);
    }
    request.setBody(String.join(bodyDetails, '&'));


    HttpResponse response = http.send(request);
    System.debug(response.getBody());

    String accessToken;
    if (response.getStatusCode() == 200) {
      Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
      accessToken = String.valueOf(results.get('access_token'));
    }

    return accessToken;
  }
}