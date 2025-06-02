//
//  RegisterSheet.swift
//  Restaurants
//
//  Created by piotr koscielny on 2/6/25.
//
import SwiftUI

struct RegisterSheet: View {
    @Binding var showPhoneEntry: Bool
    @Environment(\.dismiss) var dismiss
    @State private var input: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                HStack {
                    if showPhoneEntry {
                        Button("Back") {
                            showPhoneEntry = false
                        }
                        .foregroundColor(.purple)
                    } else {
                        Spacer()
                    }

                    Spacer()

                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.purple)
                }
                .padding(.horizontal)

                Text(showPhoneEntry ? "Enter your phone number" : "Enter your name")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 8) {
                    Text(showPhoneEntry ? "Phone Number" : "Name")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    TextField(showPhoneEntry ? "123 456 789" : "Your name", text: $input)
                        .keyboardType(showPhoneEntry ? .phonePad : .default)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.purple, lineWidth: 1)
                        )
                }
                .padding(.horizontal)

                Button(action: {
                    if showPhoneEntry {
                        dismiss()
                    } else {
                        showPhoneEntry = true
                    }
                }) {
                    Text("Next")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
            .navigationBarHidden(true)
        }
        .presentationDetents([.medium])
    }
}
