module 0xf416de37de34e3b1597a0e0d3244e79124f0c3ee60a39eb7cb314948836f4976::sd29x9 {
    struct SD29x9 has copy, drop, store {
        pos0: u128,
    }

    public(friend) fun from_bits(arg0: u128) : SD29x9 {
        SD29x9{pos0: arg0}
    }

    public fun max() : SD29x9 {
        SD29x9{pos0: 170141183460469231731687303715884105727}
    }

    public fun min() : SD29x9 {
        SD29x9{pos0: 170141183460469231731687303715884105728}
    }

    public fun one() : SD29x9 {
        SD29x9{pos0: 1000000000}
    }

    public(friend) fun two_complement(arg0: u128) : u128 {
        ((((arg0 ^ 340282366920938463463374607431768211455) as u256) + 1 & 340282366920938463463374607431768211455) as u128)
    }

    public fun unwrap(arg0: SD29x9) : u128 {
        arg0.pos0
    }

    public fun wrap(arg0: u128, arg1: bool) : SD29x9 {
        if (arg0 == 0) {
            zero()
        } else {
            if (arg0 > 170141183460469231731687303715884105727) {
                abort 13835058600743010305
            };
            if (arg1) {
                SD29x9{pos0: two_complement(arg0)}
            } else {
                SD29x9{pos0: arg0}
            }
        }
    }

    public fun zero() : SD29x9 {
        SD29x9{pos0: 0}
    }

    // decompiled from Move bytecode v7
}

