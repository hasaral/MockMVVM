//
//  StatisticsCellPresenter.swift
//  MockMVVM
//
//  Created by Hasan Saral on 19.06.2023.
//

protocol StatisticsCellPresenterInterface {
    func load()
}

extension StatisticsArguments {
    enum StatisticType: Int {
        case sheep = 0, bull, statistic
        
        var image: String {
            switch self {
            case .sheep:
                return "aries"
            case .bull:
                return "bull"
            case .statistic:
                return "statistic"
            }
        }
        
        var name: String {
            switch self {
            case .sheep:
                return "Koç"
            case .bull:
                return "Dana"
            case .statistic:
                return "Raporlar"
            }
        }
    }
}

struct StatisticsArguments {
     let type: StatisticType
     let remain: String
     let death: String
}

final class StatisticsCellPresenter {
    private weak var view: StatisticsCellViewInterface?
    private let arguments: StatisticsArguments
    
    init(view: StatisticsCellViewInterface, arguments: StatisticsArguments) {
        self.view = view
        self.arguments = arguments
    }
}

extension StatisticsCellPresenter: StatisticsCellPresenterInterface {
    func load() {
        view?.setImageView(path: arguments.type.image)
        view?.setLabels(remainText: arguments.remain, deathtext: arguments.death)
        view?.setTypeLabel(text: arguments.type.name)
    }
    
    
}
