module 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::ud18 {
    struct UD18 has copy, drop, store {
        raw: u256,
    }

    public fun add(arg0: UD18, arg1: UD18) : UD18 {
        UD18{raw: arg0.raw + arg1.raw}
    }

    public fun avg_down(arg0: UD18, arg1: UD18) : UD18 {
        UD18{raw: 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::average(arg0.raw, arg1.raw)}
    }

    public fun avg_up(arg0: UD18, arg1: UD18) : UD18 {
        UD18{raw: 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::average_up(arg0.raw, arg1.raw)}
    }

    public fun ceil(arg0: UD18) : UD18 {
        UD18{raw: 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::div_up(arg0.raw, 1000000000000000000) * 1000000000000000000}
    }

    public fun div_down(arg0: UD18, arg1: UD18) : UD18 {
        UD18{raw: 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(arg0.raw, 1000000000000000000, arg1.raw)}
    }

    public fun div_up(arg0: UD18, arg1: UD18) : UD18 {
        UD18{raw: 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(arg0.raw, 1000000000000000000, arg1.raw)}
    }

    public fun eq(arg0: UD18, arg1: UD18) : bool {
        arg0.raw == arg1.raw
    }

    public fun floor(arg0: UD18) : UD18 {
        UD18{raw: arg0.raw / 1000000000000000000 * 1000000000000000000}
    }

    public fun frac(arg0: UD18) : UD18 {
        UD18{raw: arg0.raw % 1000000000000000000}
    }

    public fun from_int(arg0: u256) : UD18 {
        UD18{raw: arg0 * 1000000000000000000}
    }

    public fun ge(arg0: UD18, arg1: UD18) : bool {
        arg0.raw >= arg1.raw
    }

    public fun gt(arg0: UD18, arg1: UD18) : bool {
        arg0.raw > arg1.raw
    }

    public fun inv_down(arg0: UD18) : UD18 {
        UD18{raw: 1000000000000000000000000000000000000 / arg0.raw}
    }

    public fun inv_up(arg0: UD18) : UD18 {
        let v0 = if (1000000000000000000000000000000000000 % arg0.raw != 0) {
            1000000000000000000000000000000000000 / arg0.raw + 1
        } else {
            1000000000000000000000000000000000000 / arg0.raw
        };
        UD18{raw: v0}
    }

    public fun le(arg0: UD18, arg1: UD18) : bool {
        arg0.raw <= arg1.raw
    }

    public fun lt(arg0: UD18, arg1: UD18) : bool {
        arg0.raw < arg1.raw
    }

    public fun max(arg0: UD18, arg1: UD18) : UD18 {
        if (arg0.raw <= arg1.raw) {
            arg1
        } else {
            arg0
        }
    }

    public fun max_value() : UD18 {
        UD18{raw: 115792089237316195423570985008687907853269984665640564039457584007913129639935}
    }

    public fun min(arg0: UD18, arg1: UD18) : UD18 {
        if (arg0.raw <= arg1.raw) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_down(arg0: UD18, arg1: UD18) : UD18 {
        UD18{raw: 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_down(arg0.raw, arg1.raw, 1000000000000000000)}
    }

    public fun mul_up(arg0: UD18, arg1: UD18) : UD18 {
        UD18{raw: 0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::mul_div_up(arg0.raw, arg1.raw, 1000000000000000000)}
    }

    public fun one() : UD18 {
        UD18{raw: 1000000000000000000}
    }

    public fun round(arg0: UD18) : UD18 {
        if (arg0.raw % 1000000000000000000 >= 500000000000000000) {
            UD18{raw: (arg0.raw / 1000000000000000000 + 1) * 1000000000000000000}
        } else {
            UD18{raw: arg0.raw / 1000000000000000000 * 1000000000000000000}
        }
    }

    public fun sub(arg0: UD18, arg1: UD18) : UD18 {
        UD18{raw: arg0.raw - arg1.raw}
    }

    public fun to_int_down(arg0: UD18) : u256 {
        arg0.raw / 1000000000000000000
    }

    public fun to_int_up(arg0: UD18) : u256 {
        0xe73c9df23e024751edd7063232c1e8c849f8af06a9ec605cd7c26beb4fb30fce::full256::div_up(arg0.raw, 1000000000000000000)
    }

    public fun unwrap(arg0: UD18) : u256 {
        arg0.raw
    }

    public fun wrap(arg0: u256) : UD18 {
        UD18{raw: arg0}
    }

    public fun zero() : UD18 {
        UD18{raw: 0}
    }

    // decompiled from Move bytecode v7
}

