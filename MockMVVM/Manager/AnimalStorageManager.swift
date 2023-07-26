//
//  AnimalStorageManager.swift
//  MockMVVM
//
//  Created by Hasan Saral on 19.06.2023.
//

import Foundation
import UIKit


protocol AnimalStorageManagerInterface {
    var ariess: [Animals] { get }
    var bulls : [Animals] { get }
    
    var killedAriesCount: Int { get }
    var killedBullsCount: Int { get }
    
    func fetchAnimals(completion: @escaping (Result<[Animals], APError>) -> Void)
}

final class AnimalStorageManager: AnimalStorageManagerInterface {
    static let shared = AnimalStorageManager()
    var ariess = [Animals]()
    var bulls = [Animals]()
    var alertItem: AlertItem?
    
    var killedAriesCount: Int {
        ariess.filter({ $0.isKilled ?? false }).count }
    
    var killedBullsCount: Int {
        bulls.filter({ $0.isKilled ?? false }).count }
    
    public func fetchAnimals(completion: @escaping (Result<[Animals], APError>) -> Void) {
        getAriess { (res) in
            DispatchQueue.main.async {
                completion(.success(self.ariess))
            }
        }
    }
    
    func getAriess(completed: @escaping (Result<[Animals], APError>) -> Void) {
       
        Task {
            do {
                ariess = try await NetworkManager.shared.getAries()
                print(ariess.count)
                completed(.success(ariess))
            }
            catch {
                if let apError = error as? APError {
                    switch apError {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        completed(.failure(.invalidData))
                        return
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        completed(.failure(.invalidData))
                        return
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        completed(.failure(.invalidData))
                        return
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                        completed(.failure(.invalidData))
                        return
                    }
                } else {
                    alertItem = AlertContext.invalidResponse
                    completed(.failure(.invalidData))
                    return
                }
 
            }
            getBulls()
        }
        
    }
    
    func getBulls() {
       
        Task {
            do {
                bulls = try await NetworkManager.shared.getBull()
                print(bulls.count)

            }
            catch {
                if let apError = error as? APError {
                    switch apError {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                } else {
                    alertItem = AlertContext.invalidResponse
                }
 
            }
        }
    }
}
 

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}

struct AlertContext {
    static let invalidData = AlertItem(title:"Server error", message:"data 1")
    
    static let invalidResponse = AlertItem(title:"Server error", message:"data 1")

    static let invalidURL = AlertItem(title:"Server error", message:"data 1")

    static let unableToComplete = AlertItem(title:"Server error", message:"data 1")

    static let invalidForm = AlertItem(title:"Server error", message:"data 1")

    static let invalidEmail = AlertItem(title:"Server error", message:"data 1")

    static let userSaveSuccess = AlertItem(title:"Server error", message:"data 1")

    static let invalidUserData = AlertItem(title:"Server error", message:"data 1")

}
