import UIKit

protocol GenericDataSourceProtocol {
    associatedtype Item

    var itemsList: [Item] { set get }
    
    func item(at: IndexPath) -> Item
    func add(item: Item, at: IndexPath)
    func replace(at indexPath: IndexPath, with item: Item)
    func remove(at indexPath: IndexPath)
}

class GenericDataSource<ItemType, CellType: ReusableCellView>: BasicDataSource, GenericDataSourceProtocol {
    
    typealias CellRowData = ((_ cell: CellType, _ item: ItemType, _ index: IndexPath) -> Void)
    typealias TableViewCellHeight = ((_ indexPath: IndexPath) -> CGFloat)
    typealias CollectionViewCellSize = ((_ indexPath: IndexPath) -> CGSize)
    
    var onConfigureCell: CellRowData?
    var onTableViewCellHeight: TableViewCellHeight?
    var onCollectionViewCellSize: CollectionViewCellSize?
    
    var itemsList: [ItemType] = []
    
    init(items: [ItemType]) {
        super.init()
        self.itemsList = items
    }
    
    func item(at indexPath: IndexPath) -> ItemType {
        return self.itemsList[indexPath.row]
    }
    
    func add(item: ItemType, at: IndexPath) {
        self.itemsList.append(item)
    }
    
    func remove(at indexPath: IndexPath) {
        self.itemsList.remove(at: indexPath.row)
    }
    
    public func replace(at indexPath: IndexPath, with item: Item) {
        self.itemsList[indexPath.item] = item
    }
    
    override func numberOfItems(in section: Int) -> Int {
        return self.itemsList.count
    }
    
    override func getTableViewCell(in tableView: UITableView, indexPath: IndexPath) -> ReusableCellView {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.resuableID)
        let castedCell: CellType = cast(cell)
        let item = self.item(at: indexPath)
        self.onConfigureCell?(castedCell, item, indexPath)
        return castedCell
    }
    
    override func getCollectionViewCell(in collectionView: UICollectionView, indexPath: IndexPath) -> ReusableCellView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.resuableID, for: indexPath)
        let castedCell: CellType = cast(cell)
        let item = self.item(at: indexPath)
        self.onConfigureCell?(castedCell, item, indexPath)
        return castedCell
    }
    
    override func getCellHeight(_ indexPath: IndexPath) -> CGFloat {
        return self.onTableViewCellHeight?(indexPath) ?? super.getCellHeight(indexPath)
    }
    
    override func getCollectionViewCellSize(_ indexPath: IndexPath) -> CGSize {
        return self.onCollectionViewCellSize?(indexPath) ?? super.getCollectionViewCellSize(indexPath)
    }
}
