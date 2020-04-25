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

        if let lastInputName = UserDefaults.standard.value(forKey: "nickname") as? String{
            nickNameTF.text = lastInputName
        }
        
        
        self.title = "首頁"
        
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
                self.startBut.isEnabled = true
            }else{
                self.status.text = "未連線"
                self.startBut.isEnabled = false
            }
        }
        
        db = Database.database()
        ref = db.reference()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        switch segue.identifier {
        case "goPage2":
            let nextVC = segue.destination as! PageTwoViewController
            nextVC.nickName = self.nickNameTF.text ?? ""
        default:
            break
        }
    }
    
    
    
    @IBAction func goNextPage(_ sender: Any) {
        guard let nickname = nickNameTF.text else { return }
        
        if nickname.count < 2 {
            showMsg(msg: "必需輸入兩個以上字元")
            return
        }
        
        
        UserDefaults.standard.set(nickname, forKey: "nickname")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "goPage2", sender: self)
    }
}

extension UIViewController{
    func showMsg(msg:String){
        let alert = UIAlertController(title: "通知", message: msg, preferredStyle: .alert)
        let okBut = UIAlertAction(title: "我知道了", style: .default, handler: nil)
        alert.addAction(okBut)
        self.present(alert, animated: true, completion: nil)
    }
}

