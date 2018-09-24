//
//  MessageListTableViewController.swift
//  BulletinBoardCK2
//
//  Created by Ivan Ramirez on 9/24/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class MessageListTableViewController: UITableViewController {
    @IBOutlet weak var messageTextField: UITextField!
    
    
    let formatter: DateFormatter = {
       var dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //observer: what class or object i want to be listening for. in this example self means MessageListTableViewController
        //selector: what its going to trigger. needs a func
        //messageControl.shar..messwereupdated.. is the schol bell were are listening for
        NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: MessageController.shared.messagesWereUpdatedNotification, object: nil)
        
        // swirlly wheel in status bar is active or not
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        //this will fetch our entries when we re-open our app
        MessageController.shared.fetchAllMessageRecordsFromCloudKit()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MessageController.shared.messages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)

       let message = MessageController.shared.messages[indexPath.row]
        cell.textLabel?.text = message.text
        //needs date formater
        cell.detailTextLabel?.text = formatter.string(from: message.timeStamp)
        return cell
    }
    
    //this is going to be used the selector for a notification syntax above
    //needs the @objc
    //this will be called in the notifcation.default... view did load function
    @objc func updateView(){
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.tableView.reloadData()
    }
    }
    @IBAction func postMessageButtonTapped(_ sender: Any) {
        //guarding against it being empty
        guard let messageText = messageTextField.text,  !messageText.isEmpty else {return}
        MessageController.shared.createMessage(text: messageText)
        tableView.reloadData()
        messageTextField.text = ""
        messageTextField.resignFirstResponder()
    }
    
}
