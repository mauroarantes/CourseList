//
//  CourseImageViewModel.swift
//  PreStart2
//
//  Created by Mauro Arantes on 09/02/2022.
//

import Foundation
import SwiftUI
import Combine

class CourseImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let course: Course
    private let dataService: CourseImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(course: Course) {
        self.course = course
        self.dataService = CourseImageService(course: course)
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
