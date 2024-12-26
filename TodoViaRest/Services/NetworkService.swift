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
    
    func getTodos(onSuccess: @escaping ([Todo]) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string: BASE_URL)! // we know it exists because it's a constant :)
        
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("invalid error response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(Todos.self, from: data)
                        onSuccess(items.items)
                    } else {
                        let err = try JSONDecoder().decode(ApiError.self, from: data)
                        onError(err.message)
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
    
    func addTodo(todo: Todo, onSuccess: @escaping ([Todo]) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string: "\(BASE_URL)\(ADD_TODO_URL)")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        do {
            let body = try JSONEncoder().encode(todo)
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        onError(error.localizedDescription)
                        return
                    }
                    
                    guard let data = data, let response = response as? HTTPURLResponse else {
                        onError("invalid error response")
                        return
                    }
                    
                    do {
                        if response.statusCode == 200 {
                            let items = try JSONDecoder().decode(Todos.self, from: data)
                            onSuccess(items.items)
                        } else {
                            let err = try JSONDecoder().decode(ApiError.self, from: data)
                            onError(err.message)
                        }
                    } catch {
                        onError(error.localizedDescription)
                    }
                }
            }
            
            task.resume()
        } catch {
            onError(error.localizedDescription)
        }
    }
}
