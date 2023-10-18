@RestResource(urlMapping='/recruit/positions')
global with sharing class PositionsApi {
  @HttpGet
  global static String getPositions() {
    List<RecruitPosition__c> positions = [SELECT Name,
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
  
    JSONGenerator gen = JSON.createGenerator(true);
    gen.writeStartObject();
    gen.writeFieldName('positions');

    gen.writeStartArray();
    for (RecruitPosition__c position : positions) {
      gen.writeStartObject();
      gen.writeIdField('id', position.Id);
      gen.writeStringField('name', position.Name);
      gen.writeStringField('developmentEnvironment', position.DevelopmentEnvironment__c);
      gen.writeStringField('charm', position.Charm__c);
      gen.writeStringField('recommendedTarget', position.RecommendedTarget__c);
      gen.writeStringField('qualification', position.Qualification__c);
      gen.writeStringField('preferableSkill', position.PreferableSkill__c);
      gen.writeStringField('employmentStatus', position.EmploymentStatus__c);
      gen.writeStringField('salary', position.Salary__c);
      gen.writeStringField('officeName', position.Office__r.Name);
      gen.writeStringField('officePostalCode', position.Office__r.PostalCode__c);
      gen.writeStringField('officeAddress', position.Office__r.Address__c);
      gen.writeStringField('holiday', position.Holiday__c);
      gen.writeStringField('workTime', position.WorkTime__c);
      gen.writeStringField('employeeBenefits', position.EmployeeBenefits__c);
      gen.writeStringField('selectionStep', position.SelectionStep__c);
      gen.writeEndObject();
    }
    gen.writeEndArray();
    gen.writeEndObject();

    // System.debug(gen.getAsString().replaceAll('[\r\n]', ''));
    // return gen.getAsString().replaceAll('[\r\n\\r\\n]', '');
    return gen.getAsString();
  }
}