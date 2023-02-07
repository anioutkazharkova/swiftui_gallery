//
//  FilterViewModel.swift
//  ImageGallerySwiftUI
//
//  Created by Anna Zharkova on 07.02.2023.
//

import Foundation
import SwiftUI
import Combine

class FilterViewModel : ObservableObject {
    @Published var selectedItem: ImageItem? = nil
    var selectedIndex: Int = -1
    
    var photo: Asset? = nil {
        didSet {
            self.showDefault()
        }
    }
    
    @Published var images: [ImageItem] = [ImageItem]()
    private lazy var filterManager: FilterManager = {
       let filter = FilterManager()
        filter.currentImage = photo?.image
        return filter
    }()
    
     @MainActor
    func processImages(intencity: Double = 0) {
        
         Task {
         let images = await filterManager.prepareImages(intencity)
             self.images.removeAll()
             self.images.append(contentsOf: images)
             if selectedIndex > -1 && selectedIndex < self.images.count {
                 selectImage(index: selectedIndex)
             }
         }
     }
     
    func selectImage(index: Int) {
        self.selectedIndex = index
        self.selectedItem = images[index]
    }
     
    func saveSelected() {
        if selectedIndex > -1 {
            if let image = self.images[self.selectedIndex].image  {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    }
    
    func showDefault() {
        if let image = photo?.image {
            self.selectedIndex = -1
            self.selectedItem = ImageItem(image: image, filter: "Default")
        }
    }
}
