# -*- coding: utf-8 -*-

require 'faraday'
require 'multi_xml'
require 'yajl'

module Agharta
  module Connection
    module Response
      class ParseJson < Faraday::Response::Middleware
        Faraday.register_middleware :response, :json => lambda { self }

        def on_complete(env)
          env[:body] = parse_body(env[:body])
        end

        def parse_body(body)
          if body.nil?
            nil
          else
            Yajl.load(body)
          end
        end
      end

      class ParseXml < Faraday::Response::Middleware
        Faraday.register_middleware :response, :xml => lambda { self }

        def on_complete(env)
          env[:body] = parse_body(env[:body])
        end

        def parse_body(body)
          if body.nil?
            nil
          else
            MultiXml.parse(body)
          end
        end
      end
    end
  end
end
