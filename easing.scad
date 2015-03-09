

function easeInQuad(t, b, c, d) = c * (t/d) * (t/d) + b;


function easeOutQuad(t, b, c, d) = -c * (t/d) * ((t/d) - 2) + b;

function easeInOutQuad(t, b, c, d) = ((t/(d / 2)) < 1) ?
                                        c / 2 * (t/(d / 2)) * (t/(d / 2)) + b
                                        :
                                        -c / 2 * ((t/(d / 2)) * ((t/(d / 2)) - 2) - 1) + b;

function easeInQuart(t, b, c, d) = c * (t/d) * (t/d) * (t/d) * (t/d) + b;

function easeOutQuart(t, b, c, d) = -c * ((t / d - 1) * (t / d - 1) * (t / d - 1) * (t / d - 1) - 1) + b;

function easeInOutQuart(t, b, c, d) = t < 1 ?
                                        c / 2 * (t/(d / 2)) * (t/(d / 2)) * (t/(d / 2)) * (t/(d / 2)) + b
                                        :
                                        -c / 2 * ((t/(d / 2)-2) * (t/(d / 2)-2) * (t/(d / 2)-2) * (t/(d / 2)-2) - 2) + b;

//TODO: convert the rest later
//function easeInQuint(t, b, c, d) = 
//t /= d
//return c * t * t * t * t * t + b
//
//function easeOutQuint(t, b, c, d) = 
//t = t / d - 1
//return c * (t * t * t * t * t + 1) + b
//
//function easeInOutQuint(t, b, c, d) = 
//t /= (d / 2)
//if t < 1 = 
//return c / 2 * t * t * t * t * t + b
//t -= 2
//return c / 2 * (t * t * t * t * t + 2) + b
//
//function easeInCubic(t, b, c, d) = 
//t /= d
//return c * t * t * t + b
//
//function easeInOutCubic(t, b, c, d) = 
//t /= (d / 2)
//if t < 1 = 
//return c / 2 * t * t * t + b
//t -= 2
//return c / 2 * (t * t * t + 2) + b
//
//function easeInSine(t, b, c, d) = 
//return -c * cos(t / d * (pi / 2)) + c + b
//
//function easeOutSine(t, b, c, d) = 
//return c * sin(t / d * (pi / 2)) + b
//
//function easeInOutSine(t, b, c, d) = 
//return -c / 2 * (cos(pi * t / d) - 1) + b
//
//function easeInExpo(t, b, c, d) = 
//if t == 0 = 
//return b
//return c * pow(2, 10 * (t / d - 1)) + b
//
//function easeOutExpo(t, b, c, d) = 
//if t == d = 
//return b + c
//return c * (-pow(2, -10 * t / d) + 1) + b
//
//function easeInOutExpo(t, b, c, d) = 
//if t == 0 = 
//return b
//if t == d = 
//return b + c
//t /= (d / 2)
//if t < 1 = 
//return c / 2 * pow(2, 10 * (t - 1)) + b
//t -= 1
//return c / 2 * (-pow(2, -10 * t) + 2) + b
//
//function easeInCirc(t, b, c, d) = 
//t /= d
//return -c * (sqrt(1 - t * t) - 1) + b
//
//function easeOutCirc(t, b, c, d) = 
//t = t / d - 1
//return c * sqrt(1 - t * t) + b
//
//function easeInOutCirc(t, b, c, d) = 
//t /= (d / 2)
//if t < 1 = 
//return -c / 2 * (sqrt(1 - t * t) - 1) + b
//t -= 2
//return c / 2 * (sqrt(1 - t * t) + 1) + b
//
//function easeInElastic(t, b, c, d) = 
//s = 1.70158
//a = c
//if t == 0 =  return b
//t /= d
//if t == 1 =  return b + c
//p = d * 0.3
//if a < abs(c) = 
//a = c
//s = p / 4
//else = 
//s = p / (2 * pi) * asin(c / a)
//t -= 1
//return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
//
//function easeOutElastic(t, b, c, d) = 
//s, a = 1.70158, c
//if t == 0 =  return b
//t /= d
//if t == 1 =  return b + c
//p = d * 0.3
//if a < abs(c) = 
//a, s = c, p / 4
//else = 
//s = p / (2 * pi) * asin(c / a)
//return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
//
//function easeInOutElastic(t, b, c, d) = 
//s, a = 1.70158, c
//if t == 0 =  return b
//t /= (d / 2)
//if t == 2 =  return b + c
//p = d * (0.3 * 1.5)
//if a < abs(c) = 
//a, s = c, p / 4
//else = 
//s = p / (2 * pi) * asin(c / a)
//if t < 1 = 
//t -= 1
//return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
//t -= 1
//return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p ) * 0.5 + c + b
//
//function easeInBack(t, b, c, d, s=1.70158) = 
//t /= d
//return c * t * t * (( s + 1) * t - s) + b
//
//function easeOutBack(t, b, c, d, s=1.70158) = 
//t = t / d - 1
//return c * (t * t * ((s + 1) * t + s) + 1) + b
//
//function easeInOutBack(t, b, c, d, s=1.70158) = 
//t /= d / 2
//s *= 1.525
//if t < 1 = 
//return c / 2 * (t * t * ((s + 1) * t - s)) + b
//t -= 2
//return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
//
//function easeInBounce(t, b, c, d) = 
//return c - easeOutBounce (d - t, 0, c, d) + b
//
//function easeOutBounce(t, b, c, d) = 
//t /= d
//if t < (1 / 2.75) = 
//return c * (7.5625 * t * t) + b
//elif t < (2/2.75) = 
//t -= 1.5 / 2.75
//return c * (7.5625 * t * t + 0.75) + b
//elif t < (2.5 / 2.75) = 
//t -= 2.25 / 2.75
//return c * (7.5625 * t * t + 0.9375) + b
//else = 
//t -= 2.625 / 2.75
//return c * (7.5625 * t * t + 0.984375) + b
//
//function easeInOutBounce(t, b, c, d) = 
//if t < (d / 2) = 
//return easeInBounce(t * 2, 0, c, d) * 0.5 + b
//return easeOutBounce(t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b