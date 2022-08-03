//
//  CourseImageService.swift
//  PreStart2
//
//  Created by Mauro Arantes on 09/02/2022.
//

import Foundation
import SwiftUI
import Combine

class CourseImageService {
    
    @Published var image: UIImage? = nil
    
    private let course: Course
    private var imageSubscription: AnyCancellable?
    
    init(course: Course) {
        self.course = course
        getCourseImage()
    }
    
    private func getCourseImage() {
        guard let url = URL(string: course.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
