public with sharing class CompanyInfoController {
  @AuraEnabled
  public static Company__c getCompany() {
    return [SELECT Name,
                   (SELECT Name, PostalCode__c, Address__c
                    FROM Offices__r),
                    DateOfEstablishment__c,
                    Capital__c,
                    NumberOfEmployees__c,
                    Representative__c,
                    BusinessDetails__c
            FROM Company__c
            WHERE Name LIKE '%サークレイス%'];
  }
}