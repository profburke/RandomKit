//
//  Sequences.swift
//  RandomKit
//
//  Created by Matthew Burke on 4/20/15.
//  Copyright (c) 2015 BlueDino Software. All rights reserved.
//

import Foundation





public struct UniformSequence: SequenceType
{
  public func generate() -> GeneratorOf<Double> {
    return GeneratorOf { uniform() }
  }
}


