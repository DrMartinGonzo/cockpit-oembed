<?php

$app->on('admin.init', function() use($app){

  $this->helper('admin')->addAssets('field-oembed:assets/components/field-oembed.tag');

});
