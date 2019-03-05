<?php

$app->on('admin.init', function () use ($app) {
    $this->helper('admin')->addAssets([
      'field-oembed:dist/field-oembed.js'
      ]);
});
