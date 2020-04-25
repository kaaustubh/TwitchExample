//
//  VideoPlayerController.swift
//  TwitchExample
//
//  Created by Kaustubh on 25/04/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import Foundation
import UIKit
import SwiftTwitch
import TwitchPlayer

class VideoPlayerController: UIViewController {
    var currentVideoIndex = 0
    var videos = [VideoData]()
    @IBOutlet weak var twitchPlayer: TwitchPlayer!
    @IBAction func nextButtonPress(_ sender: Any) {
        playCurrentVideo()
    }
    
    private func playCurrentVideo() {
        
        twitchPlayer.setVideo(to: videos[currentVideoIndex].id, timestamp: 0)
        
        twitchPlayer.play()
        print("Playing video- " + videos[currentVideoIndex].id)
        currentVideoIndex += 1
        if currentVideoIndex == videos.count {
            currentVideoIndex = 0
        }
    }
    
    override func viewDidLoad() {
        playCurrentVideo()
    }
    
}
