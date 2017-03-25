/*
Playground to generate a palatte of colours for apps/websites
 
Based on the blog post, “Practical Color Theory for People Who Code” by Natalya Shelburne (@natalyathree)
https://tallys.github.io/color-theory/

© 2017 Paul Darcey, all rights reserved
*/

import UIKit

extension UIColor {
    // These functions are based on the blog post, “Practical Color Theory for People Who Code” by Natalya Shelburne (@natalyathree)
    // https://tallys.github.io/color-theory/
    
    // MARK: - Class functions
    
    class func harmoniousMix(_ mixColour: UIColor, baseColour: UIColor) -> UIColor {
        if mixColour.isCoolColour() == true {
            if baseColour.isHighKeyValue() == true {
                
                return UIColor.mix(colour1: mixColour, colour2: baseColour, weight: 11)
            } else {
                
                return UIColor.mix(colour1: mixColour, colour2: baseColour, weight: 16)
            }
        } else {
            if baseColour.isHighKeyValue() == true {
                
                return UIColor.mix(colour1: mixColour, colour2: baseColour, weight: 13)
            } else {
                
                return UIColor.mix(colour1: mixColour, colour2: baseColour, weight: 23)
            }
        }
    }
    
    // MARK: - Instance functions
    
    func isCoolColour() -> Bool {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        let _ = self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return hue < 0.8333 && hue > 0.3333
    }
    
    func isHighKeyValue() -> Bool {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        let _ = self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        return hue > 0.0833 && hue < 0.3888
    }
}

extension UIColor {
    // These functions are based on functions in http://sass-lang.com/documentation/Sass/Script/Functions.html
    
    // MARK: - Class functions

    class func mix(colour1: UIColor, colour2: UIColor, weight: CGFloat = 50) -> UIColor {
        let colour1WeightPercent: CGFloat = weight.divided(by: CGFloat.init(100))
        let normalisedWeight = colour1WeightPercent * 2 - 1
        let alphaDifference = colour1.alpha() - colour2.alpha()
        
        let interimWeight: CGFloat
        if normalisedWeight.multiplied(by: alphaDifference) == CGFloat.init(-1) {
            interimWeight = normalisedWeight
        } else {
            let top = normalisedWeight.adding(alphaDifference)
            let bottom = normalisedWeight.multiplied(by: alphaDifference) + 1
            interimWeight = top / bottom
        }
        let weight1 = (interimWeight + 1) / 2
        let weight2 = CGFloat.init(1).subtracting(weight1)
        
        let red = colour1.red().multiplied(by: weight1).adding(colour2.red().multiplied(by: weight2))
        let green = colour1.green().multiplied(by: weight1).adding(colour2.green().multiplied(by: weight2))
        let blue = colour1.blue().multiplied(by: weight1).adding(colour2.blue().multiplied(by: weight2))
        let alpha = colour1.alpha().multiplied(by: weight1).adding(colour2.alpha().multiplied(by: weight2))
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // MARK: - Instance functions
    
    func complement() -> UIColor {
        
        var hue = Double.init(self.hue())
        if hue >= 0.5 {
            hue = hue - 0.5
        } else {
            hue = hue + 0.5
        }
        
        return UIColor(hue: CGFloat.init(hue), saturation: self.saturation(), brightness: self.brightness(), alpha: self.alpha())
        
    }
    
    func darken(percent: CGFloat) -> UIColor {
        
        return UIColor(hue: self.hue(), saturation: self.saturation(), brightness: self.brightness() * (1 - percent), alpha: self.alpha())
    }
    
    func lighten(percent: CGFloat) -> UIColor {
        
        return UIColor(hue: self.hue(), saturation: self.saturation(), brightness: self.brightness() * ( 1 + percent), alpha: self.alpha())
    }
}

extension UIColor {
    // Based on “Convenience methods to convert UIColors to from hex/css value/string” by Tom Adriaenssen (@inferis)
    // https://github.com/Inferis/UIColor-Hex
    
    func hex() -> uint {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if (!self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)) {
            self.getWhite(&red, alpha: &alpha)
            green = red
            blue = red
        }
        
        red = (red.multiplied(by: CGFloat.init(255))).rounded()
        green = (green.multiplied(by: CGFloat.init(255))).rounded()
        blue = (blue.multiplied(by: CGFloat.init(255))).rounded()
        alpha = (alpha.multiplied(by: CGFloat.init(255))).rounded()
        
        return (uint(alpha) << 24) | (uint(red) << 16 | (uint(green) << 8) | uint(blue))
    }
    
    func hexString() -> String {
        
        return String.init(format: "0x%08x", self.hex())
    }
    
}

extension UIColor {
    // Convenience functions
    
    func hue() -> CGFloat {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        let _ = self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return hue
    }
    
    func saturation() -> CGFloat {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        let _ = self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return saturation
    }
    
    func brightness() -> CGFloat {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        let _ = self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return brightness
    }
    
    func alpha() -> CGFloat {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        let _ = self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return alpha
    }

    func red() -> CGFloat {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if (!self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)) {
            self.getWhite(&red, alpha: &alpha)
            green = red
            blue = red
        }
        
        return red
    }

    func green() -> CGFloat {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if (!self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)) {
            self.getWhite(&red, alpha: &alpha)
            green = red
            blue = red
        }
        
        return green
    }
    
    func blue() -> CGFloat {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if (!self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)) {
            self.getWhite(&red, alpha: &alpha)
            green = red
            blue = red
        }
        
        return blue
    }
}

// Set main colour
let mainColour = UIColor(red: 1.0, green: 0.0, blue: 0.004, alpha: 1.000)

// Calculate the complement and neutrals
let hex = mainColour.hexString().uppercased()
let complement = mainColour.complement()
let neutral = UIColor.harmoniousMix(complement, baseColour: mainColour)
let neutralHighlight = neutral.lighten(percent: 0.4)
let neutralShadow = neutral.darken(percent: 0.4)
let complementNeutral = UIColor.harmoniousMix(mainColour, baseColour: complement)
let complementNeutralHighlight = complementNeutral.lighten(percent: 0.4)
let complementNeutralShadow = complementNeutral.darken(percent: 0.4)

// Display palette
let colourArray = [ mainColour, complement, neutralShadow, neutral, neutralHighlight, complementNeutralShadow, complementNeutral, complementNeutralHighlight]
let palette = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 60 * colourArray.count, height: 60))
for (index, colour) in colourArray.enumerated() {
    let rect = CGRect.init(x: 60 * index, y: 0, width: 60, height: 60)
    let colourImage = UIImageView.init(frame: rect)
    colourImage.backgroundColor = colour
    palette.addSubview(colourImage)
}
palette
