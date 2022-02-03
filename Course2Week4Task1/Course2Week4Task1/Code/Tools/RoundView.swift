import UIKit

class RoundView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeRounded(borderColour: .darkText, borderWidth: 1.0)
    }
}
