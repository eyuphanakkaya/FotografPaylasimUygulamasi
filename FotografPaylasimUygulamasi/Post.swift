//
//  Post.swift
//  FotografPaylasimUygulamasi
//
//  Created by Eyüphan Akkaya on 17.03.2023.
//

import Foundation

class Post {
    var yorum : String
    var email : String
    var gorselUrl : String
    
    
    init(yorum: String , email: String , gorselUrl: String ) {
        self.yorum = yorum
        self.email = email
        self.gorselUrl = gorselUrl
    }
    
}
