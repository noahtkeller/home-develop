const { join } = require('path');

module.exports = {
  outputDir: join(__dirname, '../../../github-io'),
  lintOnSave: false,
  publicPath: '/',
};
