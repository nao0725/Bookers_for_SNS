class Room < ApplicationRecord #どこでDMのやり取りをするのか
  has_many :entries, dependent: :destroy #複数のエントリー先がある
  has_many :messages, dependent: :destroy #複数のMessageのやり取りがされる
end
