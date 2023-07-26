//
//  MockAnimalStoreManager.swift
//  MockMVVMTests
//
//  Created by Hasan Saral on 20.06.2023.
//
@testable import MockMVVM

final class MockAnimalStoreManager: AnimalStorageManagerInterface {
    var ariess: [Animals] = []
    
    var bulls: [Animals] = []
    
    var killedAriesCount: Int = 0
    
    var killedBullsCount: Int = 0
    
    var invokedFetchAnimals = false
    var invokeFetchAnimalCount = 0
    
    func fetchAnimals(completion: @escaping (Result<[Animals], APError>) -> Void) {
         invokedFetchAnimals = true
        invokeFetchAnimalCount += 1
        
        completion(.success(ariess))
    }
    
    
}
