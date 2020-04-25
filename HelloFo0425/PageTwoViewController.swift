//
//  PageTwoViewController.swift
//  HelloFo0425
//
//  Created by 申潤五 on 2020/4/25.
//  Copyright © 2020 申潤五. All rights reserved.
//

import UIKit
import Firebase

class PageTwoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    var ref:DatabaseReference!
    var nickName = ""
    var selectedID = 0
    
    var subs:[[String:String]] = []
    @IBOutlet weak var foTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.title = "討論區清單"
        foTableView.delegate = self
        foTableView.dataSource = self
        ref = Database.database().reference().child("subs")
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            self.subs.removeAll()
            for item in snapshot.children{
                if let itemSnap = item as? DataSnapshot{
                    let sub = itemSnap.childSnapshot(forPath: "sub").value as! String
                    let key = itemSnap.key
                    self.subs.append(["key":key,"sub":sub])
                }
            }
            self.foTableView.reloadData()
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goPage3":
            let nextVC = segue.destination as! PageThreeViewController
            
            
            
            nextVC.foTitle = subs[selectedID]["sub"] ?? ""
            nextVC.foKey = subs[selectedID]["key"] ?? ""
        default:
            break
        }
    }
    
    
    //MARK:TableView Delegate & DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = subs[indexPath.row]["sub"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedID = indexPath.row
        performSegue(withIdentifier: "goPage3", sender: self)
    }
    
    

}
