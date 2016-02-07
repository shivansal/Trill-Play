//
//  MyCell.swift
//  SocketIOTester
//
//  Created by Gagan Kaushik on 1/30/16.
//  Copyright © 2016 gk. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class MyCell: UITableViewCell {

    @IBOutlet weak var upvoteCount: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var upvoteButton: UIButton!
    
    var username = ""
    var upvoteNumber = 0
    var songNumber = 0
    var parent: MyTable? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        selectionStyle = UITableViewCellSelectionStyle.None
        
      //  self.upvoteCount.text = "\(self.upvoteNumber)"
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func upvoteTapped(sender: AnyObject) {
        print("sending data")
        
        let dict: [String: AnyObject] = [
            "user":username,
            "removeSong":false,
            "vote": true,
            "song": songName.text!
        ]
        
        Alamofire.request(.POST, "http://10.69.178.157:12000", parameters: dict, encoding: .JSON)
        
        upvoteNumber += 1
        upvoteCount.text = "\(upvoteNumber)"
        
        if parent != nil{
            parent!.reloadJson()
            parent!.songNumber = 0
            parent!.done = false
            parent!.tableView.reloadData()
        }
    }
    
}
