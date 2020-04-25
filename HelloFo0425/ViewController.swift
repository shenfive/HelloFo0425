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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().signInAnonymously { (result, error) in
            if error != nil{
                print("無法登入:\(error?.localizedDescription)")
            }else{
                print("登入成功")
            }
        }
        
        ref = Database.database().reference()
        
        ref.child("appdefult").child("codename").observeSingleEvent(of: .value) { (snapshot) in
            print("codename is :\(snapshot.value as! String)")
        }
        
        
        
    }


}

