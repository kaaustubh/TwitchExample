//
//  ViewController.swift
//  TwitchExample
//
//  Created by Kaustubh on 25/04/20.
//  Copyright © 2020 KaustubhtestApp. All rights reserved.
//

import UIKit
import SwiftTwitch
import NVActivityIndicatorView

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var activityIndicator : NVActivityIndicatorView!
    var videos = [VideoData]() {
        didSet {
            self.tableView.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = NVActivityIndicatorView(frame: self.view.frame, type: .ballRotate, color: .black, padding: .none)
        self.fetchToken()
        // Do any additional setup after loading the view.
    }
    
    func fetchToken() {
        activityIndicator.startAnimating()
        TokenManager.shared.getToken(completion: {[weak self] token, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            guard let token = token else { return }
            if token.count > 0 && error == nil {
                TwitchTokenManager.shared.accessToken = token
                self.fetchVideos()
            }
            }
        })
    }
    
    func fetchVideos() {
        activityIndicator.startAnimating()
        Twitch.Videos.getVideos(videoIds: nil, userId: "60056333", gameId: nil, completionHandler: {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let getVideosData):
                DispatchQueue.main.async {
                    self.videos = getVideosData.videoData
                    self.activityIndicator.stopAnimating()
                }
               
            case .failure(let data, _, _):
                print("The API call failed! Unable to get videos. Did you set an access token?")
                if let data = data,
                    let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                    let jsonDict = jsonObject as? [String: Any]{
                    print(jsonDict)
                }
                DispatchQueue.main.async {
                    self.videos = [VideoData]()
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }
}


extension ViewController: UITableViewDataSource {
    /// Retrieves the number of cells to display; this is equal to the number of videos we have.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    /// Whenever the cell is selected, open the Twitch URL to that video
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoData = videos[indexPath.row]
        UIApplication.shared.openURL(videoData.url)
    }
    
    /// Retrieve a TwitchVideoTableViewCell with the reuse identifier "twitchyCell". Its video data
    /// should be set to the video at the index path specified.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "twitchyCell"),
            let twitchCell = cell as? TwitchVideoTableViewCell else {
            fatalError("Unable to dequeue a TwitchVideoTableViewCell!")
        }
        twitchCell.videoData = videos[indexPath.row]
        return twitchCell
    }
}
