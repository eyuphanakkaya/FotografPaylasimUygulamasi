//
//  FeedCell.swift
//  FotografPaylasimUygulamasi
//
//  Created by Eyüphan Akkaya on 17.03.2023.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var emailText: UILabel!
    
    
    @IBOutlet weak var imageViewCell: UIImageView!
    
    
    @IBOutlet weak var yorumText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
