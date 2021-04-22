class Task < ApplicationRecord
     belongs_to :user
     validates :content, presence: true, length: {maximum:255}
     #定義されていないバリデーションを先に作るとsave, updateメソッドでエラーが出る。
     validates :status, presence: true, length: {maximum:10}
end
