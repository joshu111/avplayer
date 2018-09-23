//
//  VideoViewController.swift
//  avplayer
//
//  Created by Joshu Sonawane on 9/9/18.
//  Copyright © 2018 Joshu Sonawane. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    var url:String = ""
    var videoTitle:String = ""
    var indexrow = 0
    var isPlayingPreview = false
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    @IBOutlet weak var Preview: UIView!
    @IBAction func reverse(_ sender: Any) {
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime - 10.0
        if newTime < 0 {
            newTime = 0
        }
        let time: CMTime = CMTimeMake(Int64(newTime*1000), 1000)
        player.seek(to: time)
    }
    @IBAction func Forward(_ sender: Any) {
        guard let duration = player.currentItem?.duration else {return}
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 10.0
        if newTime < (CMTimeGetSeconds(duration) - 10.0) {
            let time: CMTime = CMTimeMake(Int64(newTime*1000), 1000)
            player.seek(to: time)
        }
    }
    
    @IBAction func PlayVideo(_ sender: Any) {
        let videoURL = URL(string: url)
        let fsplayer = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = fsplayer
        playerViewController.title = videoTitle
        present(playerViewController, animated: true) {
            fsplayer.play()
        }
    }
    
    @IBOutlet weak var VDOtitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.VDOtitle.text = videoTitle
        
        let vdourl = URL(string: url)!
        player = AVPlayer(url: vdourl)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        //player.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
        //addTimeObserver()
        Preview.layer.addSublayer(playerLayer)
        
        
        //single tap
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTapGesture.numberOfTapsRequired = 1
        Preview.addGestureRecognizer(singleTapGesture)
        // Double Tap
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        Preview.addGestureRecognizer(doubleTapGesture)
    }
    @IBAction func BackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("disapper")
        pausePreview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("appear")
        player.volume = 0.0
        playPreview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = Preview.bounds
    }
    // single tap action
    @objc func handleSingleTap() {
        print("single tap")
        if isPlayingPreview{
            pausePreview()
        }
        else{
            playPreview()
        }
        
    }
    // Double tap action
    @objc func handleDoubleTap() {
        print("doble tap")
        self.handleSingleTap()
        player.volume = player.volume == 1.0 ? 0.0 : 1.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func playPreview() -> Void {
        isPlayingPreview = true
        player.play()
    }
    func pausePreview() -> Void {
        isPlayingPreview = false
        player.pause()
    }
   

}
