require "file"
require "file_utils"

class FileCreator
  getter dir : String

  def initialize(options)
    @dir = create_event_dir(options)
  end

  def save(data, filename)
    File.write(
      "#{dir}/#{filename}",
      data
    )
  end

  def copy(src_path, dest_filename)
    dst_path = "#{dir}/#{dest_filename}"
    FileUtils.cp(src_path, dst_path)
  end

  private def create_event_dir(options)
    dirpath = "#{options.path}/#{options.year}/#{zero_pad(options.day, 2)}"
    FileUtils.mkdir_p(dirpath)
    dirpath
  end

  private def zero_pad(data, len)
    data.to_s.rjust(len, '0')
  end
end
