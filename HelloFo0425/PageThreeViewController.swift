//
//  PageThreeViewController.swift
//  HelloFo0425
//
//  Created by 申潤五 on 2020/4/25.
//  Copyright © 2020 申潤五. All rights reserved.
//

import UIKit
import Firebase

class PageThreeViewController: UIViewController {

    var foTitle = ""
    var foKey = ""
    
    var ref:DatabaseReference!
    
    
    @IBOutlet weak var msgTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = foTitle
        
        ref = Database.database().reference()
        
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
