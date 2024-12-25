//
//  TodoCell.swift
//  TodoViaRest
//
//  Created by Erick Rocha on 25.12.24.
//

import UIKit

class TodoCell: UITableViewCell {
    @IBOutlet weak var todoText: UILabel!
    @IBOutlet weak var todoPriority: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
