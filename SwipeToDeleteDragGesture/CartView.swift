//
//  ContentView.swift
//  SwipeToDeleteDragGesture
//
//  Created by Evgeniy Safin on 13.09.2022.
//

import SwiftUI

struct ProductModel: Identifiable {
    let id: String = UUID().uuidString
    let image: UIImage? = nil
    let name: String
    let description: String
    let cost: Int
}

class CartViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    
    init() {
        getProducts()
    }
    
    private func getProducts() {
        let product1 = ProductModel(name: "Product 1", description: "description", cost: 5162)
        let product2 = ProductModel(name: "Product 2", description: "description", cost: 4362)
        let product3 = ProductModel(name: "Product 3", description: "description", cost: 12434)
        let product4 = ProductModel(name: "Product 4", description: "description", cost: 5231)
        let product5 = ProductModel(name: "Product 5", description: "description", cost: 1235)
        let product6 = ProductModel(name: "Product 6", description: "description", cost: 7533)
        
        self.products.append(contentsOf: [
            product1,
            product2,
            product3,
            product4,
            product5,
            product6
        ])
    }
}

struct CartView: View {
    
    @StateObject var cart: CartViewModel = CartViewModel()
    
    var body: some View {
        // background
        ZStack {
            VStack(spacing: 0) {
                // nav bar
                navBar
                // products
                products
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.indigo)
    }
    
    // MARK: NavBar
    private var navBar: some View {
        HStack(spacing: 0) {
            Text("Cart")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.leading, 5)
            Spacer()
        }
        .padding(.leading)
    }
    
    // MARK: Products
    private var products: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(cart.products) { product in
                    ProductItemDragGestureView(cart: self.cart, product: product)
                }
            }
        }
        .padding([.horizontal, .vertical])
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView()
//    }
//}
