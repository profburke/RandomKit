//
//  Distributions.swift
//  RandomKit
//
//  Created by Matthew Burke on 4/20/15.
//  Copyright (c) 2015 BlueDino Software. All rights reserved.
//
//  Implementations of the various distributions
//

import Foundation

// For details on generation of random variates, see
// Devroye, Luc. Non-Uniform Random Variate Generation. Springer-Verlag: New York, 1986.
// Available at: http://luc.devroye.org/rnbookindex.html

// Also borrows heavily from randomkit (URL) (license)



// TODO random Float and Float80 ???



/**

  Generates a normally-distributed random double with given mean and standard deviation.

  The mean defaults to 0 and the standard deviation defaults to 1.0. Uses the Marsaglia and
  Bray (Polar) method
  (see http://phoxis.org/2013/05/04/generating-random-numbers-from-normal-distribution-in-c/ )

  :param: mu The average value of the distribution.
  :param: sigma The standard deviation of the distribution.
  :returns: a normally-distributed random double.

*/
public func normal(mu: Double = 0.0, sigma: Double = 1.0) -> Double
{
  struct FunctionLocalState {
    static var spareResult: Double = 0.0
    static var spareExists: Bool = false
  }
  let result: Double
  
  if FunctionLocalState.spareExists {
    result = FunctionLocalState.spareResult
  } else {
    var U1: Double
    var U2: Double
    var W: Double
    do {
      U1 = uniform(-1...1)
      U2 = uniform(-1...1)
      W = pow(U1, 2) + pow(U2, 2)
    } while W >= 1 || 0 == W
    
    let mult = sqrt( -2 * log(W) / W)
    result = U1 * mult
    FunctionLocalState.spareResult = U2 * mult
  }
  
  FunctionLocalState.spareExists = !FunctionLocalState.spareExists
  
  return mu + sigma * result
}




/**

  Generates an exponentially-distributed random variable.

  The parameter *c*, average number of events per unit-time, defaults to 1.

  :param: c The average number of events per unit-time.
  :returns: an exponentially-distributed random double.

*/
public func exponential(_ c: Double = 1.0) -> Double
{
  // log(1-uniform()) because uniform() can return 0
  return -log(1 - uniform()) / c
}




// TODO: really ought to make l positive and then
// mult by -1 in function ... makes more sense given what it is
// l must be negative
public func poisson(_ l: Double = -1) -> Int
{
  let threshold = exp(l)
  var product = 1.0
  var count = 0
  do {
    product *= uniform()
    count++
  } while (threshold < product)
  return count
}




public func binomial(success: Double, trials: Int = 1) -> Int
{
  // success must be in [0,1]
  var result = 0
  for i in 1...trials {
    if uniform() < success {
      result++
    }
  }
  
  return result
}




/**
  Generates a random double from an arbitrary distribution.

  :param: pdf The probability density function of the desired distribution.
  :param: range The range of allowed input values for the pdf (more accurately, the domain of the PDF).
  :param: max The maximal value of the PDF on its domain.
  :returns: a random double from the desired distribution.

*/
public func rejection(pdf: Double -> Double, range: Range<Int>, max: Double) -> Double
{
  while true {
    let test = linearTransform(uniform(), range)
    if uniform() < pdf(test/max) {
      return test
    }
  }
}






// TODO: implement the following; revisit implementations of existing
// gamma, beta, chisquare, noncentral chi square, f, noncentral f, standard Cauchy, standard T, weibull, power,
// lapalce, fumbel, pareto, vonmises, logistic, lognormal, rayleigh, wald, zipf
// geometric, hypergeometric, triangular, logseries ???















