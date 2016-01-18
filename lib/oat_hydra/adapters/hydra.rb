# http://www.hydra-cg.com/spec/latest/core/

module Oat
  module Adapters

    class Hydra < Oat::Adapter

      def initialize(*args)
        super
        @entities = {}
        @meta = {}
      end

      def rel(rels)
        # no-op to maintain interface compatibility with the Siren adapter
      end

      def type(*types)
        data['@type'] = types.first.to_s.to_sym
      end

      def link(rel, opts = {})
        check_link_keys(opts)
        if rel == :self
          self_link(opts)
        end
      end

      def check_link_keys(opts)
        unsupported_opts = opts.keys - [:href, :id, :type]

        unless unsupported_opts.empty?
          raise ArgumentError, "Unsupported opts: #{unsupported_opts.join(", ")}"
        end
      end
      private :check_link_keys

      def properties(&block)
        data.merge! yield_props(&block)
      end

      def property(key, value)
        data[key] = value
      end

      def meta(key, value)
        # no-op to maintain interface compatibility
      end

      def entity(name, obj, serializer_class = nil, context_options = {}, &block)
        entity_serializer = serializer_from_block_or_class(obj, serializer_class, context_options, &block)
        data[entity_name(name)] = entity_serializer ? entity_serializer.to_hash : nil
      end

      def entities(name, collection, serializer_class = nil, context_options = {}, &block)
        data[entity_name(name)] = collection.map do |obj|
          entity_serializer = serializer_from_block_or_class(obj, serializer_class, context_options, &block)
          entity_serializer ? entity_serializer.to_hash : nil
        end
      end

      def entity_name(name)
        # Entity name may be an array, but Hydra only uses the first
        name.respond_to?(:first) ? name.first : name
      end
      private :entity_name

      def collection(name, collection, serializer_class = nil, context_options = {}, &block)
        @treat_as_resource_collection = true
        data[:resource_collection] = [] unless data[:resource_collection].is_a?(Array)

        collection.each do |obj|
          ent = serializer_from_block_or_class(obj, serializer_class, context_options, &block)
          data[:resource_collection] << ent.to_hash if ent
        end
      end

      def to_hash
        if serializer.top != serializer
          return data
        else
          h = {}
          if @treat_as_resource_collection
            h[:'@id'] = data['@id']
            h[:'@type'] = "Collection"
            h[:totalItems] = data[:resource_collection].size
            h[:member] = data[:resource_collection]
          else
            h = [data]
          end
          return h
        end
      end

      protected

      def self_link(opts)
        data['@id'] = opts[:href]
      end

    end
  end
end
