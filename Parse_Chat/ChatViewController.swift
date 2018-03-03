//
//  ChatViewController.swift
//  Parse_Chat
//
//  Created by Bijesh Subedi on 2/27/18.
//  Copyright © 2018 Bijesh Subedi. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var messages: [PFObject] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    @IBAction func onSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageField.text
        chatMessage["user"] = PFUser.current()
        
        // Saving the text message
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onTimer() {
        fetchMessages()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func fetchMessages(){
        let query = PFQuery(className: "Message")
        query.includeKey("text")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { (messages: [PFObject]?, error: Error?) -> Void in
            self.messages = messages!
            if (error == nil) {
                print("Successfully fetched Data")
            } else {
                print ("Error while fetching messages")
            }
            self.tableView.reloadData()
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCell
        cell.message = messages[indexPath.row]
        return cell
    }

}
