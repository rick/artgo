#
#  Generate a bingo card from a directory of 95px x 95px images.
#
#  Original idea from Planet Socks "Presidential Debate Bingo"
#  (http://www.planetsocks.com/bingo.asp)
#
#  Rick Bradley (rick@rickbradley.com)
#
#  Drop your collection of PNG files in a directory under the bingo root
#  directory (defaults to RAILS_ROOT + '/public/images/bingo/').  Call the
#  bingo controller with id set to the directory name containing the images
#  (so, for "/public/images/bingo/art/" I'd call /bingo/art/ on the URL line.
#  
#  *.png files are all equally weighted, unless they are named like: foo_#.png,
#  in which case the # is a weight for that image.
#

class BingoController < ApplicationController
  # initialize controller state.  Interrogate image directories.
  def initialize(root = File.join('public', 'images', 'bingo'))
    @root = File.join(RAILS_ROOT, root)
    @max = 24
    @grid = {}
    @title = {}

    Dir.open(@root).each do |action|
      next unless File.directory?(File.join(@root, action))
      next if action =~ /^\.\.?$/
      @grid[action] ||= {}
      @title[action] = ['B', 'I', 'N', 'G', 'O'] if action == 'bells_bend'
      @title[action] ||= ['A', 'R', 'T', 'G', 'O' ]
      Dir.open(File.join(@root, action)).each do |f| 
        next if (f =~ /^free_square.png$/)
        next unless (f =~ /..+\.png$/)
        @grid[action][f.gsub(/\.png$/, '')] = (f =~ /_(\d+)\.png/ ? $1.to_i : 1)
      end
    end
  end 

  # generate a uniformly shuffled list of @max elements from @grid[action] keys
  # selected based on the weights in @grid[action]
  def index
    @action = params[:id]
    @cells = (@title[@action] << shuffle(choose(@grid[@action]))).flatten
  end

  protected

  # choose a key from a weighted key hash
  def choose(h)
    h = h.dup
    result = []
    0.upto(@max-1) do |i|
      total, cumulative = cumulative_array(h)
      result << (key = pick(cumulative, rand(total)+1))
      h.delete(key)
    end
    result
  end

  # pick an entry out of a cumulative array
  def pick(array, num)
    array.each { |cell| return cell[0] if num <= cell[1] }
  end

  # create a "cumulative array" from a hash of keys with weights
  def cumulative_array(h)
    result = h.keys.inject([[nil, 0]]) {|a, v| a << [v, a.last[1] + h[v]]; a }
    result.shift
    [ result.inject(0) {|max,v| max < v[1] ? v[1] : max }, result ]
  end

  # shuffle an array uniformly at random, returning shuffled array. 
  def shuffle(array)
    array = array.dup
    1.upto(array.length-1) do |i|
      num = rand(array.length - i - 1) + i
      array[i-1], array[num] = array[num], array[i-1]
    end
    array
  end
end
