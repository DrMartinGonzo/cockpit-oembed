App.Utils.renderer.oembed = function(v) {
  if (v) {
    const title = v.title ? App.Utils.renderer.default(v.title) : '';
    let details = title;

    if (v.provider_name) {
      // prettier-ignore
      details = `<span class="uk-badge uk-badge-outline uk-margin-small-right">${v.provider_name}</span> ${details}`;
    }

    if (v.thumbnail_url) {
      // prettier-ignore
      return `
        <a href="${v.thumbnail_url}" class="uk-margin-small-right" data-uk-lightbox title="${App.i18n.get('Preview')} ${title}" >
          <i class="uk-icon-image"></i>
        </a>
        ${details}`;
    } else {
      return details;
    }
  }

  return App.Utils.renderer.default(v);
};
