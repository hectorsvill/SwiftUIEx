//
//  CupcakeCornerView.swift
//  SwiftUIEx
//
//  Created by Hector Steven Villasano on 6/24/25.
//

import SwiftUI
import CoreHaptics

struct CupcakeCornerView: View {
    @State private var order = Order()
    
    var body: some View {
        
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                }
                
                Section {
                    Toggle("Any Special Request?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery Details") {
                        AddressView(order: order)
                    }
                    
                }
            }
            .navigationTitle(Text("Order"))
        }

}

#Preview {
    CupcakeCornerView()
}
