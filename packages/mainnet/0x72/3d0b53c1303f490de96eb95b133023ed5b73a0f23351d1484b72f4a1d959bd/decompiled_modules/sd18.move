module 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18 {
    struct SD18 has copy, drop, store {
        raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256,
    }

    public fun abs(arg0: SD18) : SD18 {
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs(arg0.raw)}
    }

    public fun add(arg0: SD18, arg1: SD18) : SD18 {
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::add(arg0.raw, arg1.raw)}
    }

    public fun avg_down(arg0: SD18, arg1: SD18) : SD18 {
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(flip(0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::average(flip(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::bits(arg0.raw)), flip(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::bits(arg1.raw)))))}
    }

    public fun avg_up(arg0: SD18, arg1: SD18) : SD18 {
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(flip(0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::average_up(flip(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::bits(arg0.raw)), flip(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::bits(arg1.raw)))))}
    }

    public fun ceil(arg0: SD18) : SD18 {
        let v0 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1000000000000000000);
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_ceil(arg0.raw, v0), v0)}
    }

    public fun div_down(arg0: SD18, arg1: SD18) : SD18 {
        div_r(arg0, arg1, false)
    }

    fun div_r(arg0: SD18, arg1: SD18, arg2: bool) : SD18 {
        SD18{raw: round_mag(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(arg0.raw) != 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(arg1.raw), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(arg0.raw), 1000000000000000000, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(arg1.raw), arg2)}
    }

    public fun div_up(arg0: SD18, arg1: SD18) : SD18 {
        div_r(arg0, arg1, true)
    }

    public fun eq(arg0: SD18, arg1: SD18) : bool {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::eq(arg0.raw, arg1.raw)
    }

    fun flip(arg0: u256) : u256 {
        if (arg0 >= 57896044618658097711785492504343953926634992332820282019728792003956564819968) {
            arg0 - 57896044618658097711785492504343953926634992332820282019728792003956564819968
        } else {
            arg0 + 57896044618658097711785492504343953926634992332820282019728792003956564819968
        }
    }

    public fun floor(arg0: SD18) : SD18 {
        let v0 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1000000000000000000);
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_floor(arg0.raw, v0), v0)}
    }

    public fun frac(arg0: SD18) : SD18 {
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mod(arg0.raw, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1000000000000000000))}
    }

    public fun from_int(arg0: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256) : SD18 {
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(arg0, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1000000000000000000))}
    }

    public fun from_ud18(arg0: 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18) : SD18 {
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_u(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::unwrap(arg0))}
    }

    public fun ge(arg0: SD18, arg1: SD18) : bool {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::ge(arg0.raw, arg1.raw)
    }

    public fun gt(arg0: SD18, arg1: SD18) : bool {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::gt(arg0.raw, arg1.raw)
    }

    public fun inv_down(arg0: SD18) : SD18 {
        div_r(one(), arg0, false)
    }

    public fun inv_up(arg0: SD18) : SD18 {
        div_r(one(), arg0, true)
    }

    public fun le(arg0: SD18, arg1: SD18) : bool {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::le(arg0.raw, arg1.raw)
    }

    public fun lt(arg0: SD18, arg1: SD18) : bool {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::lt(arg0.raw, arg1.raw)
    }

    public fun max(arg0: SD18, arg1: SD18) : SD18 {
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::max(arg0.raw, arg1.raw)}
    }

    public fun min(arg0: SD18, arg1: SD18) : SD18 {
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::min(arg0.raw, arg1.raw)}
    }

    public fun mul_down(arg0: SD18, arg1: SD18) : SD18 {
        mul_r(arg0, arg1, false)
    }

    fun mul_r(arg0: SD18, arg1: SD18, arg2: bool) : SD18 {
        SD18{raw: round_mag(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(arg0.raw) != 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::is_neg(arg1.raw), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(arg0.raw), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::abs_u(arg1.raw), 1000000000000000000, arg2)}
    }

    public fun mul_up(arg0: SD18, arg1: SD18) : SD18 {
        mul_r(arg0, arg1, true)
    }

    public fun neg(arg0: SD18) : SD18 {
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::neg(arg0.raw)}
    }

    public fun one() : SD18 {
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1000000000000000000)}
    }

    public fun round(arg0: SD18) : SD18 {
        let v0 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1000000000000000000);
        if (0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::bits(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mod(arg0.raw, v0)) >= 500000000000000000) {
            SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::add(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_floor(arg0.raw, v0), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1)), v0)}
        } else {
            SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_floor(arg0.raw, v0), v0)}
        }
    }

    fun round_mag(arg0: bool, arg1: u256, arg2: u256, arg3: u256, arg4: bool) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        let v0 = if (arg0 != arg4) {
            0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(arg1, arg2, arg3)
        } else {
            0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(arg1, arg2, arg3)
        };
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_parts(arg0, v0)
    }

    public fun sub(arg0: SD18, arg1: SD18) : SD18 {
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::sub(arg0.raw, arg1.raw)}
    }

    public fun to_int_down(arg0: SD18) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_floor(arg0.raw, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1000000000000000000))
    }

    public fun to_int_trunc(arg0: SD18) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_trunc(arg0.raw, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1000000000000000000))
    }

    public fun to_int_up(arg0: SD18) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_ceil(arg0.raw, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1000000000000000000))
    }

    public fun to_ud18(arg0: SD18) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::UD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::to_u(arg0.raw))
    }

    public fun unwrap(arg0: SD18) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        arg0.raw
    }

    public fun wrap(arg0: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256) : SD18 {
        SD18{raw: arg0}
    }

    public fun zero() : SD18 {
        SD18{raw: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero()}
    }

    // decompiled from Move bytecode v7
}

