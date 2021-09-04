# frozen_string_literal: true

module RSpecTracer
  class MarshalSerializer < Serializer
    ENCODING = Encoding::BINARY
    EXTENSION = 'dump'

    class << self
      def serialize(object)
        # original_defaults = object.map { |obj| obj.default if obj.respond_to?(:default) }
        # object.each { |obj| obj.default = nil if obj.respond_to?(:default=) }
        object_copy = deep_symbolize_keys(object) if object.is_a? Hash
        # binding.pry
        Marshal.dump(object_copy)
        # object.each_with_iondex { |obj, idx| obj.default = original_defaults[idx] if obj.respond_to?(:default=) && original_defaults[idx].present? }
        # dump
      end

      def deserialize(input)
        object = Marshal.load(input)
        if object.is_a? Hash
          deep_stringify_keys(object)
        else
          object
        end
      end

      def deep_symbolize_keys(object)
        object_copy = object.transform_keys { |key| key.is_a?(String) ? key.to_sym : key }
        object_copy.transform_values! do |value|
          value.is_a?(Hash) ? deep_symbolize_keys(value) : value
        end
        object_copy
      end

      def deep_stringify_keys(object)
        object_copy = object.transform_keys { |key| key.is_a?(Symbol) ? key.to_s : key }
        object_copy.transform_values! do |value|
          value.is_a?(Hash) ? deep_stringify_keys(value) : value
        end
        object_copy
      end
    end
  end
end
