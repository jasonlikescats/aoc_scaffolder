require "file"
require "file_utils"
require "http/client"
require "option_parser"

require "./file_creator"

module AocScaffolder
  VERSION = "0.1.0"
  SESSION_FILE = "session"
  DEFAULT_PATH = ".."

  struct Options
    getter year, day, path

    def initialize(@year : Int32, @day : Int32, @path : String)
    end
  end

  def self.load_options
    est_time = Time.local(location: Time::Location.load("EST"))
    year = est_time.year
    day = est_time.day
    path = DEFAULT_PATH
  
    OptionParser.parse do |parser|
      parser.banner = "Advent of Code Daily Scaffolder"
  
      parser.on("-y YEAR", "--year=YEAR", "Event year") { |y| year = y }
      parser.on("-d DAY", "--day=DAY", "Event day") { |d| day = d }
      parser.on("-p PATH", "--path=PATH", "Relative path to directory to place the scaffolded data") { |p| path = p }
      parser.on("-h", "--help", "Show this help") do
        puts parser
        exit
      end
      parser.invalid_option do |flag|
        STDERR.puts "ERROR: #{flag} is not a valid option."
        STDERR.puts parser
        exit(1)
      end
    end

    Options.new(year.to_i, day.to_i, path)
  end

  def self.request_with_session(url, session)
    cookies = HTTP::Cookies.new
    cookies << HTTP::Cookie.new("session", session)
    
    headers = HTTP::Headers.new
    cookies.add_request_headers(headers)

    HTTP::Client.get(url, headers)
  end

  def self.load_session_info
    File.read(SESSION_FILE)
  end

  def self.get_puzzle_input(options, session_info)
    response = request_with_session(
      "https://adventofcode.com/#{options.year}/day/#{options.day}/input",
      session_info
    )
    response.body
  end

  options = load_options
  puts "Scaffolding event #{options.year}/#{options.day}"

  file_creator = FileCreator.new(options)
  puts "Storing data in #{file_creator.dir}"

  session_info = load_session_info
  file_creator.save(get_puzzle_input(options, session_info), "input")

  file_creator.copy("template.cr", "main.cr")

  puts "Done! Have fun!"
end
