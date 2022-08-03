//
//  ContentView.swift
//  PreStart2
//
//  Created by Mauro Arantes on 07/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var coursesListViewModel = CoursesListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(coursesListViewModel.courses, id:\.self) { course in
                    HStack {
                        CourseImageView(course: course)
                            .frame(width: 130, height: 70)
                        Text(course.name)
                            .bold()
                    }
                    .padding(3)
                }
            }
            .navigationTitle("Courses")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
