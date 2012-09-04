require 'active_support/core_ext'

module DestroySoon
  class Queue
    DEFAULT_QUEUE = nil
    cattr_accessor :default_queue

    def initializer
      @default_queue = default_queue || DEFAULT_QUEUE
    end

    def enqueue(job)
      args = [job]
      args << { :queue => default_queue } if default_queue

      Delayed::Job.enqueue(*args)
    end
  end
end
