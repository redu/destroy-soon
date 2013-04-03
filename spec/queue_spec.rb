require 'spec_helper'

module DestroySoon
  describe Queue do
    after do
      Delayed::Job.destroy_all
    end
    before(:all) do
      class User < ActiveRecord::Base
        include DestroySoon::ModelAdditions
      end
    end
    let(:user) do
      User.create(:name => "call me susy")
    end
    let(:job) do
      Job.new(:entity => user)
    end
    let(:subject) do
      Queue.new
    end

    context ".new" do
      it "should accept a :queue_name" do
        job = mock('Job')
        Delayed::Job.should_receive(:enqueue).with(job, {:queue => 'foobar'})
        Queue.new(:queue_name => 'foobar').enqueue(job)
      end

      it "should default to .default_queue" do
        Queue.default_queue = 'general'

        job = mock('Job')
        Delayed::Job.should_receive(:enqueue).with(job, {:queue => 'general'})
        Queue.new.enqueue(job)

        Queue.default_queue = nil
      end
    end

    it "should enqueue the job" do
      Delayed::Job.should_receive(:enqueue).with(job)
      subject.enqueue(job)
    end

    it "should enqueue the job on the configured queue" do
      Queue.default_queue = "general"
      Delayed::Job.should_receive(:enqueue).with(job, :queue => "general")
      subject.enqueue(job)
      Queue.default_queue = nil
    end

    it "should call destroy after all" do
      User.any_instance.should_receive(:destroy).once
      subject.enqueue(job)
    end

    it "should return the job" do
      subject.enqueue(job).should be_a Delayed::Job
    end
  end
end
