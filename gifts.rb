require 'date'
require 'time'

class Gifts

  attr_accessor :last_gift_day

  FILE_NAME = 'notes.txt'
  FILE_PATH = "#{Dir.getwd}/#{FILE_NAME}".freeze

  def process_gift
    'Gift is needed for Ann!' if is_gift_date?
  end

  private

  def initialize
    if FileTest.exists?(FILE_PATH)
      @last_gift_day = File.open(FILE_PATH, 'r') { |io| io.read }
    else
      File.new(FILE_PATH,'w+')
    end
  end


  def is_gift_date?
    today = Time.now
    flag = false

    if today.day == 16 || @last_gift_day.nil? || (!is_weekends?(today) && is_long_time_ago?(today, @last_gift_day))
      @last_gift_day = today

      File.open(FILE_PATH, 'w') { |io| io.write(@last_gift_day) }

      flag = true
    end

    flag
  end

  #def is_available(data)
  #  return true if @last_gift_day.nil?
  #  return true unless is_weekends(data)
  #  false
  #end

  def is_weekends?(data)
    data.day == 0 || data.day == 6
  end

  def is_long_time_ago?(today, last_date)
    return false if last_date.nil?

    last_date = Time.parse(last_date) if last_date.is_a?(String)

    today.year > last_date.year || (today.day - last_date.day) >= 7 ? true : false
  end

end
