# @zeekay/rollup-plugin-stylus

[![Build Status](https://travis-ci.org/zeekay/rollup-plugin-stylus.svg?branch=master)](https://travis-ci.org/zeekay/rollup-plugin-stylus)

A Rollup.js plugin to compile Stylus.

## Install

```bash
npm install @zeekay/rollup-plugin-stylus --save-dev
```

## Usage

Add the following code to your project's `rollup.config.js`:

```js
import stylus from '@zeekay/rollup-plugin-stylus';

export default {
  entry: 'index.js',
  plugins: [
    stylus({
      plugins: [],
    })
  ]
};
```

## License

MIT
