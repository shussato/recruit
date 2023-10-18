public with sharing class PositionListController {
  @AuraEnabled
  public static String getPositionsFromApi() {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://ap26.my.salesforce.com/services/apexrest/recruit/positions');
    request.setMethod('GET');
    request.setHeader('Content-Type', 'application/json');
    request.setHeader('Authorization', 'Bearer ' + ApiAuthorizeService.authorize());
    HttpResponse response = http.send(request);

    System.debug(response.getBody());
    JSONParser parser = JSON.createParser(response.getBody());
    System.debug(parser);

    if (response.getStatusCode() == 200) {
    //   Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    //   List<Object> positions = (List<Object>) results.get('positions');

    //   for(Object position: positions) {
    //       System.debug(position);
    //   }
      return response.getBody();
    }

    return response.getStatus();
  }


  @AuraEnabled
  public static List<RecruitPosition__c> getPositions() {
    return [SELECT Name,
                   JobDescription__c,
                   DevelopmentEnvironment__c,
                   Charm__c,
                   RecommendedTarget__c,
                   Qualification__c,
                   PreferableSkill__c,
                   EmploymentStatus__c,
                   Salary__c,
                   Office__r.Name,
                   Office__r.PostalCode__c,
                   Office__r.Address__c,
                   Holiday__c,
                   WorkTime__c,
                   EmployeeBenefits__c,
                   SelectionStep__c
            FROM RecruitPosition__c
            WHERE RecruitmentStatus__c = '募集中'];
  }
}