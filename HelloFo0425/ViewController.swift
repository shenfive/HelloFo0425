//
//  ViewController.swift
//  HelloFo0425
//
//  Created by 申潤五 on 2020/4/25.
//  Copyright © 2020 申潤五. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var ref:DatabaseReference!
    var db:Database!
    
    @IBOutlet weak var nickNameTF: UITextField!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var startBut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        Auth.auth().signInAnonymously { (result, error) in
            if error != nil{
                print("無法登入:\(error?.localizedDescription)")
            }else{
                print("登入成功")
            }
        }
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil{
                self.status.text = "己連線"
            }else{
                self.status.text = "未連線"
            }
        }
        
        
        
        db = Database.database()
        ref = db.reference()
                
        

    }
    @IBAction func goNextPage(_ sender: Any) {
    }
    

}

