//
//  FeedCell.swift
//  InstagramCloneFirebase
//
//  Created by Sarper Bal on 13.04.2023.
//

import UIKit
import Firebase
import FirebaseStorage


class FeedCell: UITableViewCell {
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var commentlabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var doucementIdLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClick(_ sender: Any) {
        
        let firestoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            
            let likeStore = ["likes" : likeCount + 1] as [String :Any]
            
            firestoreDatabase.collection("Posts").document(doucementIdLabel.text!).setData(likeStore, merge: true)
        }
        
        
    }
}
