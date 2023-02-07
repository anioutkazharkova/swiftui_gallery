//
//  PhotoThumbnailView.swift
//  ImageGallerySwiftUI
//
//  Created by Anna Zharkova on 06.02.2023.
//

import SwiftUI
import PhotosUI
import Photos

struct PhotoThumbnailView: View {
    @ObservedObject var photo: Asset
    @State private var isDisappeard = false
    var body: some View {
        HStack {
            if photo.image != nil {
                Image(uiImage: photo.image!).resizable()
                    .clipped()
                    .frame(width: 120, height: 120)
                    
            } else {
                Color.white.frame(width: 120, height: 120)
            }
        }.onAppear {
            self.isDisappeard = false
            self.photo.request()
        }.onDisappear {
            self.isDisappeard = true
        }
    }
}
