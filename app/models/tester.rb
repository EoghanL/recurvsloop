class Tester < ActionController::Base

  require 'benchmark'
  
  weights = []
  30.times { weights << (rand(200) + 1) }

  def recursion_speed_test(bs_cs_num, bs_num, expon_int)
    if bs_cs_num < bs_num ** expon_int
      bs_cs_num **= 2
      recursion_speed_test(bs_cs_num, bs_num, expon_int)
    else
      bs_cs_num
    end
  end

  def loop_speed_test(bs_cs_num, bs_num, expon_int)
    bs_cs_num **= 2 while bs_cs_num < bs_num ** expon_int
    bs_cs_num
  end

  def recursively_determine_largest_item(split_arr)
    if split_arr.length <= 2
      alpha = split_arr[0]
      beta = split_arr[-1]
    else
      alpha = recursively_determine_largest_item(split_arr.slice(0,
      split_arr.length / 2))
      beta = recursively_determine_largest_item(split_arr.slice(split_arr.length / 2,
      split_arr.length))
    end
    return alpha > beta ? alpha : beta
  end

  def loop_to_find_largest_item(array)
    max_weight ||= 0
    array.each do |weight|
      max_weight = weight if weight > max_weight
    end
    max_weight
  end

  def explain_recursion
    self.explain_recursion #Definitely don't do this
  end

  def get_slices(slices_we_have, slices_we_want)
    if slices_we_have != slices_we_want
      slices_we_have = slices_we_have * 2
      get_slices(slices_we_have, slices_we_want)
    else
      return slices_we_have
    end
  end
  $z = 0
  def reverse_num (x, y = 0)
    if x > 0
      y *= 10
      y += (x % 10)
      x /= 10
      $z = y
      reverse_num(x, y)
    end
      return $z
  end

  def loop_to_reverse(x)
    y = 0
    while x > 0
      y *= 10
      y += (x%10)
      x /= 10
    end
    return y
  end

  def get_slices(crrnt_slices, final_slices)
    crrnt_slices != final_slices ? get_slices((crrnt_slices/2), final_slices) : crrnt_slices
  end

  def get_method_times(arr)
    puts "Hello, welcome to the Looping vs Recursion Speed Test"
    Benchmark.bmbm do |x|
      x.report ("loop to square 3 until it's bigger than 10 Trillion") {
        loop_speed_test(3, 100, 6)
      }
      x.report ("recursively square 3 until it's larger than 10 Trillion") {
        recursion_speed_test(3, 100, 6)
      }
      x.report ("recursively get largest number") { recursively_determine_largest_item(arr) }
      x.report ("loop to get largest number") { loop_to_find_largest_item(arr) }
      x.report ("recursively reverse a number") { reverse_num(12345678910) }
      x.report ("loopingly reverse a number") { loop_to_reverse(12345678910) }
    end
    puts "Whew, computers are faaaast."
 end

end
