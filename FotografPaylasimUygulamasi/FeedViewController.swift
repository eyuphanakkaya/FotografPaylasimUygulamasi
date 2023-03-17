//
//  FeedViewController.swift
//  FotografPaylasimUygulamasi
//
//  Created by Eyüphan Akkaya on 16.03.2023.
//

import UIKit
import Firebase
import SDWebImage



class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    /*var gorselUrlDizi = [String]()
    var yorumDizi = [String]()
    var mailDizi = [String]  ()
    */
    var postDizi = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        verileriGoster()
        // Do any additional setup after loading the view.
    }
    func verileriGoster() {
        let firestoreDataBase = Firestore.firestore()
        firestoreDataBase.collection("Post").order(by: "tarih", descending: true).addSnapshotListener { snapshot, error in/*koleysion bizim veritabanı adını ister*/ /*addsnapshot ise bizim anlık veri çekmemizi sağlar*/
            if error != nil {
                print(error?.localizedDescription)
            }else {
            if  snapshot?.isEmpty != true && snapshot != nil {
                
                //self.mailDizi.removeAll(keepingCapacity: false)
                //self.gorselUrlDizi.removeAll(keepingCapacity: false)
                //self.yorumDizi.removeAll(keepingCapacity: false)
                self.postDizi.removeAll(keepingCapacity: false)
                
                for document in snapshot!.documents {/*döküman bize dizi değeri döndürüyo  for kullanarak içerisindeki değerleri döndürmemizi sağlıyoruz*/
                    let id = document.documentID
                    if let yorum = document.get("yorum") as? String{
                        if let mail = document.get("email")  as? String{
                            if let gorselUrl = document.get("gorselUrl") as? String{
                                
                                var post =  Post(yorum: yorum, email: mail, gorselUrl: gorselUrl)
                                self.postDizi.append(post)
                                
                            }
                        }
                    }
                  
                    
                    //document.get("gorselUrl")
                    
                   
                }
                self.tableView.reloadData()
                }
            }
        }
    }
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDizi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell /*feed cell view ine ulaşmamızı sağlar */
        cell.emailText.text = postDizi[indexPath.row].email
        cell.yorumText.text = postDizi[indexPath.row].yorum
        cell.imageViewCell.sd_setImage(with: URL(string: self.postDizi[indexPath.row].gorselUrl))
 
        return cell
    }
    

  

}
