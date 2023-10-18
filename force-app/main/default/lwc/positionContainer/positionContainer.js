import { LightningElement } from 'lwc';

export default class PositionContainer extends LightningElement {
  positions = [];

  handlePositionDisplay(event) {
    this.positions = event.detail;
    console.log(this.positions);
  }
}