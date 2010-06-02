
# Metaprogramming Hack Day
#   author: John Feminella [johnf.pub@distb.net]
#
# Use `rake -D` to see full descriptions.

includes = ["lib"]
includes.each do |i|
  p = File.expand_path("../#{i}", __FILE__)
  $: << p unless $:.include? p
end

require 'spec/rake/spectask'

namespace :ponder do
  desc "The road to enlightenment begins at your door. [Ask the guru for some wisdom.]"
  task :meditate do
    puts Guru.new.inquire
  end

  desc "Meditate until enlightenment is achieved. [Run unit tests.]"
  task :koans => :meditate do
    Spec::Rake::SpecTask.new("_koans") do |t|
      t.spec_files = FileList['**/koans/**/*-spec.rb']
      spec_helper = File.expand_path("koans/spec-helper.rb")
      raise Guru.new.admonish("you cannot ponder unless you wander") unless File.exists?(spec_helper)
      t.spec_opts = ["--require", spec_helper, "--color", "--backtrace", "--format", "specdoc"]
    end
    begin
      Rake.application["_koans"].invoke
    rescue
      raise Guru.new.impart("mountains are merely mountains")
    end
    Guru.new.intone("mountains are again merely mountains")
  end
end

class Guru
  @name = "the metaprogramming guru"

  def initialize(fname = "wisdom.txt")
    raise admonish("a journey cannot begin without the beginning") unless File.exists?(fname)
    f = File.new(fname)
    @quotes = f.readlines.map { |line|
      record = line.chomp.split("|")
      {:quote => record[0], :author => record[1]}
    }
  end

  def inquire
    quote = @quotes[rand(@quotes.size)]
    intone quote
  end
  
  def intone(words)
    decorate words[:quote], words[:author]
  end
  
  def impart(wisdom)
    wisdom = wisdom.capitalize << '.'
    s = decorate wisdom, @name
    s.join("\n")
  end
  
  def admonish(words)
    words = words.capitalize << '.'
    error = "(There was a problem with what you asked. Run rake with `--trace` to determine what went awry.)"
    words = "#{words} #{error}"
    
    s = decorate words, @name, {:h => 1, :v => 1, :s => ' ', :e => '!'}
    s.join("\n")
  end
  
  private
  
  def decorate(text, cite, border_data = {:h => 1, :v => 1, :s => ' ', :e => '#'})
    b = border_data
    text = wrap(text, 60)
    e = text.lines
    width = e.map { |l| l.strip.size }.max
    
    # Side border.
    lr_border = b[:e].dup << (b[:s] * b[:h])
    
    # Top border.
    tb_border_edge = (b[:e].dup * (width + 2 * lr_border.size))
    tb_border_space = [lr_border, b[:s] * width, lr_border.reverse].join
    tb_border = [tb_border_edge, [tb_border_space] * b[:v]].flatten
    
    lines = []
    # Top.
    lines += tb_border
    # Text.
    lines += e.map { |l| [lr_border, l.strip.ljust(width), lr_border.reverse].join }.flatten
    # Author.
    lines += [tb_border_space, [lr_border, "-- #{cite}".rjust(width), lr_border.reverse].join]
    # Bottom.
    lines += tb_border.reverse
  end
  
  def wrap(text, wrap_to = 72, tab_size = 2)
    tab = ' ' * tab_size
    result = []; line = ''
    text.split(' ').each do |w|
      if line.length + w.length > wrap_to
        result << line; line = tab + w
      else
        line << (line.empty? ? '' : ' ') << w
      end
    end
    result << line if !line.strip.empty?
    result.join("\n")
  end
end
