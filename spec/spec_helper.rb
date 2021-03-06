# -*- coding: utf-8 -*-

unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
    add_group 'Agharta' do |source|
      source.filename =~ /lib\/agharta(|\/[^\/]+).rb/
    end
    add_group 'Executes',   'lib/agharta/executes'
    add_group 'Handlers' do |source|
      source.filename =~ /lib\/agharta\/handlers/ ||
        source.filename =~ /lib\/agharta\/notifies/ ||
        source.filename =~ /lib\/agharta\/stores/
    end
    add_group 'Hooks',     'lib/agharta/hooks'
    add_group 'Extension', 'lib/agharta/core_ext'
  end
end

require 'agharta'
require 'rspec'

class DummyRecipe
  include Agharta::Configuration
  include Agharta::Executable
  include Agharta::Executes
end

class DummyExecutable
  include Agharta::Executable
  include Agharta::Hooks
end

class DummyHook
  include Agharta::Hookable

  def call(status)
    invoke(status)
  end
end

class DummyHandler
  include Agharta::Handleable

  def initialize(context, *args, &block)
  end

  def call(status, options = {})
  end
end

RSpec.configure do |config|
  config.mock_with :rspec
end
