//
//  HomeViewModel.swift
//  MockMVVM
//
//  Created by Hasan Saral on 19.06.2023.
//

import Foundation

protocol HomeViewModelInterface {
    var detailType: DetailListViewController.DetailType { get }
    //var view: HomeViewInterface? { get set }
    
    func viewDidload()
    func viewWillAppear()
    func pulledDownRefreshControl()
    func scrollViewDidEndDecelerating()
    func didSelectItem(at indexPath: IndexPath)
    func presentationControllerDidDismiss()
    func registerButtonTapped()
    func cellForItem(at indexPath: IndexPath) -> (arguments: StatisticsArguments, backgroundColor: String)
    func scrollViewWillBeginDragging()
}

final class HomeViewModel {
    private weak var view: HomeViewInterface?
    private var shouldNeedToCallPulledDownRefreshControl: Bool = false
    private var selectedIndex: Int = 0
    private let storeManager: AnimalStorageManagerInterface
    
    init(view: HomeViewInterface, storeManager: AnimalStorageManagerInterface = AnimalStorageManager.shared) {
        self.view = view
        self.storeManager = storeManager
    }
    
    private func fetchAnimals() {
        view?.beginRefreshing()
        
        storeManager.fetchAnimals { [weak self] res in
            print(res)
            self?.view?.endRefreshing()
            self?.view?.reloadData()
            
        }
    }

}

extension HomeViewModel: HomeViewModelInterface {
    func scrollViewWillBeginDragging() {
        view?.scrollViewWillBeginDragging()
    }
    
 
    var detailType: DetailListViewController.DetailType {
        selectedIndex == 0 ? .aries : .bull
    }
    
    func viewDidload() {
        view?.prepareCollectionView()
        fetchAnimals()
    }
    
    func viewWillAppear() {
        view?.prepareRefreshControl(tintColor: "FF9060")
    }
    
    func pulledDownRefreshControl() {
        guard let isDragging = view?.isDragging, !isDragging else {
            shouldNeedToCallPulledDownRefreshControl = true
            return
        }
        
        fetchAnimals()
    }
    
    func scrollViewDidEndDecelerating() {
        guard shouldNeedToCallPulledDownRefreshControl else {
            return
        }
        shouldNeedToCallPulledDownRefreshControl = false
        fetchAnimals()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        selectedIndex = indexPath.item
 
        if [0,1].contains(indexPath.item) {
            view?.performSegue(identifier: "detailVC")
        } else {
            view?.performSegue(identifier: "reportsVC")
        }
    }
    
    func cellForItem(at indexPath: IndexPath) -> (arguments: StatisticsArguments, backgroundColor: String) {
        var cellType: StatisticsArguments.StatisticType
        var remain: String
        var death: String
        var backgroundColor: String
        
        if indexPath.row == StatisticsArguments.StatisticType.sheep.rawValue {
            backgroundColor = "FF9060"
            cellType = .sheep
            let killedAriesCount = storeManager.killedAriesCount
            remain = "Kalan \(storeManager.ariess.count - killedAriesCount)"
            death = "Kesilen \(killedAriesCount)"
        } else if indexPath.row == StatisticsArguments.StatisticType.bull.rawValue {
            backgroundColor = "7A40F2"
            cellType = .bull
            let killedBullsCount = storeManager.killedBullsCount
            remain = "Kalan \(storeManager.bulls.count - killedBullsCount)"
            death = "Kesilen \(killedBullsCount)"
        } else {
            backgroundColor = "3ACBE9"
            cellType = .statistic
            let killedAriesCount = storeManager.killedAriesCount
            let killedBullsCount = storeManager.killedBullsCount
            let totalCount = storeManager.ariess.count + storeManager.bulls.count
            remain = "Toplam Kalan: \(totalCount - killedAriesCount - killedBullsCount)"
            death = "Toplam Kesilen \(killedAriesCount + killedBullsCount)"

        }
        
        return (arguments: .init(type: cellType, remain: remain, death: death), backgroundColor: backgroundColor)
    }
    
    func presentationControllerDidDismiss() {
        fetchAnimals()
    }
    
    func registerButtonTapped() {
        view?.performSegue(identifier: "registerVC")
    }
}
