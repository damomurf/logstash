require "logstash/filters/base"
require "logstash/namespace"

class LogStash::Filters::DateFormat < LogStash::Filters::Base

  config_name "dateformat"
  plugin_status "experimental"

  # filter {
  #   dateformat {
  #     field => 'localdate'
  #     format => "%H:%M:%S"
  #     local => true
  # }

  # Name of the field to add the formatted local date to
  config :field, :validate => :string

  # The date/time format to use to format the resulting field value
  # See http://www.ruby-doc.org/core-2.0/Time.html#method-i-strftime for valid formats
  config :format, :validate => :string

  # Whether or not the date should be converted to local time
  config :local, :validate => :boolean

  public
  def register
    # nothing to do
    @logger.warn("Config values: ", :field => @field, :format => @format, :local => @local)
  end # def register

  public
  def filter(event)
    if @local then
      event[@field] = Time.parse(event.timestamp).getlocal().strftime(@format)
    else
      event[@field] = Time.parse(event.timestamp).strftime(@format)
    end 
    filter_matched(event)
  end # def filter

end # class LogStash::Filters::DateFormat
