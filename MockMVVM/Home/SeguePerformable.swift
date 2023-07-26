//
//  SeguePerformable.swift
//  MockMVVM
//
//  Created by Hasan Saral on 19.06.2023.
//

import UIKit

protocol SeguePerformable {
    func performSegue(identifier: String)
}

extension SeguePerformable where Self: UIViewController {
    func performSegue(identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
    }
}
