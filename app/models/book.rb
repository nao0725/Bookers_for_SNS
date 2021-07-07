class Book < ApplicationRecord

  # あそしえーしょん
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user #いいねソート順にするため追加
  has_many :book_comments, dependent: :destroy

  # 並び替えするメソッド
  from  = Time.current.at_beginning_of_day
  to    = (from + 6.day).at_end_of_day
  books = Book.where(created_at: from...to)

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # バリデーション
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}
end

