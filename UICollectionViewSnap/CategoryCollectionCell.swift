
import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var cantainerView: UIView!
    @IBOutlet weak var titlaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutSubviews()
       // titlaLabel.roundCorners([ .bottomRight, .bottomLeft], radius: 10)
     }
    

}


