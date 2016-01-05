# Json_ml [![NPM version][npm-image]][npm] [![Build Status][travis-image]][travis] [![Coverage Status][coveralls-image]][coveralls]
[![Sauce Test Status][sauce-image]][sauce]

> JsonML parse/stringify function

## Installation
### Via npm
```bash
$ npm install json_ml --save
```
```js
var JsonML= require('json_ml');
console.log(JsonML); //object
```

### Via bower
```bash
$ bower install json_ml --save
```
```html
<script src="bower_components/json_ml/json_ml.min.js"></script>
<script>
  console.log(JsonML); //object
</script>
```

### Via rawgit.com (the simple way)

```html
<script src="https://cdn.rawgit.com/59naga/json-ml/v0.0.2/json_ml.min.js"></script>
<script>
  console.log(JsonML); //object
</script>
```

## API

> See: http://www.jsonml.org/

### `JsonML.parse(html, trim=true)` -> [Element,Element,...]

Convert `HTML string` to `JsonML Elements`.

```js
JsonML.parse('<ul><li style="color:red">First Item</li><li title="Some hover text." style="color:green">Second Item</li><li><span class="code-example-third">Third</span>Item</li></ul>');
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

### `JsonML.stringify(object, replacer, indent)` -> HTML

Convert `JsonML Elements` to `HTML string`.

```js
JsonML.stringify([['ul',['li',{style:"color:red"}],['li',{title:"Some hover text.",style:"color:green"}],['li',['span',{class:'code-example-third'}]]]],null,2);
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

[sauce-image]: http://soysauce.berabou.me/u/59798/json_ml.svg
[sauce]: https://saucelabs.com/u/59798
[npm-image]:https://img.shields.io/npm/v/json_ml.svg?style=flat-square
[npm]: https://npmjs.org/package/json_ml
[travis-image]: http://img.shields.io/travis/59naga/json-ml.svg?style=flat-square
[travis]: https://travis-ci.org/59naga/json-ml
[coveralls-image]: http://img.shields.io/coveralls/59naga/json-ml.svg?style=flat-square
[coveralls]: https://coveralls.io/r/59naga/json-ml?branch=master
