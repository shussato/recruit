import { LightningElement } from 'lwc';
import getCompany from '@salesforce/apex/CompanyInfoController.getCompany';

export default class CompanyInfo extends LightningElement {
  company;

  connectedCallback() {
    getCompany().then(company => {
      console.log(company);
      this.company = company;

      this.table = this.generateTable(this.company);

    }).catch(error => {
      console.error(error);
    });
  }

  generateTable(company) {
    const generateColumn = (title, content) => {
      return { title: title, content: content };
    }

    let officeInfoArray = [];
    for (const office of company.Offices__r) {
      officeInfoArray.push('<' + office.Name + '>\n' + office.PostalCode__c + ' ' + office.Address__c);
    }

    const date = new Date(company.DateOfEstablishment__c);
    const dateOfEstablishment = `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日`;

    return [
      generateColumn('会社名', company.Name),
      generateColumn('所在地', officeInfoArray.join('\n\n')),
      generateColumn('設立', dateOfEstablishment),
      generateColumn('資本金', company.Capital__c + '円'),
      generateColumn('社員数', company.NumberOfEmployees__c + '人'),
      generateColumn('代表者', company.Representative__c),
      generateColumn('事業内容', company.BusinessDetails__c)
    ];
  }
}