class TitleBracketsValidator < ActiveModel::Validator
  def validate(movie)
    title = movie.title
    @stack = []

    title.each_char.with_index do |char, index|
      if opening_brace?(char)
        @stack.push(char)
      elsif closing_brace?(char)
        if closes_last_opening_brace?(char)
          movie.errors.add(:title, "Empty brackets") if title.index(last_opening_brace) == index - 1
          @stack.pop
        else
          movie.errors.add(:title, "Incorrect closing bracket")
          return
        end
      end
    end
    movie.errors.add(:title, "Unclosed opening bracket") if @stack.any?
  end

  private
  
  def opening_brace?(char)
    ["{", "[", "("].include?(char)
  end

  def closing_brace?(char)
    ["}", "]", ")"].include?(char)
  end

  def last_opening_brace
    @stack.last
  end

  def opening_brace_of(char)
    { "}" => "{", ")" => "(", "]" => "["}[char]
  end

  def closes_last_opening_brace?(char)
    opening_brace_of(char) == last_opening_brace
  end
end
