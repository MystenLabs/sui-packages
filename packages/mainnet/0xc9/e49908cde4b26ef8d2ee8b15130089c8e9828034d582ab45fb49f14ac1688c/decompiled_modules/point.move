module 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point {
    struct Point has copy, drop, store {
        slope: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128,
        bias: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128,
        timestamp: u64,
    }

    public fun bias(arg0: &Point) : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128 {
        arg0.bias
    }

    public fun new(arg0: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128, arg1: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128, arg2: u64) : Point {
        Point{
            slope     : arg1,
            bias      : arg0,
            timestamp : arg2,
        }
    }

    public fun slope(arg0: &Point) : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128 {
        arg0.slope
    }

    public fun timestamp(arg0: &Point) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v6
}

