//
//  TimeLineViewController.swift
//  LINEMemoFirebase
//
//  Created by Kiyoto Ryuman on 2019/05/06.
//  Copyright © 2019 Kiyoto Ryuman. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    var displayName = String()
    var comment = String()
    var pictureURLString = String()
    
    
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    var userName_Array = [String]()
    var comment_Array = [String]()
    var posts = [Post]()
    var posst = Post()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "引っ張って更新")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //データを取ってくる
        fetchData()
        //tableViewをリロード
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let userNameLabel = cell.viewWithTag(1) as! UILabel
        userNameLabel.text = self.posts[indexPath.row].userName
        
        let commentLabel = cell.viewWithTag(2) as! UILabel
        commentLabel.text = self.posts[indexPath.row].comment
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    @objc func refresh(){
        //Firebaseからデータを取得する
        fetchData()
        refreshControl.endRefreshing()
    }
    
    func fetchData(){
        
        self.userName_Array = [String]()
        self.comment_Array = [String]()
        self.posst = Post()
        
        
        let ref = Database.database().reference()
        ref.child("post").observeSingleEvent(of: .value) { (snap,error) in
            
            
            let postsSnap = snap.value as? [String:NSDictionary]
            
            if postsSnap == nil{
                return
            }
            
            self.posts = [Post]()
            
            for(_,post) in postsSnap!{
                
                self.posst = Post()
                
                if let comment = post["comment"] as? String,let userName = post["userName"] as? String{
                    
                    
                    
                    self.posst.comment = comment
                    self.posst.userName = userName
                    
                    self.comment_Array.append(self.posst.comment)
                    self.userName_Array.append(self.posst.userName)
                    
                }
                
                self.posts.append(self.posst)
            }
            
            self.tableView.reloadData()
            
            
        }
        
    }
    @IBAction func goPost(_ sender: Any) {
         self.performSegue(withIdentifier: "post", sender: nil)
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
