class SimpleRuboCop
  def initialize(file)
    @file = file
    @corrected_content = []
  end

  def analyze_and_correct
    line_number = 0
    File.foreach(@file) do |line|
      line_number += 1
      line = correct_trailing_whitespace(line)
      line = correct_indentation(line)
      @corrected_content << line
    end
    write_corrections
  end

  private

  def correct_trailing_whitespace(line)
    line.rstrip + "\n"
  end

  def correct_indentation(line)
    if line =~ /^[ \t]*[^\s]/
      indentation = line[/\A */].size
      if indentation % 2 != 0
        corrected_indentation = ' ' * (indentation - indentation % 2)
        line = line.sub(/^\s*/, corrected_indentation)
      end
    end
    line
  end

  def write_corrections
    File.open(@file, 'w') do |file|
      @corrected_content.each { |line| file.puts line }
    end
  end
end

# 使用例
file_name = 'hoge.rb' # 分析するファイル名をここに置く
simple_rubocop = SimpleRuboCop.new(file_name)
simple_rubocop.analyze_and_correct
