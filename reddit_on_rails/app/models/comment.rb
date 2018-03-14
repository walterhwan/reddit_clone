# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :string
#  author_id  :integer
#  post_id    :integer
#  comment_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :author,
  foreign_key: :author_id,
  class_name: :User

  belongs_to :post

  belongs_to :parent_comment, optional: true,
  foreign_key: :comment_id,
  class_name: :Comment

  has_many :comments

end
