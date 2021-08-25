//
//  OrganizationsModel.swift
//  Organizations
//
//  Created by Manjusha Sabu on 8/8/21.
//  Copyright © 2021 Manjusha Sabu. All rights reserved.
//

import Foundation

struct OrganizationsModel: Codable, Identifiable {
    let id = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case userName = "login"
        case organizationId = "id"
        case url = "url"
        case nodeId = "node_id"
        case reposUrl = "repos_url"
        case avatarUrl = "avatar_url"
        case publicMembersUrl = "public_members_url"
        case membersUrl = "members_url"
        case issuesUrl = "issues_url"
        case hooksUrl = "hooks_url"
        case eventsUrl = "events_url"
        case orgDescription = "description"
    }
    
    var userName : String
    var organizationId : Int
    var nodeId : String
    var url : String?
    var reposUrl : String?
    var eventsUrl : String?
    var hooksUrl : String?
    var issuesUrl : String?
    var membersUrl : String?
    var publicMembersUrl : String?
    var avatarUrl : String?
    var orgDescription : String?
}
