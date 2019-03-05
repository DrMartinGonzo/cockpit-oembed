!function(e){var t={};function i(a){if(t[a])return t[a].exports;var n=t[a]={i:a,l:!1,exports:{}};return e[a].call(n.exports,n,n.exports,i),n.l=!0,n.exports}i.m=e,i.c=t,i.d=function(e,t,a){i.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:a})},i.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},i.t=function(e,t){if(1&t&&(e=i(e)),8&t)return e;if(4&t&&"object"==typeof e&&e&&e.__esModule)return e;var a=Object.create(null);if(i.r(a),Object.defineProperty(a,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var n in e)i.d(a,n,function(t){return e[t]}.bind(null,n));return a},i.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return i.d(t,"a",t),t},i.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},i.p="",i(i.s=0)}([function(e,t,i){"use strict";i.r(t);i(1),i(3)},function(e,t,i){var a=i(2);a.tag2("field-oembed",'<div class="uk-placeholder uk-text-center uk-text-muted" if="{!embedData.url}"> <div if="{!loading}"> <img class="uk-svg-adjust" riot-src="{App.base(\'/assets/app/media/icons/assets.svg\')}" width="100" data-uk-svg> <p>{App.i18n.get(\'No oEmbed URL\')}. <a onclick="{setUrl}">{App.i18n.get(\'Enter one\')}</a></p> </div> <div if="{loading}" class="uk-position-relative"> <i class="uk-icon-spinner uk-icon-spin uk-position-center"></i> <canvas width="160" height="160"></canvas> </div> </div> <div class="uk-panel uk-panel-box uk-padding-remove uk-panel-card" if="{embedData.url}"> <div class="uk-overlay uk-display-block uk-position-relative uk-bg-transparent-pattern"> <canvas class="uk-responsive-width" width="200" height="150"></canvas> <div class="uk-position-absolute uk-position-cover uk-flex uk-flex-middle"> <div class="uk-width-1-1 uk-text-center"> <span if="{!embedData.thumbnail_url}"><i class="uk-h1 uk-text-muted uk-icon-{getIconCls(embedData.type)}"></i ></span> <a href="{embedData.thumbnail_url}" data-uk-lightbox="type:\'image\'" title="{embedData.thumbnail_width && [embedData.thumbnail_width, embedData.thumbnail_height].join(\'x\')}"> <img ref="thumbnail_url" riot-src="{embedData.thumbnail_url}"> </a> </div> </div> </div> <div class="uk-panel-body"> <div class="uk-margin-small-top uk-text-truncate"> <a href="{embedData.url}" target="_blank">{embedData.title}</a> </div> <div class="uk-text-small uk-text-muted"> <strong>{embedData.provider_name}</strong> | {embedData.type} </div> <div class="uk-margin-top"> <a class="uk-button uk-button-small uk-margin-small-right" onclick="{setUrl}">{App.i18n.get(\'Replace\')}</a> <span class="uk-button-group"> <a class="uk-button uk-button-small" onclick="{editMeta}"><i class="uk-icon-pencil"></i></a> <a class="uk-button uk-button-small uk-text-danger" onclick="{reset}"><i class="uk-icon-trash-o"></i></a> </span> </div> </div> </div> <div class="uk-modal uk-sortable-nodrag" ref="modalmeta"> <div class="uk-modal-dialog"> <div class="uk-modal-header"><h3>{App.i18n.get(\'oEmbed Meta\')}</h3></div> <div class="uk-grid-margin uk-width-medium-{field.width}" each="{field, name in _meta}" no-reorder> <div class="uk-panel"> <label class="uk-text-small uk-text-bold"> <i class="uk-icon-pencil-square uk-margin-small-right"></i> {field.label || name} </label> <div class="uk-margin"> <cp-field type="{field.type || \'text\'}" bind="embedData[\'{name}\']"></cp-field> </div> </div> </div> <div class="uk-modal-footer uk-text-right"> <button class="uk-button uk-button-large uk-button-link uk-modal-close">{App.i18n.get(\'Close\')}</button> </div> </div> </div>',"field-oembed [ref='thumbnail_url'],[data-is=\"field-oembed\"] [ref='thumbnail_url']{ height: 150px; }","",function(e){a.util.bind(this);const t={title:"",url:"",thumbnail_url:"",provider_name:""};this.loading=!1,this.embedData=Object.create(t),this.$updateValue=((e,i)=>(e=e||Object.create(t))&&!e.url?this.$setValue(Object.create(t)):JSON.stringify(this.embedData)!==JSON.stringify(e)?(this.embedData=e,this.update()):void 0),this.fetchdata=(e=>{if(e){this.loading=!0,this.update();const t=`https://noembed.com/embed?url=${encodeURI(e)}`;fetch(t).then(e=>{e.json().then(e=>{e.error?App.ui.notify(e.error,"danger"):this.$setValue(e)}).catch(e=>{console.error(e),App.ui.notify("[Failed to parse JSON in response]","danger")})}).catch(e=>{console.error(e),App.ui.notify(`[Failed to fetch]: ${t}`,"danger")}).finally(()=>{this.loading=!1,this.update()})}}),this.getIconCls=(e=>{switch(e){case"photo":return"image";case"video":return"video-camera";case"link":return"link";case"rich":default:return"paperclip"}}),this.setUrl=(()=>App.ui.prompt("oEmbed Url","",e=>this.fetchdata(e))),this.editMeta=(()=>{this._meta={title:{type:"text",label:App.i18n.get("Title")},description:{type:"textarea",label:App.i18n.get("Description")}},setTimeout(()=>{UIkit.modal(this.refs.modalmeta,{modal:!1}).show().one("hide.uk.modal",()=>this._meta=null)},50)}),this.reset=(()=>{this.embedData=Object.create(t),this.$setValue(this.embedData)})})},function(e,t){e.exports=riot},function(e,t){App.Utils.renderer.oembed=function(e){if(e){const t=e.title?App.Utils.renderer.default(e.title):"";let i=t;return e.provider_name&&(i=`<span class="uk-badge uk-badge-outline uk-margin-small-right">${e.provider_name}</span> ${i}`),e.thumbnail_url?`\n        <a href="${e.thumbnail_url}" class="uk-margin-small-right" data-uk-lightbox title="${App.i18n.get("Preview")} ${t}" >\n          <i class="uk-icon-image"></i>\n        </a>\n        ${i}`:i}return App.Utils.renderer.default(e)}}]);