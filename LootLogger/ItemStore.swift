import UIKit

class ItemStore {
    var allItems = [Item] ()
    
    //Adding an item creation method
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)

        allItems.append(newItem)

        return newItem
    }
    //Populating the ItemStore with Item instances
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
}

