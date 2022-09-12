//
//  ProductItemView.swift
//  SwipeToDeleteDragGesture
//
//  Created by Evgeniy Safin on 13.09.2022.
//

import SwiftUI

struct ProductItemView: View {
    
    let product: ProductModel
    
    var body: some View {
        HStack(spacing: 0) {
            // product image
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.mint)
                .frame(width: 100, height: 100)
            Spacer()
            // product data
            VStack(alignment: .leading, spacing: 10) {
                Text(product.name)
                    .font(.title2)
                    .fontWeight(.heavy)
                Text(product.description)
                    .font(.subheadline)
                Text("\(product.cost) ₽")
                    .font(.callout)
                    .bold()
            }
            .padding(.leading, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.yellow.opacity(0.66)))
    }
}

//struct ProductItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductItemView()
//    }
//}
