//
//  SecondView.swift
//  OyeLabs Test
//
//  Created by administrator on 19/08/2021.
//

import SwiftUI

struct SecondView: View {
	
	@State private var isSheetShow = false
	@State private var name = ""
	@State private var tileTitle = ""
	@State var tileCollection: [tileModel] = [
		tileModel(title: "Supermarkets", image: "supermarket"),
		tileModel(title: "Mechanics Shop", image: "mechanic"),
		tileModel(title: "Electronics Shop", image: "electronic"),
		tileModel(title: "Jewelry Shop", image: "jewelry")
	]
	var body: some View {
		VStack{
			ScrollView{
				
				ForEach(tileCollection){tile in
					rectTile(tileTitle: tile.title, tileImage: tile.image)
				}
//				VStack{
//					rectTile(tileTitle: tileCollection[0].title, tileImage: tileCollection[0].image)
//
//				HStack{
//					squareTile(tileTitle: tileCollection[1].title, tileImage: tileCollection[1].image)
//					squareTile(tileTitle: tileCollection[2].title, tileImage: tileCollection[2].image)
//				}
//				}
//				ForEach(tileCollection){tile in
//					rectTile(tileTitle: tile.title, tileImage: tile.image)
//				}
			}
		}
		
		.navigationBarTitle("Shops", displayMode: .inline)
		.navigationBarItems(trailing: Button(action: {self.isSheetShow.toggle()}){
			Image(systemName: "plus")
		}
		.sheet(isPresented: $isSheetShow){
			ThirdView(tileCollections: $tileCollection)
		}
		)
	}
	
	struct tileModel: Identifiable {
		let id = UUID()
		let title: String
		let image: String
	}
	
	struct squareTile: View {
		@State var tileTitle: String
		var tileImage: String
		var body: some View{
			ZStack{
				Image(tileImage)
					.resizable()
					.frame(width: 170, height: 150, alignment: .center)
					.scaledToFit()
					.clipShape(RoundedRectangle(cornerRadius: 10))
				Text(tileTitle)
					.font(.subheadline)
					.fontWeight(.bold)
					.foregroundColor(.white	)
					.background(Color.black
									.opacity(0.16))
			}
			.onTapGesture(perform: {self.tileTitle = ""})
		}
	}
	
	struct rectTile: View {
		@State var tileTitle: String
		var tileImage: String
		var body: some View{
			ZStack{
				Image(tileImage)
					.resizable()
					.frame(width: 340, height: 150, alignment: .center)
					.scaledToFit()
					.clipShape(RoundedRectangle(cornerRadius: 10))
				Text(tileTitle)
					.font(.title)
					.fontWeight(.bold)
					.foregroundColor(.white	)
					.background(Color.black
									.opacity(0.16))
			}
			.onTapGesture(perform: {self.tileTitle = ""})
		}
	}
	
	struct ThirdView: View {
		@Environment(\.presentationMode) var pm
		@Binding var tileCollections: [tileModel]
		@State private var name = ""
		@State private var title = ""
		@State private var image = ""
		let images = ["supermarket", "mechanic", "electronic", "jewelry"]
		
		var body: some View {
			
			VStack{
				Group{
					TextField("Enter Name", text: $name)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.background(Color.black)
						.clipShape(Capsule())
						.overlay(Capsule().stroke())
						.padding()
					TextField("Enter Title", text: $title)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.background(Color.black)
						.clipShape(Capsule())
						.overlay(Capsule().stroke())
						.padding()
				}
				
				Picker("Select shop type", selection: $image) {
					ForEach(images, id: \.self){ image in
						Text(image)
					}
				}
				
				Button(action:{
					let newTile = tileModel(title: title, image: image)
					tileCollections.insert(newTile, at: 1)

					pm.wrappedValue.dismiss()
				})
				{
					Text("Save")
						.frame(width: 200, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
						.foregroundColor(.white)
						.background(Color.red)
						.clipShape(Capsule())
					
				}
				
				.navigationBarTitle("Add Shop", displayMode: .inline)
			}
		}
	}
}

struct SecondView_Previews: PreviewProvider {
	static var previews: some View {
		SecondView()
	}
}
