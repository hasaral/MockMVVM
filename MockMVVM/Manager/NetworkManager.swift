//
//  NetworkManager.swift
//  MockMVVM
//
//  Created by Hasan Saral on 19.06.2023.
//

import Foundation
import UIKit
import SwiftUI

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
    private let ennpointURL = baseURL + "appetizers"
    private init() {}
 
    
    func getAries() async throws -> [Animals] {
        
        guard let url = URL(string: ennpointURL) else {
            throw APError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)

            do {
                let decoder = JSONDecoder()
                return try decoder.decode(AriesResponse.self, from: data).request
                
            } catch {
                throw APError.invalidData
            }
        }
    
    func getBull() async throws -> [Animals] {
        
        guard let url = URL(string: ennpointURL) else {
            throw APError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)

            do {
                let decoder = JSONDecoder()
                return try decoder.decode(BullResponse.self, from: data).request
                
            } catch {
                throw APError.invalidData
            }
        }
        
    
    func downloadImage(fromURLString urlString: String, completed: @escaping(UIImage?) -> Void ) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)

        }
        task.resume()
        
    }
}
 

enum APError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}

struct AriesResponse: Decodable {
    let request: [Animals]
}

struct BullResponse: Decodable {
    let request: [Animals]
}

struct Aries: Codable {
    let request: [Animals]
}

struct Bulls: Codable {
    let request: [Animals]
}

// MARK: - Request
struct Animals: Codable {
    let name: String?
    let carbs: Int?
    let imageURL: String?
    let id: Int?
    let description: String?
    let price: Double?
    let calories, protein: Int?
    var isKilled: Bool? = false
    
}
 
