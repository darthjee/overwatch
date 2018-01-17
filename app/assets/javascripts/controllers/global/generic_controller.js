(function(_, angular, Global) {
  function GenericController(builder, notifier, $location) {
    this.construct(builder.build($location), notifier);
  }

  var fn = GenericController.prototype,
      app = angular.module('global/generic_controller', [
        'global/generic_requester', 'global/notifier'
      ]);

  fn.construct = function(requester, notifier) {
    this.requester = requester;
    this.notifier = notifier;

    _.bindAll(this, '_setData', 'save', 'request');
    this.request();
  };

  fn.request = function() {
    promise = this.requester.request();
    promise.then(this._setData);
  };

  fn._setData = function(response) {
    this.data = response.data;
    this.loaded = true;
  }

  fn.save = function() {
    promise = this.requester.saveRequest(this.data);
    promise.then(this._setData);
  }

  fn.delete = function(id) {
    promise = this.requester.deleteRequest(id);
    promise.then(this.request);
  }

  app.controller('Global.GenericController', [
    'generic_requester', 'notifier', '$location',
    GenericController
  ]);

  Global.GenericController = GenericController;
}(window._, window.angular, window.Global));
