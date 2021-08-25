//
//  ContentView.swift
//  Organizations
//
//  Created by Manjusha Sabu on 8/8/21.
//  Copyright © 2021 Manjusha Sabu. All rights reserved.
//

import SwiftUI

struct ContentView: View {

@ObservedObject var organizationManager: OrganizationManger
   
   init(organizationManager: OrganizationManger) {
       UITableView.appearance().backgroundColor = .clear
       UITableViewCell.appearance().backgroundColor = .clear
       self.organizationManager = organizationManager
   }
   
   var body: some View {
       
       ZStack {
           Color.white
           Rectangle().fill(Color.black.opacity(0.8))
           
           VStack(alignment: .leading) {
            OrgHeaderVIew()
               Spacer()
               //list view
            OrganizationsListView(organizationManager: organizationManager).padding(.leading, 10)
           }.padding(.top, 50)

       }.edgesIgnoringSafeArea(.vertical)
       .onAppear(perform: loadData)
   }
 

    func loadData() {
        organizationManager.download(organization: []) { (result: Result<[OrganizationsModel], NetworkError>) in
            
            switch result {
            case .failure(let err):
                print("ERROR:: \(err)")
                
            case .success(let models):
                print("Result:: \(models.map{($0.url)})")
                DispatchQueue.main.async {
                    self.organizationManager.organizations = models
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let organizationManager =  OrganizationManger()
        ContentView(organizationManager: organizationManager)
    }
}
