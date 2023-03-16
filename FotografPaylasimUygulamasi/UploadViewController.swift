//
//  UploadViewController.swift
//  FotografPaylasimUygulamasi
//
//  Created by Eyüphan Akkaya on 16.03.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var aciklamaTextField: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gorselGostureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gorselTikla))
        imageView.addGestureRecognizer(gorselGostureRecognizer)

        // Do any additional setup after loading the view.
    }
    
    @objc func gorselTikla(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true,completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    

    @IBAction func kaydetTiklandi(_ sender: Any) {
         
        let storage = Storage.storage()
        
        
    }
    

}
