App.Utils.renderer.oembed = function(v) {
  if (v && v.provider_name && v.url) {
    return `
      <a class="uk-badge uk-badge-outline"
         href="${v.url}"
         title="${v.title}"
         target="_blank"
         data-uk-tooltip
      >${v.provider_name}</a>`;
  }
  return App.Utils.renderer.default(v);
};
