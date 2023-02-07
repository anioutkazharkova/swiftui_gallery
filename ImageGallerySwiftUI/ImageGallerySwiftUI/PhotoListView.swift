//
//  PhotoListView.swift
//  ImageGallerySwiftUI
//
//  Created by Anna Zharkova on 06.02.2023.
//

import SwiftUI

struct PhotoListView: View {
    @ObservedObject var photoLibrary = PhotoLibrary()
    @ObservedObject var navigation = Navigation.shared
    
    private var gridItems = [GridItem(.flexible()),
                             GridItem(.flexible()),
                             GridItem(.flexible())]
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            ScrollView{
                LazyVGrid(columns: gridItems, alignment: .leading, spacing: 5) {
                    ForEach(photoLibrary.photoAssets) {asset in
                        PhotoThumbnailView(photo: asset).onTapGesture {
                            navigation.putPath(path: asset)
                        }
                    }
                }.onAppear {
                    self.photoLibrary.requestAuthorization()
                }
                .navigationDestination(for: Asset.self) { asset in
                    FilterView(photo: asset)
                            }
            }.background(.black).navigationTitle("My gallery").navigationBarTitleDisplayMode(.automatic).foregroundColor(.white)
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView()
    }
}
