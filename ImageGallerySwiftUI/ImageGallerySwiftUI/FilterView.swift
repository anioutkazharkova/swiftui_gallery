//
//  FilterView.swift
//  ImageGallerySwiftUI
//
//  Created by Anna Zharkova on 07.02.2023.
//

import SwiftUI

struct FilterView: View {
    @State var sliderValue: Double = 0
    @ObservedObject var model: FilterViewModel
    @ObservedObject var navigation = Navigation.shared
    init(photo: Asset) {
        self.model = FilterViewModel()
        self.model.photo = photo
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 10){
                Text(model.selectedItem?.filter ?? "").foregroundColor(.white).font(.footnote)
                Image(uiImage: model.selectedItem?.image ?? model.photo?.image ?? UIImage()).resizable().frame( height: 300)
                Slider(value: $sliderValue, in: 0...1){_ in
                    self.model.processImages(intencity: self.sliderValue)
                }.frame(height: 50)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(model.images.indices, id: \.self) { index in
                            VStack {
                                Image(uiImage: model.images[index].image ?? UIImage()).resizable().tag(index).id(index).frame(width: 120, height: 120).scaledToFit().onTapGesture {
        
                                    self.model.selectImage(index: index)
                                }
                                Text(model.images[index].filter).font(.callout).foregroundColor(.white)
                            }
                        }
                    }
                }
            }.padding(20)
        }.onAppear {
            self.model.processImages(intencity: self.sliderValue)
        }.background(.black).navigationBarItems(trailing: HStack(spacing: 10){
            Button {
                self.model.showDefault()
            } label: {
                Image("prev_image").tint(.white)
            }
            Button {
                self.model.saveSelected()
                self.navigation.back()
            } label: {
                Image("ok").tint(.white)
            }
            
        })
        
    }
    
    
}

