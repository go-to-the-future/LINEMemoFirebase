//
//  PostViewController.swift
//  LINEMemoFirebase
//
//  Created by Kiyoto Ryuman on 2019/05/07.
//  Copyright © 2019 Kiyoto Ryuman. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
class PostViewController: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var displayName = String()
    var pictureURLString = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        displayName = UserDefaults.standard.object(forKey: "displayName") as! String
        
         pictureURLString = UserDefaults.standard.object(forKey: "pictureURLString") as! String
        // Do any additional setup after loading the view.
        
        nameLabel.text = displayName
        profileImageView.sd_setImage(with: URL(string: pictureURLString), completed: nil)
        profileImageView.layer.cornerRadius = 8.0
        profileImageView.clipsToBounds = true
    }
    
    @IBAction func post(_ sender: Any) {
        let rootRef = Database.database().reference(fromURL: "https://linememofirebase.firebaseio.com/").child("post").childByAutoId()
        let feed = ["comment":textField.text!,"userName":nameLabel.text!] as [String:Any]
        rootRef.setValue(feed)
        dismiss(animated: true, completion: nil)
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
