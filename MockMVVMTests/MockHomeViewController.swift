//
//  MockHomeViewController.swift
//  MockMVVMTests
//
//  Created by Hasan Saral on 20.06.2023.
//

@testable import MockMVVM

final class MockHomeViewContoller: HomeViewInterface {
    var isDragging: Bool = false
    
    var invokePrepareCollectionView = false
    var invokePrepareCollectionViewCount = 0
    
    func prepareCollectionView() {
        invokePrepareCollectionView = true
        invokePrepareCollectionViewCount += 1
    }
    
    var invokedPrepareRefreshControl = false
    var invokedPrepareRefreshControlCount = 0
    var invokedPrepareRefreshControlParameters: (tintColor: String, Void)?
    var invokedPrepareRefreshControlParametersList = [(tintColor: String, Void)]()
    
    func prepareRefreshControl(tintColor: String) {
        invokedPrepareRefreshControl = true
        invokedPrepareRefreshControlCount += 1
        invokedPrepareRefreshControlParameters = (tintColor: tintColor, ())
        invokedPrepareRefreshControlParametersList.append((tintColor: tintColor, ()))
    }
    
    var invokedBeginRefreshing = false
    var invokedBeginRefreshingCount = 0
    
    func beginRefreshing() {
         invokedBeginRefreshing = true
        invokedBeginRefreshingCount += 1
    }
    
    var invokedEndRefreshing = false
    var invokedEndRefreshingCount = 0
    
    func endRefreshing() {
        invokedEndRefreshing = true
        invokedEndRefreshingCount += 1
    }
    
    var invokedReloadData = false
    var invokedReloadDataCount = 0
    
    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }
    
    func scrollViewWillBeginDragging() {
         
    }
    
    
    var invokedPerformSegue = false
    var invokedPerformSegueCount = 0
    var invokedPerformSegueParameters: (identifier: String, Void)?
    var invokedPerformSegueParametersList = [(identifier: String, Void)]()
    
    func performSegue(identifier: String) {
        invokedPerformSegue = true
        invokedPerformSegueCount += 1
        invokedPerformSegueParameters = (identifier: identifier, ())
        invokedPerformSegueParametersList.append((identifier: identifier, ()))
    }
}
