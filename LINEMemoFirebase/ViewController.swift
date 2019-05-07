//
//  ViewController.swift
//  LINEMemoFirebase
//
//  Created by Kiyoto Ryuman on 2019/05/06.
//  Copyright © 2019 Kiyoto Ryuman. All rights reserved.
//

import UIKit
import LineSDK
class ViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func login(_ sender: Any) {
        LoginManager.shared.login(permissions: [.profile], in: self) {
            result in
            switch result {
            case .success(let loginResult):
                guard let profile = loginResult.userProfile else {
                    print("profile 取得失敗")
                    return
                }
                
                self.setProfile(profile)
                self.performSegue(withIdentifier: "next", sender: nil)
                
            case .failure(let error):
                print(error)
                return
            }
        }
    }
    
    func setProfile(_ profile: UserProfile) {
        UserDefaults.standard.set(profile.displayName, forKey: "displayName")
        UserDefaults.standard.set(profile.pictureURL?.absoluteString ?? "", forKey: "pictureURLString")
    }
    
}

