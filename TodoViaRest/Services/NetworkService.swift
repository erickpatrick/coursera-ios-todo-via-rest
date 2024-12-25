//
//  NetworkService.swift
//  TodoViaRest
//
//  Created by Erick Rocha on 25.12.24.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    let BASE_URL = "http://localhost:3003"
    let ADD_TODO_URL = "/add"
    
    let session = URLSession(configuration: .default)
    
    func getTodos() -> [Todo] {
        let url = URL(string: BASE_URL)! // we know it exists because it's a constant :)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                debugPrint("Invalid data or response")
                return
            }
            
            do {
                if response.statusCode == 200 {
                    let items = try JSONDecoder().decode(Todos.self, from: data)
                    print(items)
                } else {
                    let err = try JSONDecoder().decode(ApiError.self, from: data)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
            
        }
        
        task.resume()
        
        return []
    }
    
    func addTodo(todo: Todo) {
        
    }
}
