//
//  CourseImageView.swift
//  PreStart2
//
//  Created by Mauro Arantes on 09/02/2022.
//

import SwiftUI

struct CourseImageView: View {
    
    @StateObject var vm: CourseImageViewModel
    
    init(course: Course) {
        _vm = StateObject(wrappedValue: CourseImageViewModel(course: course))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "video")
            }
        }
    }
}
