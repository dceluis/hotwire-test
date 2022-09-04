import { Controller } from '@hotwired/stimulus'

function debounce(func, timeout = 500){
  let timer;
  return (...args) => {
    clearTimeout(timer);
    timer = setTimeout(() => { func.apply(this, args); }, timeout);
  };
}

export default class extends Controller {
  static targets = ['validator']
  static values = { validateUrl: String }

  connect() {
    this.validateUrl = this.validateUrlValue || this.element.action;
  }

  validate = debounce((e) => {
    const oldAction = this.element.action;
    this.element.action = this.validateUrl;
    // HACK: This is a hack to get the form to submit
    // this.element.submit(); does not trigger a TURBO_STREAM request
    this.validatorTarget.click();
    this.element.action = oldAction;
  }, 500)
}
