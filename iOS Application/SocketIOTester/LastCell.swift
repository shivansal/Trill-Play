//
//  LastCell.swift
//  SocketIOTester
//
//  Created by Gagan Kaushik on 1/31/16.
//  Copyright © 2016 gk. All rights reserved.
//

import UIKit
import Alamofire

class LastCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    var username = ""
    var parent: MyTable? = nil
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.delegate = self
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(field:UITextField) -> Bool{
        field.resignFirstResponder()
        suggestSong()
        return true;
    }
    
    func suggestSong(){
        let dict: [String: AnyObject] = [
            "user": username,
            "removeSong": false,
            "vote": false,
            "song": textField.text!
        ]
        
        Alamofire.request(.POST, "http://10.69.178.157:12000", parameters: dict, encoding: .JSON)
        
        if parent != nil{
            parent!.reloadJson()
            parent!.songNumber = 0
            parent!.done = false
            parent!.tableView.reloadData()
        }
        
        
    }
}
