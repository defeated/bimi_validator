require 'resolv'

class QueriesController < ApplicationController
  def show

    txt = Resolv::DNS.open do |dns|
      name = "default._bimi.#{params[:domain]}"
      type = Resolv::DNS::Resource::IN::TXT
      res = dns.getresource name, type
      res.data
    end

    # we could juse split the string...
    # result = txt.split(';').map do |item|
    #   item.strip.split('=')
    # end.to_h.symbolize_keys
    # record = Struct.new(:version, :locations, :authorities).new(result[:v], result[:l].split(','), result[:a])

    # ... or get fancy and build a grammar :)
    tree = BimiParser::Parser.new.parse txt
    transform = BimiParser::Transformer.new.apply(tree)
    render json: transform
  end
end
