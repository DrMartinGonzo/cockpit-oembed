<?php

$app->on('admin.init', function () use ($app) {
    $this->helper('admin')->addAssets([
      'field-oembed:assets/field-oembed.tag',
      'field-oembed:assets/oembed-renderer.js'
      ]);
});
