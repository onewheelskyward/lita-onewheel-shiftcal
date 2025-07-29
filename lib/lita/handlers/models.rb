# frozen_string_literal: true

class Event
  attr_accessor :id, :title, :venue, :address, :organizer, :details, :time,
                :hideemail, :hidephone, :hidecontact, :length, :timedetails,
                :locdetails, :loopride, :locend, :eventduration, :weburl,
                :webname, :image, :audience, :tinytitle, :printdescr,
                :datestype, :area, :featured, :printemail, :printphone,
                :printweburl, :printcontact, :published, :safetyplan,
                :email, :phone, :contact, :date, :caldaily_id, :shareable,
                :cancelled, :newsflash, :status, :fullcount, :endtime

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value) if respond_to?("#{key}=")
    end
  end
end

class Pagination
  attr_accessor :offset, :limit, :fullcount

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value) if respond_to?("#{key}=")
    end
  end
end

class EventResponse
  attr_accessor :events, :pagination

  def initialize(attributes = {})
    @events = attributes[:events]&.map { |event_data| Event.new(event_data) } || []
    @pagination = Pagination.new(attributes[:pagination]) if attributes[:pagination]
  end
end