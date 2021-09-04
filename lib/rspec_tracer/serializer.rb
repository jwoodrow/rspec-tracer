# frozen_string_literal: true

module RSpecTracer
  class Serializer
    ENCODING = nil
    EXTENSION = nil

    class << self
      def serialize(object)
        raise NotImplementedError.new('You must implement serialize.')
      end

      def deserialize(input)
        raise NotImplementedError.new('You must implement deserialize.')
      end
    end
  end
end

require_relative 'serializers/json_serializer'
require_relative 'serializers/marshal_serializer'
require_relative 'serializers/message_pack_serializer'
