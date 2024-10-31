require 'openai'

class ChatGptService
  def initialize(api_key = ENV['OPENAI_API_KEY'])
    @client = OpenAI::Client.new(access_token: api_key)
  end

  def generate_recipe(ingredients, genre, free_word)
    prompt = "材料: #{ingredients.join(', ')}。ジャンル: #{genre}。#{free_word}に基づいて料理を一品考えてください。"
    response = @client.chat(
      model: "gpt-4",
      messages: [{ role: "user", content: prompt }]
    )
    parse_response(response)
  end

  private

  def parse_response(response)
    message = response['choices'].first['message']['content']
    {
      title: "生成された料理名",
      instructions: "生成された作り方",
      calories: 400 # 仮の値、実際のデータに合わせて適宜処理
    }
  end
end
