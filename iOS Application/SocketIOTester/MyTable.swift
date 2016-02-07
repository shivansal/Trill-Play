///Users/gagan/Desktop/SocketIOTester/SocketIOTester.xcodeproj
//  MyTable.swift
//  SocketIOTester
//
//  Created by Gagan Kaushik on 1/30/16.
//  Copyright © 2016 gk. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MyTable: UITableViewController {
    var username: String = ""
    var json: JSON = JSON.null
    var songNumber = 0
    var done = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TABLE VIEW LOADED")
        self.tableView.registerNib(UINib(nibName: "LastCell", bundle: nil), forCellReuseIdentifier: "LastCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if json != nil{
            return json["playlist"].count //+ 1
        }else{
            print("json is nil")
            return 0
        }
        
    }
    
    func reloadJson(){
        Alamofire.request(.GET, "http://10.69.178.157:12000/"+username).responseJSON{response in
            if let value = response.result.value{
                self.json = JSON(value)
                print(self.json)
            }
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if !done{
            let cell = tableView.dequeueReusableCellWithIdentifier("LastCell", forIndexPath: indexPath) as! LastCell
            
            cell.username = self.username
            cell.parent = self
            
            done = true
            
            self.tableView.registerNib(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "MyCell")
            
            return cell
            
        }else{
            
            self.tableView.registerNib(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "MyCell")
            
            
            let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! MyCell
        
            
            let dict = json["playlist"][songNumber]
        
            for (key, value) in dict{
                print("\(key):\(value)")
            }
            cell.parent = self
            cell.songNumber = self.songNumber
            cell.username = self.username
            cell.upvoteButton.adjustsImageWhenHighlighted = true
            cell.songName.text = dict["song_name"].string
            
            if let str = dict["artwork"].string{
                if let url = NSURL(string: str){
                    if let data = NSData(contentsOfURL: url){
                        cell.albumCover.image = UIImage(data: data)
                    }
                }
            }
            
            cell.upvoteNumber = dict["vote_count"].intValue
            cell.upvoteCount.text = "\(cell.upvoteNumber)"
            // Configure the cell...
            songNumber += 1
        
            return cell
            
        }
    }

}
