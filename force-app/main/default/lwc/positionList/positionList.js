import { LightningElement, api, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getPositions from '@salesforce/apex/PositionListController.getPositions';

export default class PositionList extends NavigationMixin(LightningElement) {
  @api positions = [];
  listSize;
  selectedAccordion;

  message;

  get cardTitle() {
    if (this.positions.length < this.listSize) {
      return 'その他の職種';
    }
    return '職種一覧';
  }

  connectedCallback() {
    getPositions().then(positions => {
      this.listSize = positions.length;
      this.positions = [...positions];
      
    }).catch(error => {
      console.error(error);
    });
  }

  handleAccordionToggle(event) {
    // console.log(...event.detail.openSections);

    // 1つのみOpen、またはすべてClosedの状況だけを許可
    const accordion = this.template.querySelector('.position-list');
    
    accordion.activeSectionName = event.detail.openSections.filter(section => {
      return section != this.selectedAccordion;
    });
    // activeSectionNameは配列
    this.position = this.positions.find(position => {
      return position.Name == accordion.activeSectionName[0];
    });
    
    this.selectedAccordion = accordion.activeSectionName;
  }

  handleDetailClick() {
    console.log(this.position);

    // ページ遷移
    this[NavigationMixin.GenerateUrl]({
      type: 'comm__namedPage',
      attributes: {
        name: 'positionDetail__c'
      },
      state: {
        id: this.position.Id
      }
    }).then(url => {
      window.open(url, '_blank');
    });
  }
}