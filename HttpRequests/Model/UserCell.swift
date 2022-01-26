//
//  NewCell.swift
//  HttpRequests
//
//  Created by Jagadeesh on 29/12/21.
//

import UIKit

/*jagadeesh commit*/
class UserCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userFirstName: UILabel!
    @IBOutlet weak var userLastName: UILabel!
    
   // var number = 123
    // sample commit

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
