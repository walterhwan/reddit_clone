# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  moderator_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ApplicationRecord
  validates :title, :description, presence: true

  belongs_to :moderator,
    foreign_key: :moderator_id,
    class_name: :User

  has_many :posts

  has_many :post_subs

end
