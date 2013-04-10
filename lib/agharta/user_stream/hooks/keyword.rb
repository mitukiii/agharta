# -*- coding: utf-8 -*-

require 'agharta/user_stream/hooks/hook'

module Agharta
  module UserStream
    module Hooks
      class Keyword < Hook
        def initialize(context, *args, &block)
          options = args.last.is_a?(Hash) ? args.pop : {}
          @include = args
          @exclude = options.fetch(:exclude, [])
          @ignore_self = options.fetch(:ignore_self, false)
          super
        end

        def call(status)
          return unless status[:text]
          return unless status[:user]
          return if @ignore_self && current_user?(status[:user][:screen_name])
          return unless @include.flatten.any? { |k| status[:text].match(k) }
          keyword = $&.to_s
          return if @exclude.flatten.any? { |k| status[:text].match(k) }
          invoke(status, :type => :keyword, :keyword => keyword)
        end

        def include(*keywords)
          @include.concat(keywords)
        end

        def exclude(*keywords)
          @exclude.concat(keywords)
        end

        def ignore_self!
          @ignore_self = true
        end
      end
    end
  end
end
