//
//  BrowserViewController.swift
//  Trivia Stickers
//
//  Created by Siddhesvar Kannan on 10/8/20.
//  Copyright © 2020 Siddhesvar Kannan. All rights reserved.
//

import UIKit
import Messages

class BrowserViewController: MSStickerBrowserViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadStickers()
    }
    
    var stickers = [MSSticker]()
    
    func loadStickers() {
        var newStickers = [try! MSSticker(item: "Mike Guy")]
        let defaults = UserDefaults(suiteName: "group.com.Personal.SidHistoryTrivia")!
        if (defaults.object(forKey: "stickers") != nil) {
            var stickerStrings = defaults.object(forKey: "stickers") as? [String]
            stickerStrings!.sort()
            for stickerString in stickerStrings! {
                newStickers.append(try! MSSticker(item: stickerString))
            }
        }
        stickers = newStickers
    }
    
    override func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
      return stickers.count
    }

    override func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView,
                                     stickerAt index: Int) -> MSSticker {
      return stickers[index]
    }

}

extension MSSticker{

  convenience init(item: String) throws{
    try self.init(contentsOfFileURL:
      Bundle.main.url(forResource: item, withExtension: "png")!,
                  localizedDescription: item)
  }
}
