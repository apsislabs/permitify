require "permitify/version"
require "permitify/configure"
require "permitify/permission"
require "permitify/resource"
require "permitify/railtie"
require "permitify/exceptions"
require "permitify/utils"

module Permitify
  extend Configure

  def permitify
    include Permission
  end

  def permitify_resource
    include Resource
  end
end
