<field-oembed>

  <style>
    [ref="thumbnail_url"] {
      height: 160px;
    }
  </style>


  <div class="uk-display-block uk-panel uk-panel-box uk-panel-card uk-padding-remove">
    <div class="uk-flex uk-flex-middle uk-flex-center uk-text-muted">
      <!--  Thumbnail Image  -->
      <div class="uk-width-1-1 uk-text-center uk-bg-transparent-pattern" show="{ embedData.thumbnail_url }">
        <img ref="thumbnail_url" src="{ embedData.thumbnail_url }" />
      </div>

      <!--  Nothing fetched yet menu  -->
      <div class="uk-text-center uk-margin-top uk-margin-bottom" show="{ !embedData.url }">
        <a onclick="{ editUrl }">
          <img
            class="uk-svg-adjust uk-text-muted"
            riot-src="{App.base('/assets/app/media/icons/import.svg')}"
            width="60"
            height="60"
            data-uk-svg
          />
          <div class="uk-margin-top">
            <span class="uk-button uk-button-link">{ App.i18n.get('Enter oEmbed Url') }</span>
          </div>
        </a>
      </div>
    </div>

    <div class="uk-panel-body" show="{ embedData.url }">
      <ul class="uk-grid uk-grid-small uk-flex-center ">
        <li>
          <a class="uk-text-muted" onclick="{ editUrl }" title="{ App.i18n.get('Enter Embed Url') }" data-uk-tooltip
            ><i class="uk-icon-link"></i
          ></a>
        </li>
        <li>
          <a class="uk-text-muted" onclick="{ showMeta }" title="{ App.i18n.get('Edit meta data') }" data-uk-tooltip
            ><i class="uk-icon-cog"></i
          ></a>
        </li>
        <li>
          <a class="uk-text-danger" onclick="{ remove }" title="{ App.i18n.get('Reset') }" data-uk-tooltip
            ><i class="uk-icon-trash-o"></i
          ></a>
        </li>
      </ul>

      <br />

      <!--  Embedded content info  -->
      <a show="{ embedData.title }" href="{ embedData.url }" target="_blank">{ embedData.title }</a>
      <div class="uk-text-muted" show="{ embedData.provider_name }">
        <i class="uk-icon-cloud"></i> { embedData.provider_name }
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

    const _that = this;
    const _default = {
      title: '',
      url: '',
      thumbnail_url: '',
      provider_name: '',
    };

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

    this.fetchdata = function(url) {
      if (url) {
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
          });
      }
    };

    this.editUrl = function() {
      App.ui.prompt('Embed Url', undefined, function(url) {
        _that.fetchdata(url);
      });
    };

    this.showMeta = function() {
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
          console.log(UIkit.modal);
        UIkit.modal(this.refs.modalmeta, { modal: false })
          .show()
          .one('close.uk.modal', () => {
            this._meta = null;
          });
      }, 50);
    };

    this.remove = function() {
      this.embedData = Object.create(_default);
      this.$setValue(this.embedData);
    };
  </script>

</field-oembed>
