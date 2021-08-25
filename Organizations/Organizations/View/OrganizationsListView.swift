//
//  OrganizationsListView.swift
//  Organizations
//
//  Created by Manjusha Sabu on 8/8/21.
//  Copyright © 2021 Manjusha Sabu. All rights reserved.
//

import SwiftUI
import BetterSafariView

struct OrganizationsListView: View {
    
    @ObservedObject var organizationManager: OrganizationManger
    
    @State private var showOnSafari = false
    @State private var selectedOrg: OrganizationsModel?
    
    init(organizationManager: OrganizationManger) {
        self.organizationManager = organizationManager
    }
    
    var body: some View {
        
        VStack() {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(organizationManager.organizations) { organization in
                    VStack(alignment: .leading) {
                        HStack(alignment: .top, spacing: 8.0) {
                            // Async Image
                            AsyncImage.init(url: URL(string: organization.avatarUrl!)! ) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue.opacity(0.2))
                            } image: { (img) -> Image in
                                Image(uiImage: img).resizable()
                            }
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text(organization.userName)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                Spacer()
                                Text(organization.orgDescription ?? "")
                                    .foregroundColor(.white)
                                    .font(.body.italic())
                                    .fixedSize(horizontal: false, vertical: true)

                                Text(organization.url ?? "")
                                    .foregroundColor(.blue .opacity(0.8))
                                    .font(.system(size: 13, weight: .light, design: .default))
                                    .fixedSize(horizontal: false, vertical: true)
                                Spacer()
                            }
                        }.contentShape(Rectangle())
                        .onTapGesture {
                            self.showOnSafari.toggle()
                            self.selectedOrg = organization
                        }
                        .sheet(isPresented: $showOnSafari, content: {

                            // load the page
                            loadOrg(for: selectedOrg ?? organization)
                            RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2))
                                .padding(.horizontal, 50)
                                .frame(height: 1)
                        })
                        RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.2))
                            .padding(.horizontal, 20)
                            .frame(height: 1)
                    }
                }
            }
        }
    }
    
    private func loadOrg(for organization: OrganizationsModel) -> some View {
                
        return SafariView(url: URL(string: organization.url?.replacingOccurrences(of: "https://api.", with: "https://") ?? "https://github.com")!)
    }
}
