//
//  StatisticsCell.swift
//  MockMVVM
//
//  Created by Hasan Saral on 19.06.2023.
//

import UIKit


protocol StatisticsCellViewInterface: AnyObject {
    func setImageView(path: String)
    func setLabels(remainText: String, deathtext: String)
    func setTypeLabel(text: String)
}

class StatisticsCell: UICollectionViewCell, StatisticsCellViewInterface {
 
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    
    
    var presenter: StatisticsCellPresenter! {
        didSet {
            presenter.load()
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        labelOne.text = nil
        labelTwo.text = nil
    }
    
    func setImageView(path: String) {
        print(path)
    }
    
    func setLabels(remainText: String, deathtext: String) {
        labelOne.text = remainText
    }
    
    func setTypeLabel(text: String) {
        labelTwo.text = text

    }
 
 }
