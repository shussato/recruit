import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import logo from '@salesforce/contentAssetUrl/logo_recruitApp';

export default class Header extends NavigationMixin(LightningElement) {
  logoUrl;
  isVisible = false;

  connectedCallback() {
    this.logoUrl = logo;
    console.log('logo', logo);
  }

  handleLogoClick(event) {
    console.log('ロゴだよ');

    this[NavigationMixin.Navigate]({
      type: 'comm__namedPage',
      attributes: {
        name: 'Home'
      }
    });
  }

  handlePositionsClick(event) {
    console.log('職種一覧だよ');

    this[NavigationMixin.Navigate]({
      type: 'comm__namedPage',
      attributes: {
        name: 'positions__c'
      }
    });
  }

  handleTabActive(event) {
    console.log(event.target.value);
  }
}