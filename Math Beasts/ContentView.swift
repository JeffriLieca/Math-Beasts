//
//  ContentView.swift
//  Math Beasts
//
//  Created by Jeffri Lieca H on 25/12/24.
//

import SwiftUI

struct ContentView: View {
    
    let animalRounds = [
        "frog_round",
        "snake_round",
        "duck_round",
        "penguin_round",
        "rabbit_round",
        "pig_round",
        "dog_round",
        "cow_round",
        "horse_round",
        "monkey_round",
        "elephant_round",
        "whale_round"
    ]
    
    @State var difficultySelected = 0
    @State var gameStarted = false
    @State var questionSelected = 10
    
    var body: some View {
        NavigationStack{
            
            ZStack{
                
                RadialGradient(colors: [.blue,.red,.yellow], center: .top, startRadius: 10, endRadius: 1000)
                
                 .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    VStack (spacing: 10) {
                        
                        Text("Difficulty Level")
                            .titleStyle()
                        
                        VStack(spacing : 0){
                            
                            HStack{
                                ForEach(0..<6) { number in
                                    ButtonDifficulty(imageName: animalRounds[number], number: number, difficultySelected: $difficultySelected)
                                }
                            }
                            HStack{
                                ForEach(6..<12) { number in
                                    ButtonDifficulty(imageName: animalRounds[number], number: number, difficultySelected: $difficultySelected)
                                }
                            }
                        }
                    }
                    .padding()
                  
                    .background(.ultraThinMaterial)
                    
                    .clipShape(.rect(cornerRadius: 20))
                    .opacity(gameStarted ? 0.6 : 1)
                    
                    //        let animalImage =  UIImage(named: animalRounds[0])
                    //        let resizeImage = animalImage?.resizableImage(withCapInsets: .init(top: 20, left: 20, bottom: 20, right: 20))
                    //        animalImage?.scale = 0.5
//                    Spacer()
                    VStack{
                        if gameStarted {
                            QuestionView(totalQuestion: questionSelected, difficultyLevel: difficultySelected+1, gameStarted: $gameStarted)
                                .padding()
                                .transition(.asymmetric(insertion: .slide, removal: .opacity))
                        }
                        else {
                            StartGameView(difficultySelected: $difficultySelected, gameStarted: $gameStarted, questionSelected: $questionSelected)
                                .padding()
                                .transition(.asymmetric(insertion: .opacity, removal: .slide))
//                                .animation(.easeIn(duration: 2), value: gameStarted)
                        }
                
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                   
                  
                    .background(.ultraThinMaterial)
                  
                    .clipShape(.rect(cornerRadius: 20))
                   
                    
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 20)
//                            .fill(.blue)
//                        RoundedRectangle(cornerRadius: 20)
//                            .stroke(.red, lineWidth: 5)
//                        
//                    }
//                    .frame(width: 100)
                    
                    //            .stroke
//                    HStack (alignment: .bottom , spacing:0) {
//                        ForEach(animalRounds, id: \.self) { animal in
//                            ResizeImage(animal)
//                                .Imagescale(to: 0.2)
//                            //                    .Imagescale(to: 0.5)
//                            //                    .scaledToFit()
//                                .frame(width: 30 )
//                            
//                            //                    .scaleEffect(0.5)
//                            
//                            //                    .frame(width: (animalImage?.size.width)!/2, height: (animalImage?.size.height)!/2)
//                            
//                            //                Image(animal)
//                            //                    .resizable(resizingMode: .stretch)
//                            //
//                            //                    .frame(width: 50, height: 50)
//                        }
//                    }
                }
                .padding()
                .navigationTitle("Multiplication")
                .navigationBarTitleDisplayMode(.inline)
            }
          
        }
//        .ignoresSafeArea(.keyboard)
    }
        
    
    
}

struct QuestionView : View {
    
    let totalQuestion : Int
    @State private var questionRemaining = 10
    let difficultyLevel : Int
    @State private var multiplier = Int.random(in: 1...12)
    @State private var answer : Int? = nil
    @FocusState private var isFocused : Bool
    @State private var isSubmiting = false
    @State private var score = 0
    @State private var answerString = "Correct 🎉"
    @Binding var gameStarted : Bool
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button{
                    withAnimation{
                        alertTitle = "Abandon the Challenge"
                        alertMessage = "Are you sure you want to give up on the challenge?"
                        showAlert = true
                    }
                    
                } label: {
                    
                    
                    Text("X")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.red)
                    //                    .frame(maxWidth: 20)
                    
                    //
                    
                        .frame(width: 35, height: 35)
                        .background(.white)
                        .clipShape(.circle)
                }
                
                    
                   
            }
            .alert(alertTitle, isPresented: $showAlert){
                Button("Cancel", role: .cancel) {}
                Button("Exit", role: .destructive) {
                    withAnimation{
                        score = 0
                        gameStarted = false
                    }
                }
            } message: {
                Text(alertMessage)
            }
            
            HStack {
                Spacer()
                Text("\(difficultyLevel)")
                    .frame(width: 100)
                Spacer()
                Text("X")
                Spacer()
                Text("\(multiplier)")
                    .frame(width: 100)
                    .animation(.easeOut(duration: 1), value: multiplier)
                Spacer()
                
            }
            .titleStyle()
            .padding()
            Text("=")
                .font(.largeTitle.bold())
//            Form{
            VStack{
                TextField("Answer", value: $answer.animation(.default), format: .number)
                    .multilineTextAlignment(.center)
                    .titleStyle()
                    .keyboardType(.numberPad)
//                    .submitLabel(.done)
                .padding()
                .frame(width: 200, height: 50)
                .background(.white)
                .focused($isFocused)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            isFocused = false
                        }
                    }
                }
                .animation(.default, value: isFocused)
                
                //                .background(.blue)
                //                .tint(.orange)
                //                .textFieldStyle(.automatic)
                //                .frame(height: 50)
                //                .frame(width: 100)
                //                .background(.red)
                .clipShape(.rect(cornerRadius: 20))
                
                //            }
            }
            .gesture(
                TapGesture().onEnded{
                    isFocused = true
                    print("tapped")
                }
            )
            .disabled(isSubmiting)
//            .gesture{
//                TapGesture()
//                    .onEnded{
//                        print("Dsa")
//                    }
//            }
//            Spacer()
            .padding()
            
            if isSubmiting {
                Text(answerString)
                    .titleStyle()
            }
            
            Button{
                withAnimation{
                    if isSubmiting{
                        nextGame()
                    }
                    else{
//                        gameStarted = false
                        submitAnswer()
                        
                    }
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill((isSubmiting ? .green : .pink))
                        .opacity(answer == nil ? 0.3 : 0.6)
                        .animation(.default, value: answer)
                        .frame(width: 200, height: 50)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                    Text(isSubmiting ? "Next" : "Submit")
                        .font(.title2.bold())
                        .foregroundStyle(.black)
                        .animation(.easeInOut, value: isSubmiting)
                       
                }
            }
            .disabled(answer == nil)
               
            Spacer()
            VStack (alignment: .trailing){
                HStack{
                    Text("Score : \(score)")
                        .font(.largeTitle.weight(.heavy))
                        .foregroundStyle(.white)
                    Spacer()
                    Text("\(questionRemaining)/\(totalQuestion)")
                        .font(.largeTitle.weight(.heavy))
                        .foregroundStyle(.white)
//                        .frame(maxWidth: .infinity)
                }
            }
            .frame(maxWidth: .infinity)
            
        }
        .onAppear{
            questionRemaining = totalQuestion
        }
        .animation(.default, value: isFocused)
//        .padding()
    }
    
    func askQuestion() {
        let randomNumber = Int.random(in: 1...12)
        multiplier = randomNumber
    }
    
    func checkAnswer() -> Bool {
        let correctAnswer = multiplier*difficultyLevel
        return answer == correctAnswer
    }
    
    func submitAnswer() {
        let correct = checkAnswer()
        if correct {
            score += 1
            answerString = "Correct 🎉"
        }
        else {
            answerString = "Wrong ❌"
        }
        questionRemaining -= 1
//        answer = nil
        isSubmiting = true
        isFocused = false
        
        
        if questionRemaining <= 0 {
            // end game
        }
        else {
           
//            askQuestion()
        }
        
    }
    
    func nextGame() {
        answer = nil
        isSubmiting = false
        answerString = ""
        askQuestion()
        if questionRemaining <= 0 {
            // end game
            score = 0
            gameStarted = false
        }
            
         
        
    }
}

struct StartGameView : View {
    let manyQuestion = [5,10,20]
    let animalRoundDetails = [
        "frog_round_detail",
        "snake_round_detail",
        "duck_round_detail",
        "penguin_round_detail",
        "rabbit_round_detail",
        "pig_round_detail",
        "dog_round_detail",
        "cow_round_detail",
        "horse_round_detail",
        "monkey_round_detail",
        "elephant_round_detail",
        "whale_round_detail"
    ]
    @Binding var difficultySelected : Int
    @Binding var gameStarted : Bool
    @Binding var questionSelected : Int
    @State private var scaleAmount = 1.0
    
    var call : String {
        switch questionSelected {
        case 5 : return "Beginner"
        case 10 : return "Intermediate"
        case 20 : return "Beast"
        default : return ""
        }
    }
    
    var body: some View {
        VStack (spacing: 0){
            Text("How Many Question")
//                .font(.title.bold())
                .titleStyle()
            HStack {
                ForEach(manyQuestion, id: \.self) { many in
                    Button {
                        withAnimation(.easeIn){
                            questionSelected = many
                        }
                    } label: {
                        ZStack {
                            Circle()
                                .fill(.white)
                            Text("\(many)")
                                .font(.title2.bold())
                                .foregroundStyle(.black)
                        }
                        .padding(.horizontal, 10)
                        .opacity(questionSelected == many ? 1 : 0.5)
                    }
//                    .animation(.easeIn, value: difficultySelected)
                }
            }
            .padding()
            Spacer()
            HStack{
                Image(animalRoundDetails[difficultySelected])
                    .resizable()
                    .scaledToFit()
                    .animation(nil, value: difficultySelected)
            }
            
            .scaleEffect(scaleAmount)
//            .animation(.easeIn.repeatForever(autoreverses: true), value: scaleAmount)
               
//            Spacer()
            Text(call)
                .titleStyle()
                .padding()
//            Spacer()
            Button{
                withAnimation{
                    gameStarted = true
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.pink.opacity(0.6))
                        .frame(width: 200, height: 50)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                    Text("Start Challenge")
                        .font(.title2.bold())
                        .foregroundStyle(.black)
                }
            }
//            .padding()
//            Spacer()
        }
        .onAppear{
            questionSelected = 5
            withAnimation (.easeInOut(duration: 1).repeatForever(autoreverses: true)){
                scaleAmount = 1.1
            }
        }
    }
        
}
    
struct ButtonDifficulty : View {
    let imageName : String
    let number : Int
    @Binding var difficultySelected : Int
    var body: some View {
        Button {
            withAnimation{
                difficultySelected = number
            }
        } label: {
            VStack (spacing: 0){
                ZStack{
                    Circle()
                        .stroke(difficultySelected == number ? .clear : .gray, lineWidth: 1)
                    Image("\(imageName + (difficultySelected == number ? "_outline" : ""))")
                        .resizable()
                        .opacity((difficultySelected == number ? 1 : 0.5))
                    
                }
                .scaleEffect((difficultySelected == number ? 1.1 : 0.9))
                .scaledToFit()
                
                Text("\(number+1)")
                    .font(.title2)
                    .foregroundStyle(difficultySelected == number ? .black : .gray)
                
            }
        }
    }
}

//
//
//struct ResizeImage : View {
//    let withImage : UIImage
//    @State var frameWidth : CGFloat
//    @State var frameHeight : CGFloat
//    
//    init(withImage: UIImage) {
//        self.withImage = withImage
//        frameWidth = withImage.size.width
//        frameHeight = withImage.size.height
//    }
//    
//    init(_ name : String) {
//        let image = UIImage(named: name)
//        guard let image else {
//            fatalError("there is no image names \(name)")
//        }
//        self.withImage = image
//        frameWidth = withImage.size.width
//        frameHeight = withImage.size.height
//    }
//    
//    var body: some View {
//        Image(uiImage: withImage)
//            .resizable()
////            .frame(width: frameWidth, height: frameHeight)
//    }
//    
//    func Imagescale(to scalePoint : CGFloat) -> some View {
//        print("before Scale : \(frameWidth)")
//        self.frameWidth = 70
//        frameHeight *= scalePoint
//        
//        print("after Scale : \(self.frameWidth)")
//        return body.frame(width: frameWidth*scalePoint, height: frameHeight*scalePoint)
//    }
//    
//
//}

struct TitleStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(.black)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(TitleStyle())
    }
}


#Preview {
    ContentView()
}
