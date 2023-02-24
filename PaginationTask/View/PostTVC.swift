//
//  PostTVC.swift
//  PaginationTask
//
//  Created by Aniket Rao on 24/02/23.
//

import UIKit

class PostTVC: UITableViewCell {
    
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblURL: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.lightGray.cgColor
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(hit : Hit){
        lblURL.text = hit.url
        lblTitle.text = hit.title
        lblAuthorName.text = hit.author
    }
    
}
