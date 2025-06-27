//
//  CheckoutView.swift
//  SwiftUIEx
//
//  Created by Hector Steven Villasano on 6/24/25.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    private let urlStr = "https://hws.dev/img/cupcakes@3x.jpg"
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: urlStr), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                
                Button("Place Oder") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank You", isPresented: $showingConfirmation) {
            Button("Ok") {}
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue( "application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decoder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Order #\(decoder.quantity) placed successfully"
            showingConfirmation = true
        } catch {
            print("checkout Failed: \(error.localizedDescription)")
        }
        
        
        
    }
}

#Preview {
    CheckoutView(order: Order())
}
