public with sharing class PositionDetailController {
  @AuraEnabled
  public static RecruitPosition__c getPositionDetail(String recordId) {
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
            WHERE Id = :recordId];
  }

  @AuraEnabled
  public static List<RecruitPosition__c> getPositionsWithoutDetail(String recordId) {
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
            WHERE Id != :recordId];
  }
}