/**
 * My Theme - Main JavaScript
 * This file is auto-generated from frontend/src/ts/
 */

(function (Drupal) {
  'use strict';

  Drupal.behaviors.myTheme = {
    attach: function (context, settings) {
      // Theme initialization
      once('my-theme-init', 'body', context).forEach(function () {
        console.log('My Theme initialized');
      });
    }
  };

})(Drupal);
