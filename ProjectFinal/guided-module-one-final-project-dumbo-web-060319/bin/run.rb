require_relative '../config/environment'

prompt = TTY::Prompt.new 
randomDefaultAnswers=["Oh cmon, it'll be fun. Please? (Y/N)", "Try it once! (Y/N)"]
name = prompt.ask("What is your name?")
sleep(1)
puts "Hello, #{name}, are you ready to play? (Y/N)"

response =gets.chomp 
while (response != "Y")
    puts randomDefaultAnswers.sample
    response = gets.chomp
end


def selector 
    prompt = TTY::Prompt.new
    myCandidatesArr=[]
    selectedAnswer = Answer.all.sample 
    answerQuote = getQuoteFromID(selectedAnswer.quote_id)
    answerCandidate = getCandidateFromID(selectedAnswer.candidate_id)       #Selected 1 quote/cand as the correct one 
    myCandidatesArr.push(answerCandidate)                                   #Array of all candidates
    selectThreeMoreBool= 0 
    while (selectThreeMoreBool != 2)                                        #Puts 2 more candidates in 
        isThisTheOne = Candidate.all.sample 
        isThisTheOneName = isThisTheOne.name 
        randomBool = 0 
        while (randomBool == 0)
            isThisTheOneName = randomPerson
            randomBool = checkRandomPerson(myCandidatesArr,isThisTheOneName)
        end
        selectThreeMoreBool += 1 
        myCandidatesArr.push(isThisTheOneName)                              #Push new random candidate
    end
    myCandidatesArr.push(answerQuote)
    return myCandidatesArr
end

def getQuoteFromID(qid)                                                     #Gets content of quote_id
    answer = Quote.all.find_by(id: qid)
    return answer.content
end
def getCandidateFromID(cid)                                                 #Gets name of candidate_id
    answer = Candidate.all.find_by(id: cid)
    return answer.name
end

def randomPerson 
    randomP = Candidate.all.sample 
    randomPname = randomP.name
    return randomPname
end

def checkRandomPerson(arr, person)
    for every in arr do
        if person == every 
            return 0
        end 
    end
    return 1 
end

def displayChoices(myArr)                                                   #Display Quote and let them select
    actualQuote = myArr.pop 
    puts actualQuote
    sleep(1)
    puts "Do you want to favorite this quote? (Y/N)"
    doFavorite = gets.chomp 
    if doFavorite == "Y"
        wheresMyQuote = Quote.find_by(content: actualQuote)
        wheresMyQuote.is_favorite = 1
    end
    puts " "
    puts "Who is this from?"
    puts " "
    puts myArr

    x=gets.chomp 
    sleep(1)
    if x == myArr[0]
        puts "CORRECT"
    else 
        puts "SORRY"
    end

    puts "do you want to play again? (Y/N) or display favorites (Display)"
    plays_again = gets.chomp 
    if plays_again == "Y"
        myArr = selector 
        displayChoices(myArr)
    end 
end


myArr = selector 
displayChoices(myArr)