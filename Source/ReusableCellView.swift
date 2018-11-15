import UIKit

@objc public protocol ReusableCellView {}

extension ReusableCellView {
    static var resuableID: String {
        return String.init(describing: self)
    }
}

extension UITableView {
    func register(cell: ReusableCellView.Type) {
        self.register(cell, forCellReuseIdentifier: cell.resuableID)
    }
    
    func registerDelegate(with dataSource: BasicDataSource) {
        self.dataSource = dataSource
        self.delegate = dataSource
        self.reloadData()
    }
}

extension UICollectionView {
    func register(cell: ReusableCellView.Type) {
        self.register(cell, forCellWithReuseIdentifier: cell.resuableID)
    }
    
    func registerDelegate(with dataSource: BasicDataSource) {
        self.dataSource = dataSource
        self.delegate = dataSource
        self.reloadData()
    }
}

extension UITableViewCell: ReusableCellView {}

extension UICollectionViewCell: ReusableCellView {}
