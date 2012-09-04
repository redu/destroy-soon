require 'spec_helper'

module DestroySoon
  describe ModelAdditions do
    before(:all) do
      class User < ActiveRecord::Base
        include DestroySoon::ModelAdditions
      end
    end
    after do
      Delayed::Job.destroy_all
    end
    let(:subject) do
      User.create(:name => "Call me susy")
    end

    it "should have a marked_for_destruction attr" do
      User.new.should respond_to :destroy_soon?
    end
    it "should respond to delayed destroy" do
      subject.should respond_to :async_destroy
    end
    it "should set destroy_soon to true when trying to destroy" do
      expect {
        subject.async_destroy
      }.to change(subject, :destroy_soon?)
    end
    it "should delay the destruction" do
      Queue.any_instance.should_receive(:enqueue)
      subject.async_destroy
    end
    it "should not be enqueued again if it's going to be destroyed" do
      Queue.any_instance.should_receive(:enqueue).once
      2.times { subject.async_destroy }
    end
    it "should scope by visibility" do
      subject.async_destroy
      User.will_not_be_destroyed.should_not include subject
    end
  end
end
