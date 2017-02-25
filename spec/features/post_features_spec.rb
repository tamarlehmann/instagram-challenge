require 'rails_helper'

feature 'posts' do

  # let(:post_description) { "I love the sun" }
  # let(:post_image) { File.new('spec/photo1.jpg') }

  context 'no posts have been added' do
    scenario 'should display a link to add a post' do
      visit '/posts'
      expect(page).to have_link 'Create a post'
    end

    scenario 'display a message that there are no posts' do
      visit '/posts'
      expect(page).to have_content 'There are no posts yet!'
    end
  end

  context 'posts have been added' do
    before do
      create_post
    end

    scenario 'displaying posts' do
      expect(page).to have_css 'img'
      expect(page).to have_content 'I love the sun'
      expect(page).not_to have_content 'There are no posts yet!'
      expect(current_path).to eq '/posts'
    end
  end

  context 'posts have been deleted' do
    before do
      create_post
    end

    scenario 'removes a post when a user clicks a delete link' do
      visit '/posts'
      click_link 'Delete'
      expect(page).not_to have_content 'I love the sun'
      expect(page).to have_content 'Post deleted successfully'
    end
  end

end
