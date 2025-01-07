module 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::point {
    struct Point has copy, drop, store {
        slope: 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128,
        bias: 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128,
        ts: u64,
    }

    public fun bias(arg0: &Point) : 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128 {
        arg0.bias
    }

    public fun new(arg0: 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128, arg1: 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128, arg2: u64) : Point {
        Point{
            slope : arg1,
            bias  : arg0,
            ts    : arg2,
        }
    }

    public fun slope(arg0: &Point) : 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::i128::I128 {
        arg0.slope
    }

    public fun ts(arg0: &Point) : u64 {
        arg0.ts
    }

    // decompiled from Move bytecode v6
}

