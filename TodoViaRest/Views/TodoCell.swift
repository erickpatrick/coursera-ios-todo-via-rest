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
    
    func updateCell(todo: Todo) {
        todoText.text = todo.item
        switch todo.priority {
        case 0:
            todoPriority.backgroundColor = .yellow
            break
        case 1:
            todoPriority.backgroundColor = .orange
            break
        case 2:
            todoPriority.backgroundColor = .red
            break
        default:
            todoPriority.backgroundColor = .gray
        }
    }

}
