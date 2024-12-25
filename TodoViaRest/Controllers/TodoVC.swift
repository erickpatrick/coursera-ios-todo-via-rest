//
//  ViewController.swift
//  TodoViaRest
//
//  Created by Erick Rocha on 25.12.24.
//

import UIKit

class TodoVC: UIViewController {
    @IBOutlet weak var todoItem: UITextField!
    @IBOutlet weak var addTodo: UIButton!
    @IBOutlet weak var todoPriority: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkService.shared.getTodos()
    }

    @IBAction func addTodo(_ sender: Any) {
    }
    
}

