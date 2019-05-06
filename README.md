# puppet-module-phantomjs

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/phantomjs.svg)](https://forge.puppetlabs.com/treydock/phantomjs)
[![Build Status](https://travis-ci.org/treydock/puppet-module-phantomjs.png)](https://travis-ci.org/treydock/puppet-module-phantomjs)

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options](#usage)
3. [Reference - Parameter and detailed reference to all options](#reference)
4. [Development - Guide for contributing to the module](#development)

## Overview

This module installs phantomjs binary for Linux systems.

## Usage

### phantomjs

Install PhantomJS 2.1.1 to /usr/local/bin/phantomjs

    class { 'phantomjs': }

Install specific version of PhantomJS

    class { 'phantomjs':
      version => '1.9.8',
    }

## Reference

### Classes

#### Public classes

* `phantomjs`: Installs and configures phantomjs.

### Parameters

#### phantomjs

##### `version`

Version of PhantomJS to install. Default is `2.1.1`

##### `source_url`

Optional URL for PhantomJS download.

##### `path`

The path to phantomjs binary. Default is `/usr/local/bin/phantomjs`

## Development

### Testing

Testing requires the following dependencies:

* rake
* bundler

Install gem dependencies

    bundle install

Run unit tests

    bundle exec rake release_checks

If you have Vagrant >= 1.2.0 installed you can run system tests

    bundle exec rake beaker
