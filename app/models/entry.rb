class Entry < ApplicationRecord #どのふたりがやり取りをするのか
  belongs_to :user
  belongs_to :room
end
