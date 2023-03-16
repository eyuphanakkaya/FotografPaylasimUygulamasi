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
    
    @IBOutlet weak var yorumTextField: UITextField!
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
        let uuid = UUID().uuidString
        let storage = Storage.storage()
        let referance = storage.reference()/*referans bize bulunduğumuz konumu belirtir*/
        let mediaFolder = referance.child("media")//media adında bir klasör açmamıza yarar
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){/*imageview ı dataya çeviriyoruz*/
            let imageReferance = mediaFolder.child("\(uuid).jpg")/*media folderın içerisine image.jpeg diye bir dosya oluşturdu.*/
            
            
            
            imageReferance.putData(data) { storagemetadata, error in
                if error != nil {
                    self.hataMesaji(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Lütfen Tekrar Deneyin")
                }else{//urlsinin almak için
                    imageReferance.downloadURL { url, error in /*imagereferansın içerisindeki urlyi indir */
                        if error == nil {
                            let imageUrl = url?.absoluteString /*urlnin stringe çevrilmiş hali*/
                            if let imageUrl = imageUrl {
                                
                                let firestoreDatabase = Firestore.firestore()/*firestore u çağırıyoruz.*/
                                let firestorePost = ["gorselUrl" : imageUrl, "yorum" : self.yorumTextField.text!,"email" : Auth.auth().currentUser?.email,"tarih" :FieldValue.serverTimestamp()/*anlık zamanı verir*/] as! [String : Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) { error in
                                    if error != nil {
                                        self.hataMesaji(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata Aldınız Tekrar Deneyin.")
                                    }else {
                                        
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }

            } /*image referansın içerisine veriyi koy */
        }
        
    func hataMesaji(titleInput : String,messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
        
    }
    

    


