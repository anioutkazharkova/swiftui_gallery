//
//  FilterGroupManager.swift
//  ImageGallerySwiftUI
//
//  Created by Anna Zharkova on 07.02.2023.
//

import Foundation
import Foundation
import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins


final class FilterManager {
    var filterProcessor = FilterProcessor()
    
    weak var currentImage: UIImage? {
        didSet {
            if let image = currentImage {
                filterProcessor = FilterProcessor(image: image)
            }
        }
    }
    
    func prepareImages(_ intencity: Double = 0) async -> [ImageItem]  {
        if let image = self.currentImage {
            filterProcessor = FilterProcessor(image: image)
        }
        return await filterProcessor.prepareImages(intencity)
    }
    
}
