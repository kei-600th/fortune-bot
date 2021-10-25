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
    img_array = [
      "https://user-images.githubusercontent.com/72121574/138705897-44ec0410-c190-42c4-b301-792a35b579ce.jpeg",
      "https://user-images.githubusercontent.com/72121574/138705990-473403dd-6060-4ef6-b428-deaeca4b77fc.jpeg",
      "https://user-images.githubusercontent.com/72121574/138706034-506ec5b2-7215-42fe-8a16-9daad9e98720.jpeg",
      "https://user-images.githubusercontent.com/72121574/138706153-e0cfa29d-9d3d-44be-9835-811217e84a87.jpeg",
      "https://user-images.githubusercontent.com/72121574/138706219-3128dd93-c9ad-430e-9e6b-26a40baf11ad.jpeg",
      "https://user-images.githubusercontent.com/72121574/138706243-df46dfdf-d232-491f-9979-f3c63c7357d5.jpeg",
      "https://user-images.githubusercontent.com/72121574/138706263-8045f9ae-b6d2-4efe-8494-4afdecc3df62.jpeg",
      "https://user-images.githubusercontent.com/72121574/138706275-011e0f56-c434-4ff5-bb4d-c3410c953acf.jpeg",
      "https://user-images.githubusercontent.com/72121574/138706302-b808b9fd-1e57-4600-a294-1c6576b96265.jpeg",
      "https://user-images.githubusercontent.com/72121574/138706338-e5bfdf58-e5f5-41f7-8a8a-4ccff2d072d0.jpeg",
      "https://user-images.githubusercontent.com/72121574/138706352-ab0f0755-e7b9-4072-b452-374199a74a92.jpeg",
      "https://user-images.githubusercontent.com/72121574/138706370-4c77e6cd-2ef1-49f9-83d3-dd565a5b672f.jpeg"
    ]





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
          "type": "flex",
          "altText": "this is a flex message",
          "contents": {
            "type": "bubble",
            "hero": {
              "type": "image",
              "url": img_array[num],
              "size": "full",
              "aspectRatio": "20:20",
              "aspectMode": "cover",
              "action": {
                "type": "uri",
                "uri": "http://linecorp.com/"
              }
            },
            "body": {
              "type": "box",
              "layout": "vertical",
              "contents": [
                {
                  "type": "text",
                  "text": "Brown Cafe",
                  "weight": "bold",
                  "size": "xl"
                },
                {
                  "type": "box",
                  "layout": "baseline",
                  "margin": "md",
                  "contents": [
                    {
                      "type": "icon",
                      "size": "sm",
                      "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
                    },
                    {
                      "type": "icon",
                      "size": "sm",
                      "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
                    },
                    {
                      "type": "icon",
                      "size": "sm",
                      "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
                    },
                    {
                      "type": "icon",
                      "size": "sm",
                      "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gold_star_28.png"
                    },
                    {
                      "type": "icon",
                      "size": "sm",
                      "url": "https://scdn.line-apps.com/n/channel_devcenter/img/fx/review_gray_star_28.png"
                    },
                    {
                      "type": "text",
                      "text": "4.0",
                      "size": "sm",
                      "color": "#999999",
                      "margin": "md",
                      "flex": 0
                    }
                  ]
                },
                {
                  "type": "box",
                  "layout": "vertical",
                  "margin": "lg",
                  "spacing": "sm",
                  "contents": [
                    {
                      "type": "box",
                      "layout": "baseline",
                      "spacing": "sm",
                      "contents": [
                        {
                          "type": "text",
                          "text": "Place",
                          "color": "#aaaaaa",
                          "size": "sm",
                          "flex": 1
                        },
                        {
                          "type": "text",
                          "text": "Miraina Tower, 4-1-6 Shinjuku, Tokyo",
                          "wrap": true,
                          "color": "#666666",
                          "size": "sm",
                          "flex": 5
                        }
                      ]
                    },
                    {
                      "type": "box",
                      "layout": "baseline",
                      "spacing": "sm",
                      "contents": [
                        {
                          "type": "text",
                          "text": "Time",
                          "color": "#aaaaaa",
                          "size": "sm",
                          "flex": 1
                        },
                        {
                          "type": "text",
                          "text": "10:00 - 23:00",
                          "wrap": true,
                          "color": "#666666",
                          "size": "sm",
                          "flex": 5
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            "footer": {
              "type": "box",
              "layout": "vertical",
              "spacing": "sm",
              "contents": [
                {
                  "type": "button",
                  "style": "link",
                  "height": "sm",
                  "action": {
                    "type": "uri",
                    "label": "CALL",
                    "uri": "https://linecorp.com"
                  }
                },
                {
                  "type": "button",
                  "style": "link",
                  "height": "sm",
                  "action": {
                    "type": "uri",
                    "label": "WEBSITE",
                    "uri": "https://linecorp.com"
                  }
                },
                {
                  "type": "spacer",
                  "size": "sm"
                }
              ],
              "flex": 0
            }
          }
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
