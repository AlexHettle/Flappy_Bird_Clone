require 'ruby2d'
set title: "Flappy Ball",background: '#29f8ff', width: 500, height: 500
def start_screen()
  start_text=Text.new("FLAPPY BALL",x:100,y:250,color:"black",size:50)
  button=Rectangle.new(x:130,y:320,width:250,height:70,color:'green')
  start=Text.new("START",x:170,y:330,color:"black",size:50)
  on :mouse_down do |event|
    if button.contains? event.x,event.y
    clear
    play_game()
    end
  end
end
def play_game()
  groundpipe=Rectangle.new(y:350, x:600,width:100,height:rand(300..400),color: 'green')
  ground=Rectangle.new(y: 480,width: 500, height: 20,color:'brown')
  ceilingpipe=Rectangle.new(y:0,x:900,width:100,height:rand(50..400),color:'green')
  ceiling=Rectangle.new(y: 20,width: 500, height: 20,color:'brown')
  bird=Circle.new(x:200,y:250,radius:25,color: 'yellow')
  canjump=1
  score=0
  score_text=Text.new("SCORE: "+score.to_s,x:50,y:50,color:'black',size:20)
  on :key_down do
    if canjump==1
      bird.y-=60
    end
  end
  update do
    if canjump==1
      score_text.remove
      score_text=Text.new("SCORE: "+score.to_s,x:50,y:50,color:'black',size:20)
      score+=1
    end
    if bird.y<455
      bird.y+=4
    end
    if bird.y<65
      bird.y=65
    end
    groundpipe.x-=4
    ceilingpipe.x-=4
    if groundpipe.x<=-100
      groundpipe.x=500
      groundpipe.y=rand(300..400)
    end
    if ceilingpipe.x<=-100
      ceilingpipe.x=500
      ceilingpipe.height=rand(200..400)
    end
    if (ceilingpipe.contains? bird.x+20,bird.y-20) || (ceilingpipe.contains? bird.x,bird.y-20) ||
       (ceilingpipe.contains? bird.x-20,bird.y-20) || (groundpipe.contains? bird.x+20,bird.y+20) ||
       (groundpipe.contains? bird.x,bird.y+20) || (groundpipe.contains? bird.x-20,bird.y+20)
      clear
      ground.add
      bird.color='red'
      ceiling.add
      bird.add
      score_text="SCORE: "+score.to_s
      t1=Text.new("GAME OVER",x:100,y:250,color:"black",size:50)
      t2=Text.new(score_text,x:100,y:290,color:"black",size:50)
      canjump=0
    end
  end
end
start_screen()
show
