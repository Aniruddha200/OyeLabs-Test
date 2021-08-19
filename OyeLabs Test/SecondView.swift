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
	var body: some View {
		Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
			
			
			.navigationBarItems(trailing: Button(action: {self.isSheetShow.toggle()}){
				Image(systemName: "plus")
			}
			.sheet(isPresented: $isSheetShow){
				TextField("Enter Name", text: $name)
				TextField("Enter Title", text: $tileTitle)
			}
			)
	}
}

struct SecondView_Previews: PreviewProvider {
	static var previews: some View {
		SecondView()
	}
}
