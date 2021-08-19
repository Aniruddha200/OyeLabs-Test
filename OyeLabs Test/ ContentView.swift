//
//  ContentView.swift
//  OyeLabs Test
//
//  Created by administrator on 19/08/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
	@Environment(\.managedObjectContext) private var viewContext
	@State private var email = ""
	@State private var password = ""
	@State var isPasswordSecure = false
	@State private var isEmailValid = false
	@State private var isPasswordValid = false
	@State private var goToSecondView = false
	
	
	
	var body: some View {
		NavigationView{
			VStack{
				VStack(alignment: .leading, spacing: 20){
					VStack(alignment: .leading){
						Text("Welcome Back!")
							.font(.title2)
							.foregroundColor(Color(#colorLiteral(red: 0.7010309278, green: 0.2328998511, blue: 0.2586616166, alpha: 1)))
						Text("Please Login to Continue...")
							.font(.footnote)
							.fontWeight(.light)
					}
					
					VStack{
						CustomTextFiled(placeholder: "Email", text: $email, isSecure: false, validate: $isEmailValid)
						ZStack{
							CustomTextFiled(placeholder: "Password", text: $password, isSecure: isPasswordSecure, validate: $isPasswordValid)
								
							Button(action: {self.isPasswordSecure.toggle()}){
								if !isPasswordSecure{
									CustomEyeImage(imageName: "eye")
								}
								else{
									CustomEyeImage(imageName: "eye.slash")
								}
							}
							.offset(x: 130)
							Spacer()
						}
						.disabled(!isEmailValid)
						.opacity(isEmailValid ? 1.0 : 0.4)
					}
					
					HStack{
						Spacer()
						Button(action: {}){
							Text("Forgot password?")
								.font(.footnote)
								.fontWeight(.light)
								.foregroundColor(Color(#colorLiteral(red: 0.7422875166, green: 0.2530468404, blue: 0.283431232, alpha: 1)))
								.padding(.horizontal)
						}
					}
					
					
					Button(action: {self.goToSecondView.toggle()}){
						Text("Sign In")
							.foregroundColor(.white)
							.frame(width: 300, height: 50)
							.background(Color(#colorLiteral(red: 0.8484844565, green: 0.2124754786, blue: 0.2033774555, alpha: 1)))
							.clipShape(RoundedRectangle(cornerRadius: 30))
						NavigationLink("", destination: SecondView(), isActive: $goToSecondView)
					}
					.disabled(!isPasswordValid)
					.opacity(isPasswordValid ? 1.0 : 0.2)
					
				}
				
			}
			.frame(width: 300)
		}
	}
	
	struct CustomTextFiled: View{
		var placeholder: String
		@Binding var text: String
		var isSecure: Bool
		@Binding var validate: Bool
		
		var body: some View{
			if !isSecure{
				TextField(self.placeholder, text: self.$text, onCommit: {
					
					if placeholder == "Email"{
							  validate = emailValidator(text)
						  }
						  else{
							  validate = passwordValidator(text)
						  }
			  })
				.underlineTextFieldStyle()
			}
			else{
				SecureField(self.placeholder, text: self.$text, onCommit: {
						
							if placeholder == "Email"{
								validate = emailValidator(text)
							}
							else{
								validate = passwordValidator(text)
							}
				})
					.underlineTextFieldStyle()
			}
		}
		
		func emailValidator(_ inputEmail: String) -> Bool{
			let validPatten = #"^\S+@\S+\.\S+$"#
			let result = inputEmail.range(of: validPatten, options: .regularExpression)
			
			return (result != nil)
		}
		
		func passwordValidator(_ inputPassword: String) -> Bool{
			if inputPassword.count >= 8{
				return true
			}
			return false
		}
	}
	
	struct CustomEyeImage: View {
		var imageName: String
		var body: some View{
			Image(systemName: self.imageName)
				.resizable()
				.scaledToFit()
				.frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
				.foregroundColor(.black)
		}
	}

}


extension View {
	func underlineTextFieldStyle() -> some View {
		self
			.padding(.vertical, 10)
			.overlay(Rectangle().frame(height: 2).padding(.top, 35))
			.foregroundColor(.gray)
	}
}



struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
