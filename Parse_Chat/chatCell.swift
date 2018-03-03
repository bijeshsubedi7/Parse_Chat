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
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var chatLabel: UILabel!
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
