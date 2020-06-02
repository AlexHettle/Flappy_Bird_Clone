require 'ruby2d'
set title: "Flappy Bird",background: '#29f8ff', width: 500, height: 500
Groundpipe=Rectangle.new(y:350, x:600,width:100,height:rand(200..400),color: 'green')
Ground=Rectangle.new(y: 480,width: 500, height: 20,color:'brown')
Ceilingpipe=Rectangle.new(y:0,x:900,width:100,height:rand(50..400),color:'green')
Ceiling=Rectangle.new(y: 20,width: 500, height: 20,color:'brown')
Bird=Circle.new(x:200,y:250,radius:25,color: 'yellow')
def play_game()
  canjump=1
  score=0
  def lose_game(score)
    clear
    Ground.add
    Bird.color='red'
    Bird.add
    score_text="SCORE: "+score.to_s
    t1=Text.new("GAME OVER",x:100,y:250,color:"black",size:50)
    t2=Text.new(score_text,x:100,y:290,color:"black",size:50)
    return 0
  end
  on :key_down do |event|
    if canjump==1
      Bird.y-=60
    end
  end
  score_num="SCORE: "+score.to_s
  score_text=Text.new(score_num,x:50,y:50,color:'black',size:20)
  update do
    score_text.remove
    if canjump==1
      score_num="SCORE: "+score.to_s
      score_text=Text.new(score_num,x:50,y:50,color:'black',size:20)
    end
    if canjump==1
      score+=1
    end
    if Bird.y<455
      Bird.y+=4
    end
    if Bird.y<65
      Bird.y=65
    end
    Groundpipe.x-=4
    Ceilingpipe.x-=4
    if Groundpipe.x<=-100
      Groundpipe.x=500
      Groundpipe.y=rand(300..400)
    end
    if Ceilingpipe.x<=-100
      Ceilingpipe.x=500
      Ceilingpipe.height=rand(200..400)
    end
    if (Groundpipe.contains? Bird.x+20,Bird.y+20) || (Groundpipe.contains? Bird.x,Bird.y+20) || (Groundpipe.contains? Bird.x-20,Bird.y+20)
      canjump=lose_game(score)
    end
    if (Ceilingpipe.contains? Bird.x+20,Bird.y-20) || (Ceilingpipe.contains? Bird.x,Bird.y-20) || (Ceilingpipe.contains? Bird.x-20,Bird.y-20)
      canjump=lose_game(score)
    end
  end
end
play_game()
show
