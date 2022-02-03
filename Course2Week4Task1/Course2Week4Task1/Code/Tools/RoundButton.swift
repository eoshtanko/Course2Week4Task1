import UIKit

class RoundButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeRounded(borderColour: .darkText, borderWidth: 1.0)
    }
}
