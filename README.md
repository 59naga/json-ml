# Json_ml [![NPM version][npm-image]][npm] [![Build Status][travis-image]][travis] [![Coverage Status][coveralls-image]][coveralls]
[![Sauce Test Status][sauce-image]][sauce]

> JsonML parse/stringify library

## Installation
### Via npm
```bash
$ npm install json_ml --save
```
```js
var JSONML= require('json_ml');
console.log(JSONML); //function
```

### Via bower
```bash
$ bower install json_ml --save
```
```html
<script src="bower_components/json_ml/json_ml.min.js"></script>
<script>
  console.log(JSONML); //function
</script>
```

## API

> See: http://www.jsonml.org/

### `JSONML.parse(html, trim=true)`

Convert `HTML string` to `JsonML object`.

```js
JSONML.parse('<ul><li style="color:red">First Item</li><li title="Some hover text." style="color:green">Second Item</li><li><span class="code-example-third">Third</span>Item</li></ul>');
//[
//  [
//    "ul",
//    [
//      "li",
//      {
//        "style": "color:red"
//      }
//    ],
//    [
//      "li",
//      {
//        "title": "Some hover text.",
//        "style": "color:green"
//      }
//    ],
//    [
//      "li",
//      [
//        "span",
//        {
//          "class": "code-example-third"
//        }
//      ]
//    ]
//  ]
//]
```

### `JSONML.stringify(object, replacer, indent)`

Convert `JsonML object` to `HTML string`.

```js
JSONML.stringify([['ul',['li',{style:"color:red"}],['li',{title:"Some hover text.",style:"color:green"}],['li',['span',{class:'code-example-third'}]]]],null,2);
//<ul>
//  <li style="color:red"></li>
//  <li title="Some hover text." style="color:green"></li>
//  <li><span class="code-example-third"></span></li>
//</ul>
```

License
---
[MIT][License]

[License]: http://59naga.mit-license.org/

[sauce-image]: http://soysauce.berabou.me/59naga/json-ml.svg
[sauce]: https://saucelabs.com/u/59798
[npm-image]:https://img.shields.io/npm/v/json_ml.svg?style=flat-square
[npm]: https://npmjs.org/package/json_ml
[travis-image]: http://img.shields.io/travis/59naga/json-ml.svg?style=flat-square
[travis]: https://travis-ci.org/59naga/json-ml
[coveralls-image]: http://img.shields.io/coveralls/59naga/json-ml.svg?style=flat-square
[coveralls]: https://coveralls.io/r/59naga/json-ml?branch=master
