import { Controller } from '@hotwired/stimulus';

// modified from https://github.com/excid3/tailwindcss-stimulus-components/blob/master/src/modal.js

export default class extends Controller {
  static targets = ['container']
  static values = {
    open: {
      type: Boolean,
      default: false,
    }
  }

  initialize() {
    this.toggleClass = "hidden";
    this.backgroundId = 'modal-background';
    this.backgroundHtml = `<div id="${this.backgroundId}" class="b-modal__backdrop"></div>`;
  }

  disconnect() {
    this.close();
  }

  doOpen() {
    this.containerTarget.classList.remove(this.toggleClass);

    document.body.insertAdjacentHTML('beforeend', this.backgroundHtml);
    this.background = document.querySelector(`#${this.backgroundId}`);
  }

  doClose() {
    this.containerTarget.classList.add(this.toggleClass);

    if (this.background) { this.background.remove() }
  }

  closeBackground(e) {
    if (e.target === this.containerTarget) { 
      this.close(e);
    }
  }

  closeWithKeyboard(e) {
    if (e.keyCode === 27) {
      this.close(e);
    }
  }

  open(e) {
    if (e) { e.preventDefault(); }

    this.openValue = true;
  }

  close(e) {
    if (e) { e.preventDefault(); }

    this.openValue = false;
  }

  openValueChanged() {
    if (this.openValue) {
      this.doOpen();
    } else {
      this.doClose();
    }
  }
}
