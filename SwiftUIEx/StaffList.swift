//
//  StaffList.swift
//  SwiftUIEx
//
//  Created by Hector Steven Villasano on 6/21/25.
//

import SwiftUI

struct Person: Identifiable {
     let id = UUID()
     var name: String
     var phoneNumber: String
 }


var staff = [
    Person(name: "Juan Chavez", phoneNumber: "(408) 555-4301"),
    Person(name: "Mei Chen", phoneNumber: "(919) 555-2481")
]

struct Department: Identifiable {
    let id = UUID()
    var name: String
    var staff: [Person]
}


struct Company {
    var departments: [Department]
}



let company = Company(departments: [
    Department(name: "Sales", staff: [
        Person(name: "Juan Chavez", phoneNumber: "(408) 555-4301"),
        Person(name: "Mei Chen", phoneNumber: "(919) 555-2481"),
        Person(name: "David Rodriguez", phoneNumber: "(212) 555-8765")
    ]),
    Department(name: "Engineering", staff: [
        Person(name: "Bill James", phoneNumber: "(408) 555-4450"),
        Person(name: "Anne Johnson", phoneNumber: "(417) 555-9311"),
        Person(name: "Emily White", phoneNumber: "(650) 555-1234"),
        Person(name: "Michael Brown", phoneNumber: "(312) 555-5678"),
        Person(name: "Sarah Green", phoneNumber: "(512) 555-9101")
    ]),
    Department(name: "Marketing", staff: [
        Person(name: "Jessica Davis", phoneNumber: "(718) 555-1122"),
        Person(name: "Chris Miller", phoneNumber: "(305) 555-3344"),
        Person(name: "Laura Wilson", phoneNumber: "(206) 555-5566"),
        Person(name: "Daniel Moore", phoneNumber: "(404) 555-7788")
    ]),
    Department(name: "Human Resources", staff: [
        Person(name: "Robert Taylor", phoneNumber: "(832) 555-9900"),
        Person(name: "Linda Anderson", phoneNumber: "(602) 555-1212")
    ]),
    Department(name: "Customer Support", staff: [
        Person(name: "Maria Hernandez", phoneNumber: "(972) 555-3434"),
        Person(name: "Kevin Lee", phoneNumber: "(720) 555-5656"),
        Person(name: "Karen Thompson", phoneNumber: "(215) 555-7878")
    ])
])


struct PersonRowView: View {
    var person: Person


    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(person.name)
                .foregroundColor(.primary)
                .font(.headline)
            HStack(spacing: 3) {
                Label(person.phoneNumber, systemImage: "phone")
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
            
        }
    }
}
struct PersonDetailView: View {
    var person: Person


    var body: some View {
        VStack {
            Text(person.name)
                .foregroundColor(.primary)
                .font(.title)
                .padding()
            HStack {
                Label(person.phoneNumber, systemImage: "phone")
            }
            .foregroundColor(.secondary)
        }
    }
}

struct StaffList: View {
    var body: some View {
        List {
            ForEach(company.departments) { department in
                Section(header: Text(department.name)) {
                    ForEach(staff) { staff in
                        NavigationLink(destination: PersonDetailView(person: staff)) {
                                PersonRowView(person: staff)
                        }
                    }
                }
            }
        }
        .navigationTitle("Staff Dir")
    }
}

#Preview {
    StaffList()
}
