class Project < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  # カスタムゲッター
  def tag_array
    # もし tag が文字列なら、JSON形式か単一文字列かで処理
    if tag.is_a?(String)
      # JSON形式ならパース、そうでなければ単一タグとして配列にする
      if tag.strip.start_with?('[')
        begin
          JSON.parse(tag)
        rescue JSON::ParserError
          [tag]
        end
      else
        [tag]
      end
    elsif tag.is_a?(Array)
      tag
    else
      []
    end
  end
end
