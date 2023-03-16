//
//  SettingsViewController.swift
//  FotografPaylasimUygulamasi
//
//  Created by Eyüphan Akkaya on 16.03.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cikisTiklandi(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toSettingsVC", sender: nil)
        } catch {
            print("hata")
        }
        
       
    }
    
}
