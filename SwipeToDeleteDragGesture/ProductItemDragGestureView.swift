//
//  ProductItemDragGestureView.swift
//  SwipeToDeleteDragGesture
//
//  Created by Evgeniy Safin on 13.09.2022.
//

import SwiftUI

struct ProductItemDragGestureView: View {
    
    @ObservedObject var cart: CartViewModel
    let product: ProductModel
    
    @GestureState private var slideOffset: CGSize = CGSize.zero
    @State private var positionX: CGFloat = 0
    @State private var deleteButtonIsHidden: Bool = true
    
    // MARK: Delete item
    private func deleteItem() {
        self.cart.products.removeAll { oneProduct in
            self.product.id == oneProduct.id
        }
    }
    
    var body: some View {
        ZStack {
            // swipe gesture
            swipeToDelete
            // delete button
            deleteButton
        }
    }
    
    // MARK: Swipe to delete
    private var swipeToDelete: some View {
        ProductItemView(product: product)
            .offset(x: slideOffset.width + positionX)
            .gesture(DragGesture()
                .updating($slideOffset, body: { dragValue, slideOffset, transaction in
                    if dragValue.translation.width < 0 && dragValue.translation.width > -55 && self.positionX != -55 {
                        slideOffset = dragValue.translation
                    }
                })
                    .onEnded({ dragValue in
                        if dragValue.translation.width < 0 {
                            withAnimation(.linear) {
                                self.positionX = -55
                                // появляется кнопка удалить
                                self.deleteButtonIsHidden = false
                            }
                        } else {
                            withAnimation(.linear) {
                                self.positionX = 0
                                self.deleteButtonIsHidden = true
                            }
                        }
                    })
            )
            .animation(.linear)
    }
    
    // MARK: Delete button
    @ViewBuilder private var deleteButton: some View {
        if !deleteButtonIsHidden {
            HStack(spacing: 0) {
                Spacer()
                Button(action: {
                    deleteItem()
                }, label: {
                    Image(systemName: "trash")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                })
                .padding(.horizontal)
                .frame(width: 55)
                .frame(maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.clear)
                )
                .contentShape(RoundedRectangle(cornerRadius: 15))
                .onTapGesture {
                    deleteItem()
                }
            }
        }
    }
}

//struct ProductItemDragGestureView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductItemDragGestureView()
//    }
//}
