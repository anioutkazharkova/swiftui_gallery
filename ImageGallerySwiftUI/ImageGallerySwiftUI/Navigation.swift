//
//  Navigation.swift
//  ImageGallerySwiftUI
//
//  Created by Anna Zharkova on 07.02.2023.
//

import Foundation
import SwiftUI
import Combine



class Navigation: ObservableObject {
    static let shared = Navigation()
    @Published var path = NavigationPath()
    
    func putPath(path: any Hashable) {
        self.path.append(path)
    }
    
    func back() {
        self.path.removeLast()
    }
}

