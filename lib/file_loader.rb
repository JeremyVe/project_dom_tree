class FileLoader

  def load(file_path)
    File.open(file_path).readlines[1..-1].map(&:strip).join
  end
end