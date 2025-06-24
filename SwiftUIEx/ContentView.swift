//
//  ContentView.swift
//  SwiftUIEx
//
//  Created by Hector Steven Villasano on 6/21/25.
//

import SwiftUI

struct Page: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var pageView: AnyView
}

private let pages: [Page] = [
    Page(title: "Staff List", description: "List with sections", pageView: AnyView(StaffList())),
    Page(title: "Detail View", description: "This is the first page.", pageView: AnyView(DetailView())),
    Page(title: "Itunes Search", description: "URLSession, List", pageView: AnyView(ItunesSearch())),
    Page(title: "Cupcake Corner", description: "Project 10", pageView: AnyView(CupcakeCornerView())),
]

struct PageRowView: View {
    var page: Page

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(page.title)
                .foregroundColor(.primary)
                .font(.headline)
            HStack(spacing: 3) {
                Label(page.description, systemImage: "gear")
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
        }
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail View")
            .padding()
    }
}

struct ContentView: View {
    var body: some View {
       NavigationView {
            List {
               ForEach(pages, id: \.id) { page in
                   
                   NavigationLink(destination: page.pageView) {
                        PageRowView(page: page)
                    }
                }
           }
        }
    }
}

#Preview {
    ContentView()
}
