//
//  Todo.swift
//  TodoViaRest
//
//  Created by Erick Rocha on 25.12.24.
//

import Foundation

struct Todos: Codable {
    let items: [Todo]
}

struct Todo: Codable {
    let item: String
    let priority: Int
}
