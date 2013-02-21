require 'spec_helper'

describe Searchlogic::ActiveRecordExt::Scopes::Conditions::DoesNotEqual do 
  before(:each) do 
    @james = User.create(:name => "James")
    @bob = User.create(:name => "Bob")
  end

  it "finds users that do not equal input" do 
    find_bob = User.name_does_not_equal("James").first
    find_bob.name.should eq("Bob")
  end
end