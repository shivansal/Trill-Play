//
//  ViewController.swift
//  SocketIOTester
//
//  Created by Gagan Kaushik on 1/29/16.
//  Copyright © 2016 gk. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    var json: JSON? = nil
    
    @IBAction func loginTapped(sender: AnyObject) {
        
        Alamofire.request(.GET, "http://10.69.178.157:12000/"+textField.text!).responseJSON{response in
            if let value = response.result.value{
                self.json = JSON(value)
                print(self.json!)
                
                // starts segue
                self.performSegueWithIdentifier("mySegue", sender: nil)
            }
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
        let str = NSAttributedString(string: "Enter host name", attributes: [NSForegroundColorAttributeName: UIColor(red:232/255.0, green:236/255.0, blue:238/255.0, alpha:0.6)])
        textField.attributedPlaceholder = str
    }
    
    func textFieldShouldReturn(field:UITextField) -> Bool{
        field.resignFirstResponder()
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!){
        if(segue.identifier == "mySegue"){
            let svc = segue.destinationViewController as! MyCollectionViewController
            svc.username = textField.text!
            svc.json = self.json!
        }
    }
}

