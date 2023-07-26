//
//  ViewController.swift
//  MockMVVM
//
//  Created by Hasan Saral on 19.06.2023.
//

import UIKit

protocol HomeViewInterface: AnyObject, SeguePerformable {
    var isDragging: Bool { get }
    
    func prepareCollectionView()
    func prepareRefreshControl(tintColor: String)
    func beginRefreshing()
    func endRefreshing()
    func reloadData()
    func scrollViewWillBeginDragging()
}

final class HomeViewController: UIViewController {

    @IBOutlet weak var colletionViews: UICollectionView!
    private lazy var viewModel = HomeViewModel(view: self)

    var ariess = [Animals]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //viewModel.view = self
        viewModel.viewDidload()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }

    
    @objc private func pulledDownRefreshControl() {
        viewModel.pulledDownRefreshControl()
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        viewModel.registerButtonTapped()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? DetailListViewController {
            //destinationVC.DetailType = viewModel.detailType
            destinationVC.presentationController?.delegate = self
        }
    }
}

// MARK - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewModel.scrollViewDidEndDecelerating()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //self.ariess.count
 
        return AnimalStorageManager.shared.ariess.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatisticsCell", for: indexPath) as? StatisticsCell else {
            return .init()
        }
        
        let item = viewModel.cellForItem(at: indexPath)
        
        let cellPresenter = StatisticsCellPresenter(view: cell, arguments: item.arguments)
        cell.backgroundColor = .init(hexString: item.backgroundColor)
        cell.presenter = cellPresenter
     
        return cell
        
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width - 20, height: view.frame.height / 4)
    }
}

extension HomeViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        viewModel.presentationControllerDidDismiss()
    }
}

extension HomeViewController: HomeViewInterface {
    var isDragging: Bool {
        scrollViewWillBeginDragging(colletionViews)
    }
    
 
    func beginRefreshing() {
        colletionViews.refreshControl?.beginRefreshing()

    }
    
    func endRefreshing() {
        colletionViews.refreshControl?.endRefreshing()

    }
    
    func reloadData() {
        colletionViews.reloadData()
    }
    
    func prepareCollectionView() {
        colletionViews.delegate = self
        colletionViews.dataSource = self
        colletionViews.register(UINib(nibName: "StatisticsCell", bundle: .main), forCellWithReuseIdentifier: "StatisticsCell")
        colletionViews.reloadData()
        
    }
    
    func prepareRefreshControl(tintColor: String) {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .init(hexString: tintColor)
        refreshControl.addTarget(self, action: #selector(pulledDownRefreshControl), for: .valueChanged)
        colletionViews.refreshControl = refreshControl
    }
    
    func scrollViewWillBeginDragging() {
        
        scrollViewWillBeginDragging(colletionViews)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) -> Bool {
            if scrollView == self.colletionViews {
                return scrollView.isDragging
            }  else {
               return false
            }
        }
}
