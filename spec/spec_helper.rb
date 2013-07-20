PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require 'simplecov'
SimpleCov.command_name 'spec'

require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  DataMapper.setup(:default, "abstract::")
  DataMapper::Logger.new($stdout, :all)
end

def app
  JobVacancy::App.tap { |app|  }
end
