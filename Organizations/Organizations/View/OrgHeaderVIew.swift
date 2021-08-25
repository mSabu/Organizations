//
//  OrgHeaderVIew.swift
//  Organizations
//
//  Created by Manjusha Sabu on 8/24/21.
//  Copyright © 2021 Manjusha Sabu. All rights reserved.
//

import SwiftUI

struct OrgHeaderVIew: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Organizations")
                .font(.title)
                .foregroundColor(.white)
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.gray)
                .frame(height: 1)
        }
    }
}

struct OrgHeaderVIew_Previews: PreviewProvider {
    static var previews: some View {
        OrgHeaderVIew()
    }
}
