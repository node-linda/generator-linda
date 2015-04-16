'use strict';

var yeoman = require('yeoman-generator');

module.exports = yeoman.generators.Base.extend({
  getDefaultOwner: function(){
    var user, mail;

    if (typeof(this.user.git.name) == 'function') {
      user = this.user.git.name();
    } else {
      user = this.user.git.name;
    }

    if (typeof(this.user.git.email) == 'function') {
      mail = this.user.git.email();
    } else {
      mail = this.user.git.email;
    }

    if (user && mail) {
      return user+' <'+mail+'>';
    } else {
      return "User <user@example.com>";
    }
  },
  constructor: function(){
    yeoman.generators.Base.apply(this, arguments);
    this.log('generate linda-worker template');
  },
  prompting: {
    askFor: function(){
      var done = this.async();
      this.prompt([
        {
          name: 'appName',
          message: 'App Name',
          default: 'linda-worker'
        },
        {
          name: 'owner',
          message: 'Owner',
          default: this.getDefaultOwner()
        },
        {
          name: 'lindaServer',
          message: 'Linda Server',
          default: 'https://linda-server.herokuapp.com'
        }
      ], function(res){
        this.owner = res.owner;
        this.appName = res.appName;
        this.lindaServer = res.lindaServer;
        done();
      }.bind(this));
    }
  },
  writing: {
    app: function(){
      this.template('_package.json', 'package.json');
      this.template('README.md', 'README.md');
      this.template('config.json', 'config.json');
      this.copy('Procfile', 'Procfile');
      this.copy('Gruntfile.coffee', 'Gruntfile.coffee');
      this.copy('gitignore', '.gitignore');
      this.directory('bin', 'bin');
      this.directory('scripts', 'scripts');
      this.directory('libs', 'libs');
    }
  },
  end: function(){
    this.npmInstall();
  }
});
