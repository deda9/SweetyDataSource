import UIKit

class BasicDataSource: NSObject {
    
    func numberOfItems(in section: Int) -> Int {
        fatalError("\(self): \(#function) Should be implemented to get the number of item in section")
    }
    
    func getTableViewCell(in: UITableView, indexPath: IndexPath) -> ReusableCellView {
        fatalError("\(self): \(#function) Should be implemented to get the tableView cell")
    }
    
    func getCollectionViewCell(in: UICollectionView, indexPath: IndexPath) -> ReusableCellView {
        fatalError("\(self): \(#function) Should be implemented to get the collectionView cell")
    }
    
    func getCollectionViewCellSize(_ indexPath: IndexPath) -> CGSize {
        fatalError("\(self): \(#function) Should set onCollectionViewCellSize closure to get the cell size")
    }
    
    func getCellHeight(_ indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension BasicDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cast(self.getTableViewCell(in: tableView, indexPath: indexPath))
    }
}

extension BasicDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getCellHeight(indexPath)
    }
}

extension BasicDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cast(self.getCollectionViewCell(in: collectionView, indexPath: indexPath))
    }
}

extension BasicDataSource: UICollectionViewDelegate {
    
}

extension BasicDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.getCollectionViewCellSize(indexPath)
    }
}

