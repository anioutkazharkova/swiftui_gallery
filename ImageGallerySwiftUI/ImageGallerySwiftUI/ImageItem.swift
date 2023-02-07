//
//  ImageItem.swift
//  ImageGallerySwiftUI
//
//  Created by Anna Zharkova on 07.02.2023.
//

import Foundation
import UIKit

struct FilterItem : Identifiable {
    let id = UUID().uuidString
    
    let name: String
}

struct ImageItem  : Identifiable {
    let id = UUID().uuidString
    var image: UIImage? = nil
    var filter: String = ""
    
}
