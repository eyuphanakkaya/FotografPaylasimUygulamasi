//
//  ViewController.swift
//  FotografPaylasimUygulamasi
//
//  Created by Eyüphan Akkaya on 16.03.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mailTextField: UITextField!
    
    @IBOutlet weak var sifreTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func girisYapTiklandi(_ sender: Any) {
        if mailTextField.text != "" && sifreTextField.text != ""
        {
            Auth.auth().signIn(withEmail: mailTextField.text!, password: sifreTextField.text!) { authdataresult, error in
                if error != nil {
                    self.hataMesaji(title: "Hata", message: error?.localizedDescription ?? "Lütfen Tekrar Deneyin")
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else {
            hataMesaji(title: "Hata", message: "Lütfen Mail ve Şifre Giriniz.")
        }

        
    }
    
    func hataMesaji (title : String , message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true,completion: nil)
    }
    
    
    @IBAction func kaydolTiklandi(_ sender: Any) {
        
        if mailTextField.text != "" && sifreTextField.text != "" {
            Auth.auth().createUser(withEmail: mailTextField.text!, password: sifreTextField.text!) { authdataresult, error in
                if error != nil {
                    self.hataMesaji(title: "Hata", message: error?.localizedDescription ?? "Tekrar Deneyiniz")
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }/**/
        }else
        {
            hataMesaji(title: "Hata", message: "Lütfen Mail ve Şifreyi Giriniz.")
        }
    }
    
    

}

