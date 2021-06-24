require 'bundler'
require 'yaml'
require 'securerandom'

Bundler.require(:default)

World(PageObject::PageFactory)
