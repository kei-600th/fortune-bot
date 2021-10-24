class LineBotController < ApplicationController

  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      return head :bad_request
    end
    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = search_and_create_message(event.message['text'])
          client.reply_message(event['replyToken'], message)
        end
      end
    end
    head :ok
  end


  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def search_and_create_message(keyword)
    http_client = HTTPClient.new
    array =["牡羊座","牡牛座","双子座","蟹座","獅子座","乙女座","天秤座","蠍座","射手座","山羊座","水瓶座","魚座"]
    text = ''
    require 'date'
    date = Date.current.strftime("%Y/%m/%d")
    url = create_url
    response = http_client.get(url)
    response = JSON.parse(response.body)
    if array.index(keyword)
      num = array.index(keyword)
      result = response["horoscope"][date][num]
      p result["content"]
      text << 
        result["sign"] + "\n" +
        result["content"]
        message = {
          type: 'text',
          text: text
        }
    else
      message = {
        type: 'text',
        text: "そのような星座はありません"
      }
    end
  end

  def create_url
    require 'date'
    date = Date.current.strftime("%Y/%m/%d")
    url = 'http://api.jugemkey.jp/api/horoscope/free/' + date
    return url
  end


end
