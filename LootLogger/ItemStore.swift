import UIKit

class ItemStore {
    var allItems = [Item] ()
    
    //Adding an item creation method
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)

        allItems.append(newItem)

        return newItem
    }
    
    //implement a new method to remove a specific item.
    //“Removing an item from the store
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    //Reordering items within the store
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }

        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]

        // Remove item from array
        allItems.remove(at: fromIndex)

        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
    //Populating the ItemStore with Item instances
    /*init() {
        for _ in 0..<5 {
            createItem()
        }
    } */
}

