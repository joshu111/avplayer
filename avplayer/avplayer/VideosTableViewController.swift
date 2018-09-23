//
//  VideosTableViewController.swift
//  avplayer
//
//  Created by Joshu Sonawane on 9/9/18.
//  Copyright © 2018 Joshu Sonawane. All rights reserved.
//

import UIKit

struct Video {
    var id:Int
    var title:String
    var source:String
    
}

var indexrow = 0

class VideosTableViewController: UITableViewController {

    var videos = [
        Video(id: 1, title: "Big Buck Bunny", source: "https://video-dev.github.io/streams/x36xhzz/x36xhzz.m3u8"),
        Video(id: 2, title: "Arte", source: "https://video-dev.github.io/streams/test_001/stream.m3u8")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath)

        cell.textLabel?.text = videos[indexPath.row].title
        

        return cell
    }
 

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Videos"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        
        //getting the current cell from the index path
        //let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        
        //getting the text of that cell
        //let currentItem = currentCell.textLabel!.text
        indexrow = (indexPath?.row)!
        //print(currentItem!, " ", self.videos[(indexPath?.row)!])
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            switch identifier{
            case "detail":
                let videoVC = segue.destination as! VideoViewController
                videoVC.url = videos[indexrow].source
                videoVC.videoTitle = videos[indexrow].title
            default:
                break
            }
        }
    }
    
    
}
