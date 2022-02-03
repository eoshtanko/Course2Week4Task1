import UIKit

class RadioViewController: UIViewController {
    
    private lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.songLabelFont
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.text = "Aerosmith - Hole In My Soul"
        return label
    }()
    
    private lazy var songImage: UIImageView = {
        let imageValue = UIImage(named: "AerosmithImage")!
        let image = UIImageView(image: imageValue)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var songSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderChangedValue(sender:)), for: .valueChanged)
        slider.value = 0.5
        return slider
    }()
    
    private lazy var songProgressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0.5
        return progressView
    }()
    
    @objc
    private func sliderChangedValue(sender: UISlider) {
        songProgressView.progress = sender.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        view.frame = UIScreen.main.bounds
        addSubviews()
        setupAndInitialyActivateConstraints()
        applyLayoutConstraints(nil)
    }
    
    private func addSubviews() {
        view.addSubview(songNameLabel)
        view.addSubview(songImage)
        view.addSubview(songSlider)
        view.addSubview(songProgressView)
    }
    
    // Constraints //
    
    private var portraitModeConstraints: [NSLayoutConstraint] = []
    private var landscapeModeConstraints: [NSLayoutConstraint] = []
    private var commonConstraints: [NSLayoutConstraint] = []
    
    private func setupAndInitialyActivateConstraints() {
        setupCommonConstraints()
        setupPortretModeConstraints()
        setupLandscapeModeConstraints()
        NSLayoutConstraint.activate(commonConstraints)
    }
    
    private func setupCommonConstraints() {
        commonConstraints = [
            songImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.rightLeftConstraint),
            songImage.heightAnchor.constraint(equalTo: songImage.widthAnchor),
            
            songNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.rightLeftConstraint),
            songNameLabel.topAnchor.constraint(equalTo: songProgressView.bottomAnchor, constant: 0.0),
            songNameLabel.bottomAnchor.constraint(equalTo: songSlider.topAnchor, constant: 0.0),
            
            songProgressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.rightLeftConstraint),
            songProgressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.rightLeftConstraint),
            
            songSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.rightLeftConstraint),
            songSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Const.rightLeftConstraint),
            songSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Const.bottomConstraint),
            songSlider.heightAnchor.constraint(equalToConstant: Const.sliderHeightLandscapeModeConstraint),
        ]
    }
    
    private func setupPortretModeConstraints() {
        portraitModeConstraints = [
            songImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.imageTopPortraitModeConstraint),
            songImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0.0),
            
            songNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Const.rightLeftConstraint),
            
            songProgressView.topAnchor.constraint(equalTo: songImage.bottomAnchor, constant: Const.distBetweenPhotoAndProgressPortraitModeConstraint),
        ]
    }
    
    private func setupLandscapeModeConstraints() {
        landscapeModeConstraints = [
            songImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.songImageTopLandscapeModeConstraint),
            songImage.bottomAnchor.constraint(equalTo: songSlider.topAnchor, constant: -Const.imageSidesLandscapeModeConstraint),
            
            songNameLabel.leadingAnchor.constraint(equalTo: songImage.trailingAnchor, constant: Const.rightLeftConstraint),
            
            songProgressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Const.topLandscapeModeConstraint),
        ]
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard let prevTraitCollection = previousTraitCollection else {
            return
        }
        
        if previousTraitCollection !== traitCollection {
            applyLayoutConstraints(prevTraitCollection)
        }
    }
    
    private func applyLayoutConstraints(_ previousTraitCollection: UITraitCollection?) {
        if let prevTraitCollection = previousTraitCollection,
           prevTraitCollection.verticalSizeClass == traitCollection.verticalSizeClass {
            return
        }
        if traitCollection.verticalSizeClass == .compact {
            changeConstraints(toActivate: landscapeModeConstraints, toDeactivate: portraitModeConstraints)
        }
        if traitCollection.verticalSizeClass == .regular {
            changeConstraints(toActivate: portraitModeConstraints, toDeactivate: landscapeModeConstraints)
        }
    }
    
    private func changeConstraints(toActivate: [NSLayoutConstraint], toDeactivate: [NSLayoutConstraint]) {
        NSLayoutConstraint.deactivate(toDeactivate)
        NSLayoutConstraint.activate(toActivate)
    }
    
    private enum Const {
        static let bottomConstraint: CGFloat = -24
        static let rightLeftConstraint: CGFloat = 16
        static let topLandscapeModeConstraint: CGFloat = 16
        static let imageTopPortraitModeConstraint: CGFloat = 8
        static let imageSidesLandscapeModeConstraint: CGFloat = 16
        static let progressTopLandscapeModeConstraint: CGFloat = 18
        static let sliderHeightLandscapeModeConstraint: CGFloat = 31
        static let songImageTopLandscapeModeConstraint: CGFloat = 36
        static let distBetweenPhotoAndProgressPortraitModeConstraint: CGFloat = 30
    }
}

extension UIFont {
    static let songLabelFont = UIFont.systemFont(ofSize: 22.0, weight: .medium)
}
