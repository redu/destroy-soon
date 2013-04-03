require 'active_support/core_ext'

module DestroySoon
  class Queue
    cattr_accessor :default_queue

    def initialize(options={})
      @queue = default_queue || options[:queue_name]
    end

    def enqueue(job)
      args = [job]
      args << { :queue => @queue } if @queue

      Delayed::Job.enqueue(*args)
    end
  end
end
