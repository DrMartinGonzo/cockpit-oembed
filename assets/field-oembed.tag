<field-oembed>
  <style>
    [ref='thumbnail_url'] {
      height: 150px;
      /* width: 100%; */
      /* object-fit: cover; */
    }
  </style>

  <!--  Nothing fetched yet  -->
  <div class="uk-placeholder uk-text-center uk-text-muted" if="{!embedData.url}">
    <!--  Icon + link to enter oEmbed URL  -->
    <div if="{ !loading }">
      <img
        class="uk-svg-adjust"
        riot-src="{ App.base('/assets/app/media/icons/assets.svg') }"
        width="100"
        data-uk-svg
      />
      <p>{ App.i18n.get('No oEmbed URL') }. <a onclick="{ setUrl }">{ App.i18n.get('Enter one') }</a></p>
    </div>

    <!--  Loading indicator  -->
    <div if="{ loading }" class="uk-position-relative">
      <i class="uk-icon-spinner uk-icon-spin uk-position-center"></i>
      <canvas width="160" height="160"></canvas>
    </div>
  </div>

  <div class="uk-panel uk-panel-box uk-padding-remove uk-panel-card" if="{embedData.url}">
    <!--  Thumbnail Image or Icon  -->
    <div class="uk-overlay uk-display-block uk-position-relative uk-bg-transparent-pattern">
      <canvas class="uk-responsive-width" width="200" height="150"></canvas>
      <div class="uk-position-absolute uk-position-cover uk-flex uk-flex-middle">
        <div class="uk-width-1-1 uk-text-center">
          <!--  TODO  -->
          <span if="{ !embedData.thumbnail_url }"
            ><i class="uk-h1 uk-text-muted uk-icon-{ getIconCls(embedData.type) }"></i
          ></span>

          <a
            href="{ embedData.thumbnail_url }"
            data-uk-lightbox="type:'image'"
            title="{ embedData.thumbnail_width && [embedData.thumbnail_width, embedData.thumbnail_height].join('x') }"
          >
            <img ref="thumbnail_url" src="{ embedData.thumbnail_url }" />
          </a>
        </div>
      </div>
    </div>

    <div class="uk-panel-body">
      <!--  Embedded Content Info  -->
      <div class="uk-margin-small-top uk-text-truncate">
        <a href="{ embedData.url }" target="_blank">{ embedData.title }</a>
      </div>
      <div class="uk-text-small uk-text-muted">
        <strong>{ embedData.provider_name }</strong>
        | { embedData.type }
      </div>

      <!--  Actions  -->
      <div class="uk-margin-top">
        <a class="uk-button uk-button-small uk-margin-small-right" onclick="{ setUrl }">{ App.i18n.get('Replace') }</a>

        <span class="uk-button-group">
          <a class="uk-button uk-button-small" onclick="{ editMeta }"><i class="uk-icon-pencil"></i></a>
          <a class="uk-button uk-button-small uk-text-danger" onclick="{ reset }"><i class="uk-icon-trash-o"></i></a>
        </span>
      </div>
    </div>
  </div>

  <!--  Edit Embedded content title and description Modal  -->
  <div class="uk-modal uk-sortable-nodrag" ref="modalmeta">
    <div class="uk-modal-dialog">
      <div class="uk-modal-header"><h3>{ App.i18n.get('oEmbed Meta') }</h3></div>

      <div class="uk-grid-margin uk-width-medium-{field.width}" each="{field, name in _meta}" no-reorder>
        <div class="uk-panel">
          <label class="uk-text-small uk-text-bold">
            <i class="uk-icon-pencil-square uk-margin-small-right"></i> { field.label || name }
          </label>

          <div class="uk-margin">
            <cp-field type="{ field.type || 'text' }" bind="embedData['{name}']"></cp-field>
          </div>
        </div>
      </div>

      <div class="uk-modal-footer uk-text-right">
        <button class="uk-button uk-button-large uk-button-link uk-modal-close">{ App.i18n.get('Close') }</button>
      </div>
    </div>
  </div>

  <script>
    riot.util.bind(this);

    const _default = {
      title: '',
      url: '',
      thumbnail_url: '',
      provider_name: '',
    };

    this.loading = false;
    this.embedData = Object.create(_default);

    this.$updateValue = function(value, field) {
      value = value || Object.create(_default);

      if (value && !value.url) {
        return this.$setValue(Object.create(_default));
      }

      if (JSON.stringify(this.embedData) !== JSON.stringify(value)) {
        this.embedData = value;
        return this.update();
      }
    }.bind(this);

    this.fetchdata = url => {
      if (url) {
        this.loading = true;
        this.update();

        const fetchUrl = `https://noembed.com/embed?url=${encodeURI(url)}`;
        fetch(fetchUrl)
          .then(response => {
            response
              .json()
              .then(data => {
                if (!data.error) {
                  this.$setValue(data);
                } else {
                  App.ui.notify(data.error, 'danger');
                }
              })
              .catch(err => {
                console.error(err);
                App.ui.notify(`[Failed to parse JSON in response]`, 'danger');
              });
          })
          .catch(err => {
            console.error(err);
            App.ui.notify(`[Failed to fetch]: ${fetchUrl}`, 'danger');
          })
          .finally(() => {
            this.loading = false;
            this.update();
          });
      }
    };

    this.getIconCls = type => {
      switch (type) {
        case 'photo':
          return 'image';
          break;
        case 'video':
          return 'video-camera';
          break;
        case 'link':
          return 'link';
          break;
        case 'rich':
          return 'paperclip';
          break;

        default:
          return 'paperclip';
          break;
      }
    };

    this.setUrl = () => App.ui.prompt('oEmbed Url', '', url => this.fetchdata(url));

    this.editMeta = () => {
      this._meta = {
        title: {
          type: 'text',
          label: App.i18n.get('Title'),
        },
        description: {
          type: 'textarea',
          label: App.i18n.get('Description'),
        },
      };

      setTimeout(() => {
        UIkit.modal(this.refs.modalmeta, { modal: false })
          .show()
          .one('hide.uk.modal', () => (this._meta = null));
      }, 50);
    };

    this.reset = () => {
      this.embedData = Object.create(_default);
      this.$setValue(this.embedData);
    };
  </script>
</field-oembed>
