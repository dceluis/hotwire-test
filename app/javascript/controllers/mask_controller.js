import { Controller } from '@hotwired/stimulus'
import IMask from 'imask';

export default class extends Controller {
  connect() {
    this.maskOptions = {
      mask: this.element.getAttribute('data-mask'),
      lazy: true,
      overwrite: true,
    }
    this.mask = IMask(this.element, this.maskOptions);
  }
}
