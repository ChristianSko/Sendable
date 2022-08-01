//
//  ContentView.swift
//  Sendable
//
//  Created by Skorobogatow, Christian on 1/8/22.
//

import SwiftUI

actor CurrentUserManager {
    
    func updateDataBase(userInfo: MyUserInfo) {
        
    }
    
}


struct MyUserInfo: Sendable {
    let name: String
}

final class MyClassUserInfo: @unchecked Sendable{
    private var name: String
    let lock = DispatchQueue(label: "com.MyAppName.MyClassUserInfo")
    
    init(name: String) {
        self.name = name
    }
    
    func updateName(newName: String) {
        lock.async {
            self.name = newName
        }
    }
}

class SendableViewModel: ObservableObject {
    let manager = CurrentUserManager()
    
    func updateCurrentUserInfo() async {
        
        let info = MyUserInfo(name: "Info")
        
        await self.manager.updateDataBase(userInfo: info)
    }
    
}

struct SendableView: View {
    
    @StateObject var viewModel = SendableViewModel()
    
    var body: some View {
        Text("Hello, world!")
            .task {
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SendableView()
    }
}
