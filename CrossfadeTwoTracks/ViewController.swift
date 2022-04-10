//
//  ViewController.swift
//  CrossfadeTwoTracks
//
//  Created by Дмитрий Мартынов on 05.04.2022.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    var songs: [String] = ["1", "2"]
    var currentIndex: Int = 0
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 100)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.cornerRadius = screenRect().width * 0.4
        button.clipsToBounds = true
        
        return button
    }()
    
    private lazy var firstSongButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("First", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.tag = 0
        
        return button
    }()
    
    private lazy var secondSongButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle("Second", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.tag = 1
        
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstSongButton, secondSongButton])
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var fadeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 2
        slider.maximumValue = 10
        slider.minimumTrackTintColor = .orange
        slider.maximumTrackTintColor = .darkGray
        slider.thumbTintColor = .lightGray
        
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func setupView() {
            view.backgroundColor = .black
        }
        
        func addSubviews() {
            view.addSubview(playButton)
            view.addSubview(buttonStackView)
            view.addSubview(fadeSlider)
        }
        
        func makeConstraints() {
            playButton.translatesAutoresizingMaskIntoConstraints = false
            playButton.topAnchor.constraint(equalTo: view.topAnchor, constant: screenRect().height * 0.2).isActive = true
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            playButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
            playButton.heightAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
            
            buttonStackView.translatesAutoresizingMaskIntoConstraints = false
            buttonStackView.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: screenRect().height * 0.05).isActive = true
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            buttonStackView.heightAnchor.constraint(equalToConstant: screenRect().height * 0.05).isActive = true
            
            fadeSlider.translatesAutoresizingMaskIntoConstraints = false
            fadeSlider.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: screenRect().height * 0.05).isActive = true
            fadeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenRect().width * 0.05).isActive = true
            fadeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -screenRect().width * 0.05).isActive = true
        }
        
        func addTargets() {
            playButton.addTarget(self, action: #selector(playButtonTap), for: .touchUpInside)
            firstSongButton.addTarget(self, action: #selector(chooseTrack), for: .touchUpInside)
            secondSongButton.addTarget(self, action: #selector(chooseTrack), for: .touchUpInside)
        }
        
        setupView()
        addSubviews()
        makeConstraints()
        addTargets()
        setupPlayer(currentIndex)
    }
    
    func setupPlayer(_ index: Int) {
        guard let audio = Bundle.main.path(forResource: songs[index], ofType: "mp3") else { return }
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audio))
            player.numberOfLoops = 0
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @objc func playButtonTap(_ sender: UIButton) {
        
        if player.isPlaying == true {
            player.stop()
            playButton.setTitle("Play", for: .normal)
        } else {
            player.play()
            playButton.setTitle("Pause", for: .normal)
        }
    }
    
    @objc func chooseTrack(_ sender: UIButton) {
        setupPlayer(sender.tag)
        player.play()
        playButton.setTitle("Pause", for: .normal)
    }
    
    func screenRect() -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        return CGSize(width: screenWidth, height: screenHeight)
    }
}

