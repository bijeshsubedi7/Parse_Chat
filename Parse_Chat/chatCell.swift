//
//  ChatCell.swift
//  Parse_Chat
//
//  Created by Bijesh Subedi on 3/3/18.
//  Copyright © 2018 Bijesh Subedi. All rights reserved.
//

import Parse
import UIKit

class ChatCell: UITableViewCell {
    
    
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var usernameHeight: NSLayoutConstraint!
    
    var show = true
    
    var message: PFObject!{
        didSet{
            if ((message["text"]) != nil){
                chatLabel.text = message["text"] as? String
            }
            if ((message["user"]) != nil){
                let user = message["user"] as! PFUser
                usernameLabel.text = user.username
            } else {
                usernameLabel.text = "__"
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        chatView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.toggleUser))
        chatView.addGestureRecognizer(tapGesture)
    }
    
    @objc func toggleUser(){
        if (!show){
            usernameHeight.constant = 30
            show = true
        } else {
            usernameHeight.constant = 0
            show = false
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
