//
//  ViewController.swift
//  History Trivia
//
//  Created by Siddhesvar Kannan on 9/30/20.
//  Copyright © 2020 Siddhesvar Kannan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var scoreBox: UIView!
    @IBOutlet weak var gameBox: UIView!
    @IBOutlet weak var rewardBox: UIView!
    @IBOutlet weak var inventoryBox: UIView!
    @IBOutlet weak var coinCount: UILabel!
    @IBOutlet weak var rewardBG: UIView!
    @IBOutlet weak var rewardPage: UIView!
    @IBOutlet weak var prizePic: UIImageView!
    @IBOutlet weak var prizeText: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var rollBG: UIView!
    @IBOutlet weak var rollText: UILabel!
    
    let defaults = UserDefaults(suiteName: "group.com.Personal.SidHistoryTrivia")!
    var audioPlayer: AVAudioPlayer?
    let items = ["Archer", "Art Gator", "Blue Bird", "Bomb", "Cherries", "Chickens", "Doctor", "Easter Rabbit", "Eiffel Tower", "Fifty Cent", "Funny Frog", "Gingerbread Man", "Grilling Owl", "Hatted Turkey", "Haunted Castle", "Honey", "Lighthouse", "Mad Cow", "Mechanic", "Moose", "Parrot Pirate", "Peace Bird", "Piggy", "Pirate Flag", "Race Flag", "Racecar", "Rainbow Trout", "Robot", "Rocket", "Rose", "Rubber Duck", "Soccer Field", "Star Bear", "Sun Face", "Thumb Tack", "Tiki", "USB Drive"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rewardPage.isHidden = true
        stylize(myView: scoreBox)
        stylize(myView: gameBox)
        stylize(myView: inventoryBox)
        stylize(myView: rewardBox)
        setRolls()
        if (defaults.object(forKey: "coins") == nil) {
            defaults.set(0, forKey: "coins")
            defaults.set([String](), forKey: "stickers")
        }
        let coins = self.defaults.integer(forKey: "coins")
        coinCount.text = String(coins)
    }
    
    @IBAction func getReward(_ sender: Any) {
        let coins = self.defaults.integer(forKey: "coins")
        rewardPage.fadeIn(0.2)
        stylize(myView: rewardBG)
        stylize(myView: okButton)
        if (coins >= 10) {
            playPartySound()
            rewardBG.fadeIn(0.7)
            spendCoins(spend: 10)
            setRolls()
            getPrize()
        } else {
            rewardBG.fadeIn(0.5)
            setDefault()
        }
    }
    
    func spendCoins(spend: Int) {
        let coins = self.defaults.integer(forKey: "coins")
        defaults.set(coins-spend, forKey: "coins")
        coinCount.text = String(coins-spend)
    }
    
    @IBAction func returnHome(_ sender: Any) {
        rewardBG.fadeOut(0.2)
        rewardPage.fadeOut(0.3)
    }
    
    func getPrize() {
        var stickers = self.defaults.object(forKey: "stickers") as! [String]
        let newSticker = items.randomElement()!
        prizeText.text = "Congrats! You have just won the " + newSticker + "!"
        prizePic.image = UIImage(named: newSticker)
        if (!stickers.contains(newSticker)) {
            stickers.append(newSticker)
            defaults.set(stickers, forKey: "stickers")
        }
    }
    
    func setRolls() {
        let coins = self.defaults.integer(forKey: "coins")
        if (coins >= 10) {
            rollBG.isHidden = false
            rollBG.backgroundColor = UIColor.init(red: 1, green: 0.6, blue: 0.6, alpha: 1.0)
            rollBG.layer.cornerRadius = 20
            if (coins >= 100) {
                rollText.text = "9+"
            } else {
                rollText.text = String(Int(coins/10))
            }
        } else {
            rollBG.isHidden = true
        }
    }
    
    func setDefault() {
        let coins = self.defaults.integer(forKey: "coins")
        if (coins == 9) {
            prizeText.text = "You still need to collect 1 more coin to unlock a prize!"
        } else {
            prizeText.text = "You still need to collect " + String(10-coins) + " more coins to unlock a prize!"
        }
        prizePic.image = UIImage(systemName: "questionmark.square")
    }
    
    func playPartySound() {
        let pathToSound = Bundle.main.path(forResource: "Sounds/yayy2", ofType: "mp3")!
        let url = URL(fileURLWithPath: pathToSound)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
        }
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

}

