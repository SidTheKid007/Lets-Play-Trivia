//
//  GameController.swift
//  History Trivia
//
//  Created by Siddhesvar Kannan on 10/1/20.
//  Copyright © 2020 Siddhesvar Kannan. All rights reserved.
//

import UIKit
import AVFoundation

class GameController: UIViewController {

    @IBOutlet weak var scoreBox: UIView!
    @IBOutlet weak var option1Box: UIView!
    @IBOutlet weak var option2Box: UIView!
    @IBOutlet weak var option3Box: UIView!
    @IBOutlet weak var option4Box: UIView!
    @IBOutlet weak var homeBox: UIImageView!
    @IBOutlet weak var coinCount: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    @IBOutlet weak var choice4: UIButton!
    @IBOutlet weak var choice1Text: UILabel!
    @IBOutlet weak var choice2Text: UILabel!
    @IBOutlet weak var choice3Text: UILabel!
    @IBOutlet weak var choice4Text: UILabel!
    
    let defaults = UserDefaults(suiteName: "group.com.Personal.SidHistoryTrivia")!
    var audioPlayer: AVAudioPlayer?
    var correct = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylize(myView: scoreBox)
        stylize(myView: option1Box)
        stylize(myView: option2Box)
        stylize(myView: option3Box)
        stylize(myView: option4Box)
        stylize(myView: homeBox)
        let coins = self.defaults.integer(forKey: "coins")
        coinCount.text = String(coins)
        loadQuestion()
    }
    
    func loadQuestion() {
        resetBox(myView: option1Box)
        resetBox(myView: option2Box)
        resetBox(myView: option3Box)
        resetBox(myView: option4Box)
        guard let url = URL(string: "https://opentdb.com/api.php?amount=1&type=multiple") else {
            loadDefaults()
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Questions.self, from: data) {
                    DispatchQueue.main.async {
                        self.question.text = String(htmlEncodedString: decodedResponse.results[0].question)
                        self.setChoices(incorrect_answers: decodedResponse.results[0].incorrect_answers,correct_answer: decodedResponse.results[0].correct_answer)
                    }
                    return
                }
            }
            self.loadDefaults()
        }.resume()
    }
    
    func setChoices(incorrect_answers:[String], correct_answer:String) {
        correct = (String(htmlEncodedString: correct_answer)!)
        var allChoices = incorrect_answers
        allChoices.append(correct_answer)
        allChoices = allChoices.shuffled()
        choice1Text.text = String(htmlEncodedString: allChoices[0])
        choice2Text.text = String(htmlEncodedString: allChoices[1])
        choice3Text.text = String(htmlEncodedString: allChoices[2])
        choice4Text.text = String(htmlEncodedString: allChoices[3])
    }
    
    func loadDefaults() {
        DispatchQueue.main.async {
            let choices = self.defaultLogic()
            self.correct = choices[7]
            self.question.text = "What is " + choices[4] + " " + choices[6] + " " + choices[5] + "?"
            self.choice1Text.text = choices[0]
            self.choice2Text.text = choices[1]
            self.choice3Text.text = choices[2]
            self.choice4Text.text = choices[3]
        }
    }
    
    @IBAction func pressChoice1(_ sender: UIButton) {
        let choice = choice1Text.text ?? ""
        validate(picked: choice)
        correct = ""
    }
    
    @IBAction func pressChoice2(_ sender: Any) {
        let choice = choice2Text.text ?? ""
        validate(picked: choice)
        correct = ""
    }
    
    @IBAction func pressChoice3(_ sender: Any) {
        let choice = choice3Text.text ?? ""
        validate(picked: choice)
        correct = ""
    }
    
    @IBAction func pressChoice4(_ sender: Any) {
        let choice = choice4Text.text ?? ""
        validate(picked: choice)
        correct = ""
    }
    
    func validate(picked: String) {
        if (picked == correct) {
            question.text = "Correct!"
            playAnswerSound(result: "Correct")
            addCoin(count: 1)
        } else {
            question.text = "Wrong!"
            playAnswerSound(result: "Wrong")
        }
        validateBox(picked: choice1Text.text ?? "", myView: option1Box)
        validateBox(picked: choice2Text.text ?? "", myView: option2Box)
        validateBox(picked: choice3Text.text ?? "", myView: option3Box)
        validateBox(picked: choice4Text.text ?? "", myView: option4Box)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ) {
            self.loadQuestion()
        }
    }
    
    func validateBox (picked: String, myView: UIView) {
        if (picked == correct) {
            myView.layer.borderColor = UIColor.green.cgColor
            myView.backgroundColor = UIColor.init(red: 0.7, green: 1, blue: 0.7, alpha: 1.0)
        } else {
            myView.layer.borderColor = UIColor.red.cgColor
            myView.backgroundColor = UIColor.init(red: 1, green: 0.7, blue: 0.7, alpha: 1.0)
        }
    }
    
    func addCoin(count: Int) {
        let newcoin = self.defaults.integer(forKey: "coins") + count
        defaults.set(newcoin, forKey: "coins")
        coinCount.text = String(newcoin)
    }
    
    func stylize(myView: UIView) {
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOpacity = 80
        myView.layer.shadowOffset = .init(width: 0.0, height: 1.0)
        myView.layer.shadowRadius = 2
        myView.layer.cornerRadius = 10
        myView.layer.borderWidth = 1
        myView.layer.borderColor = UIColor.brown.cgColor
    }
    
    func resetBox(myView: UIView) {
        myView.layer.borderColor = UIColor.brown.cgColor
        myView.backgroundColor = UIColor.white
    }
    
    func defaultLogic() -> [String]{
        let operators = ["+", "-", "*"].randomElement()!
        let number1 = Int.random(in: 7...24)
        let number2 = Int.random(in: 3..<number1)
        var answer = 0
        if (operators == "+") {
            answer = number1 + number2
        } else if (operators == "-") {
            answer = number1 - number2
        } else {
            answer = number1 * number2
        }
        let wrong1 = String(wrongAnswer(answer: answer))
        let wrong2 = String(wrongAnswer(answer: answer))
        let wrong3 = String(wrongAnswer(answer: answer))
        var choices = [wrong1, wrong2, wrong3, String(answer)].shuffled()
        choices.append(String(number1))
        choices.append(String(number2))
        choices.append(operators)
        choices.append(String(answer))
        return choices
    }
    
    func wrongAnswer(answer: Int) -> Int{
        let wrong = Int.random(in: 0...answer*2)
        if (wrong == answer) {
            return wrong + 1
        } else {
            return wrong
        }
    }
    
    func playAnswerSound(result: String) {
        var pathToSound = Bundle.main.path(forResource: "Sounds/wrong", ofType: "mp3")!
        if (result == "Correct") {
            pathToSound = Bundle.main.path(forResource: "Sounds/correct2", ofType: "mp3")!
        }
        let url = URL(fileURLWithPath: pathToSound)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
        }
    }
}

extension String {

    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }

}

