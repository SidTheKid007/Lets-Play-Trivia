//
//  InventoryController.swift
//  History Trivia
//
//  Created by Siddhesvar Kannan on 10/2/20.
//  Copyright © 2020 Siddhesvar Kannan. All rights reserved.
//

import UIKit

class InventoryController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var scoreBox: UIView!
    @IBOutlet weak var coinCount: UILabel!
    @IBOutlet weak var homeBox: UIImageView!
    @IBOutlet weak var stickerPage: UIView!
    @IBOutlet weak var stickerBG: UIView!
    @IBOutlet weak var stickerGround: UIView!
    @IBOutlet weak var stickerName: UILabel!
    @IBOutlet weak var stickerPic: UIImageView!
    @IBOutlet weak var descriptionBox: UIView!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    let defaults = UserDefaults(suiteName: "group.com.Personal.SidHistoryTrivia")!
    let reuseIdentifier = "cell"
    let descriptions = ["With a bag of arrows on his back, this green man is always ready to strike. Take a bow for the archer.",
    "He is the modern day picasso of the cartoon animal world. See you later aligator.",
    "His less attractive cousin is world famous for being the icon of a certain social media app.",
    "Watch out everyone for this guy is really the bomb! Be careful because you never know when he will blow.",
    "A cherrific way to start the day, cherries are loaded with antioxidants and vitamin A.",
    "Bok bok bok bok. It is a well known fact that chickens can not speak english.",
    "Are you ready for your checkup? The doctor is here and he ready to check your temperature.",
    "Hippity Hoppity. You better watch out. This easter bunny is coming for your property.",
    "This bad boy stands at over a 1000 feet tall in the center of a famous City of Love. Las Vegas.",
    "Often confused with a rapper of the same name, this 50 cent is different. He's from Europe.",
    "This frog is unfroggetable because of his charm and his ribbeting sense of humor.",
    "Although this cookie man looks sweet, appearances can be decieving. His personality is as flat as his body.",
    "Sausages aren't the only thing that this owl can smoke. He's coming to smoke you at trivia with his wisdom next.",
    "This Turkey stole some mechanic's hat, and now he's the mascot of an American holiday.",
    "Legends say that the mysterious light is coming from ghosts. It must be nice to be a ghost and not pay for electricity.",
    "Sweeter than a bag of sugar, and stickier than a glue stick, this honey is ready to smother you with it's health benefits.",
    "Although its called a lighthouse, this building is actually pretty heavy.",
    "Even though this cow appears to be smiling right now, he is one mad cow. Just look into his eyes.",
    "Some turkey stole this guy's old hat. Now he has to wear his other red hat.",
    "If you ask him if his favorite desert is mousse, he will say no. That's because it is actually cheesecake.",
    "This bird has one goal. Watch out everyone. He will become the pirate king!",
    "This Bird must eat a lot of peas. That is why it is peasfull.",
    "This pig heeps hogging all the grass from the cow. This might make the cow mad.",
    "This flag is a sure signal that the future king of pirates is coming.",
    "On your marks! Get Set! Go! Now that the flag has been waved, the race is on.",
    "Speed is this car's middle name. The only race this car dislikes is racism.",
    "There's something fishy about how this trout has different colored scales.",
    "There are only 10 types of people in the world: Those who understand binary, and those who don’t.",
    "One small step for man. One giant leap for rocketkind. Up up and away.",
    "A rose by any other name would smell as sweet - Shakespeare",
    "He needs rehab because he is addicted to quack.",
    "Some say soccer. Some say football. No matter what, you'll surely get a kick out of this sticker.",
    "This bear has followed this little red star all the way to the flag of California.",
    "The great Sun Face is here. And he is watching you.",
    "Watch out for the tack! Step on it, and you might break your back.",
    "This Tiki sure is Freaky!",
    "What mysteries are held inside this USB Drive. The world may never know."]
    var items = ["Archer", "Art Gator", "Blue Bird", "Bomb", "Cherries", "Chickens", "Doctor", "Easter Rabbit", "Eiffel Tower", "Fifty Cent", "Funny Frog", "Gingerbread Man", "Grilling Owl", "Hatted Turkey", "Haunted Castle", "Honey", "Lighthouse", "Mad Cow", "Mechanic", "Moose", "Parrot Pirate", "Peace Bird", "Piggy", "Pirate Flag", "Race Flag", "Racecar", "Rainbow Trout", "Robot", "Rocket", "Rose", "Rubber Duck", "Soccer Field", "Star Bear", "Sun Face", "Thumb Tack", "Tiki", "USB Drive"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stylize(myView: homeBox)
        stylize(myView: scoreBox)
        let coins = self.defaults.integer(forKey: "coins")
        coinCount.text = String(coins)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        let unlocked = self.defaults.object(forKey: "stickers") as! [String]
        
        if (unlocked.contains(self.items[indexPath.row])) {
            cell.icon.image = UIImage(named: self.items[indexPath.row])
            cell.title.text = self.items[indexPath.row]
        } else {
            cell.icon.image = UIImage(systemName: "questionmark.square")
            cell.title.text = "???"
        }
        
        cell.backgroundColor = UIColor.white
        stylize(myView: cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = items[indexPath.item]
        let unlocked = self.defaults.object(forKey: "stickers") as! [String]
        if (unlocked.contains(selected)) {
            stickerName.text = selected
            stickerPic.image = UIImage(named: selected)
            descriptionText.text = descriptions[indexPath.item]
            stickerPage.fadeIn(0.2)
            stylize(myView: stickerBG)
            stickerBG.layer.borderColor = UIColor.white.cgColor
            stickerGround.layer.cornerRadius = 10
            stylize(myView: descriptionBox)
            stylize(myView: okButton)
        }
    }
    
    @IBAction func returnHome(_ sender: Any) {
        stickerPage.fadeOut(0.2)
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
