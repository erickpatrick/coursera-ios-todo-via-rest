//
//  ViewController.swift
//  TodoViaRest
//
//  Created by Erick Rocha on 25.12.24.
//

import UIKit

class TodoVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var todoItem: UITextField!
    @IBOutlet weak var addTodo: UIButton!
    @IBOutlet weak var todoPriority: UISegmentedControl!
    @IBOutlet weak var todoTable: UITableView!
    
    var todos: [Todo] = []
    var apiErrorMessage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTable.delegate = self
        todoTable.dataSource = self
        
        getTodos()
    }

    @IBAction func addTodo(_ sender: Any) {
        if let todoText = todoItem.text {
            NetworkService.shared.addTodo(
                todo: Todo(item: todoText, priority: Int(todoPriority.selectedSegmentIndex))
            ) { todos in
                self.todos = todos
                self.todoTable.reloadData()
                self.todoItem.text = ""
                self.todoPriority.selectedSegmentIndex = 0
            } onError: { errorMessage in
                self.apiErrorMessage = errorMessage
                print(self.apiErrorMessage)
            }
        }
    }
    
    func getTodos() {
        NetworkService.shared.getTodos { todos in
            self.todos = todos
            self.todoTable.reloadData()
        } onError: { errorMessage in
            self.apiErrorMessage = errorMessage
            print(self.apiErrorMessage)
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell {
            cell.updateCell(todo: todos[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

