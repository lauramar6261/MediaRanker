require "test_helper"

describe WorksController do
  it "should get index" do
    get works_index_url
    value(response).must_be :success?
  end

  it "should get delete" do
    get works_delete_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get works_edit_url
    value(response).must_be :success?
  end

  it "should get show" do
    get works_show_url
    value(response).must_be :success?
  end

  it "should get update" do
    get works_update_url
    value(response).must_be :success?
  end

  it "should get upvote" do
    get works_upvote_url
    value(response).must_be :success?
  end

end
