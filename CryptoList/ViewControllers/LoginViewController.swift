//
//  LoginViewController.swift
//  CryptoList
//
//  Created by Мирсаит Сабирзянов on 3/11/23.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var tapBarItem = UITabBarItem()
        tapBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_svg"), tag: 2)
        self.tabBarItem = tapBarItem



    }
    
    @IBAction func didLoginTapped(){
        let dialogMessage = UIAlertController(title: "Coming soon!", message: "We will be adding this feature very soon. Stay tuned for more app updates", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }

}
