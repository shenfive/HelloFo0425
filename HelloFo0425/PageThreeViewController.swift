//
//  PageThreeViewController.swift
//  HelloFo0425
//
//  Created by 申潤五 on 2020/4/25.
//  Copyright © 2020 申潤五. All rights reserved.
//

struct MsgStruct {
    var msg:String
    var nickname:String
    var data:Date
}

import UIKit
import Firebase

class PageThreeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var foTitle = ""
    var foKey = ""
    var dataArray:[MsgStruct] = []
    var ref:DatabaseReference!
    
    
    @IBOutlet weak var msgTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = foTitle
        ref = Database.database().reference()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        ref.child("disc").child(foKey).observe(.value) { (snapshot) in
            self.dataArray.removeAll()
            for item in snapshot.children{
                if let itemSnap = item as? DataSnapshot{
                    print(itemSnap)
                    if let msg = itemSnap.childSnapshot(forPath: "msg").value as? String,
                        let nickname = itemSnap.childSnapshot(forPath: "nickname").value as? String,
                        let time = itemSnap.childSnapshot(forPath: "time").value as? Double{
                        let date = Date.init(timeIntervalSince1970: time/1000)
                        let theMsg = MsgStruct(msg: msg, nickname: nickname, data: date)
                        self.dataArray.append(theMsg)
                        print("data:\n\(msg)\n\(nickname)\n\(time)\n\n")
                    }
                }
            }
            self.tableView.reloadData()
        }
        
        
        
    }
    
    //MARK:TableView Delegate & DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "theMsgCell") as! MyTableViewCell
        cell.nickName.text = dataArray[indexPath.row].nickname
        cell.msgLabel.text = dataArray[indexPath.row].msg
        cell.dateLabel.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    

    @IBAction func newMsg(_ sender: Any) {
        let msg = msgTF.text ?? ""
        if msg.count < 2 {
            showMsg(msg: "請輸入兩個字元以上的訊息")
            return
        }
        let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
        
        
        let itemRef = ref.child("disc").child(foKey).childByAutoId()
        let content:[String : Any] = ["msg":msg,"nickname":nickname,"time":ServerValue.timestamp()]
        itemRef.setValue(content)
        
        
        
    }
    

}
