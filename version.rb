module Rambo
  MAJOR = '0'
  MINOR = '0'
  PATCH = '1'

  def self.version
    [Rambo::MAJOR, Rambo::MINOR, Rambo::PATCH].join('.')
  end
end