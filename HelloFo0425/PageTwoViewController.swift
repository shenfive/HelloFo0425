//
//  PageTwoViewController.swift
//  HelloFo0425
//
//  Created by 申潤五 on 2020/4/25.
//  Copyright © 2020 申潤五. All rights reserved.
//

import UIKit

class PageTwoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    var nickName = ""
    
    @IBOutlet weak var foTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.title = "討論區清單"
        foTableView.delegate = self
        foTableView.dataSource = self
    }
   
    
    
    //MARK:TableView Delegate & DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "line:\(indexPath.row)"
        return cell
    }
    

}
