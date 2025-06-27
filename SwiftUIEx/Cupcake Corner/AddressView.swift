//
//  AddressView.swift
//  SwiftUIEx
//
//  Created by Hector Steven Villasano on 6/24/25.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress)
        }
        .navigationBarTitle("Delivery Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order:  Order())
}
