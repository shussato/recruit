import { LightningElement, api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import getPositionDetail from '@salesforce/apex/PositionDetailController.getPositionDetail';
import getPositionsWithoutDetail from '@salesforce/apex/PositionDetailController.getPositionsWithoutDetail';

export default class PositionDetail extends LightningElement {
  @api position;
  table = [];

  @wire(CurrentPageReference)
  getState(currentPageReference) {
    let recordId;
    if (currentPageReference.state.id) {
      recordId = currentPageReference.state.id;
    } else {
      recordId = 'a0B5i00000MR3XhEAL';
    }

    getPositionDetail({ recordId: recordId }).then(position => {
      this.position = position;
      // console.log(this.position);

      this.table = this.generateTable(this.position);
      console.log(this.table);

      getPositionsWithoutDetail({ recordId: recordId }).then(positions => {
        const displayEvent = new CustomEvent(
          'display',
          { detail: positions }
        );
        this.dispatchEvent(displayEvent);

      }).catch(error => {
        console.error(error);
      });

    }).catch(error => {
      console.error(error);
    });
  }

  connectedCallback() {
    
  }

  generateTable(position) {
    const generateColumn = (title, content) => {
      return { title: title, content: content };
    }

    return [
      generateColumn('職種 / 募集ポジション', position.Name),
      generateColumn('仕事内容', position.JobDescription__c),
      generateColumn('開発環境', position.DevelopmentEnvironment__c),
      generateColumn('この仕事の魅力', position.Charm__c),
      generateColumn('こんな方に向いてます', position.RecommendedTarget__c),
      generateColumn('応募資格', position.Qualification__c),
      generateColumn('歓迎スキル', position.PreferableSkill__c),
      generateColumn('雇用形態', position.EmploymentStatus__c),
      generateColumn('給与', position.Salary__c),
      generateColumn('勤務地', position.Office__r.Name + '\n' + position.Office__r.PostalCode__c + ' ' + position.Office__r.Address__c),
      generateColumn('休日・休暇', position.Holiday__c),
      generateColumn('勤務時間', position.WorkTime__c),
      generateColumn('待遇・福利厚生', position.EmployeeBenefits__c),
      generateColumn('選考ステップ', position.SelectionStep__c)
    ];
  }
}