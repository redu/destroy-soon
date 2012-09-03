module DestroySoon
  class Job
    attr_accessor :entity_klass, :entity_id
    def initialize(opts)
      @entity_id = opts[:entity].id
      @entity_klass = opts[:entity].class.to_s
    end

    def perform
      entity.try(:destroy)
    end

    def entity
      entity_klass.constantize.find_by_id(entity_id)
    end
  end
end
