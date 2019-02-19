# oEmbed Field for [Cockpit](https://github.com/agentejo/cockpit)

Uses noembed api https://noembed.com/.  
This is mostly untested, I just needed a quick solution. Feel free to improve !

![Preview](preview.png)

You can customize title and description using cog button.

sample response :
```json
{
  "embed": {
    "html": "\n<iframe width=\" 480\" height=\"270\" src=\"https://www.youtube.com/embed/L-eS-b6pTSQ?feature=oembed\" frameborder=\"0\" allowfullscreen=\"allowfullscreen\"></iframe>\n",
    "version": "1.0",
    "thumbnail_url": "https://i.ytimg.com/vi/L-eS-b6pTSQ/hqdefault.jpg",
    "height": 270,
    "thumbnail_width": 480,
    "author_name": "The Forge Network HQ",
    "title": "The Elder Scrolls 'Legends of Tamriel' (Music Compilation) (Morrowind, Oblivion & Skyrim)",
    "url": "https://www.youtube.com/watch?v=L-eS-b6pTSQ",
    "provider_name": "YouTube",
    "width": 480,
    "thumbnail_height": 360,
    "provider_url": "https://www.youtube.com/",
    "type": "video",
    "author_url": "https://www.youtube.com/channel/UCEHl8n2UVNc8ZWuhwwF8Ukg",
    "description": "La description"
  }
}
```

## Installation

```
$ cd cockpit/modules/addons
$ git clone git@github.com:DrMartinGonzo/field-oembed.git
```

_Note: Directory must be named **field-oembed** for Cockpit to register addon._
