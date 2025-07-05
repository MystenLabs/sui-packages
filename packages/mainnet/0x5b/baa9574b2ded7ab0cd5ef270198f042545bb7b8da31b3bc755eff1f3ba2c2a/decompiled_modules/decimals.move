module 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::decimals {
    struct Decimal has copy, drop, store {
        pos0: u128,
    }

    public fun add(arg0: Decimal, arg1: Decimal) : Decimal {
        let v0 = (arg0.pos0 as u256) + (arg1.pos0 as u256);
        assert!(v0 < 340282366920938463463374607431768211455, 13906834788524163080);
        Decimal{pos0: (v0 as u128)}
    }

    public fun div(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{pos0: int_div(arg0.pos0, arg1)}
    }

    public fun eq(arg0: Decimal, arg1: Decimal) : bool {
        arg0.pos0 == arg1.pos0
    }

    public fun from_int(arg0: u64) : Decimal {
        Decimal{pos0: (arg0 as u128) << 64}
    }

    public fun from_percentage(arg0: u64) : Decimal {
        from_u64(arg0, 4)
    }

    public fun from_u128(arg0: u128, arg1: u8) : Decimal {
        assert!(arg1 != 0, 13906834462106255362);
        let v0 = ((arg0 as u256) << 128) / ((0x1::u64::pow(10, arg1) as u256) << 64);
        assert!(v0 != 0 || arg0 == 0, 13906834492171157508);
        assert!(v0 <= 340282366920938463463374607431768211455, 13906834509351157766);
        Decimal{pos0: (v0 as u128)}
    }

    public fun from_u128_denominator(arg0: u128, arg1: u128) : Decimal {
        assert!(arg1 != 0, 13906834530825732098);
        let v0 = ((arg0 as u256) << 128) / ((arg1 as u256) << 64);
        assert!(v0 != 0 || arg0 == 0, 13906834556595666948);
        assert!(v0 <= 340282366920938463463374607431768211455, 13906834573775667206);
        Decimal{pos0: (v0 as u128)}
    }

    public fun from_u64(arg0: u64, arg1: u8) : Decimal {
        assert!(arg1 != 0, 13906834277422661634);
        let v0 = ((arg0 as u256) << 128) / ((0x1::u64::pow(10, arg1) as u256) << 64);
        assert!(v0 != 0 || arg0 == 0, 13906834307487563780);
        assert!(v0 <= 340282366920938463463374607431768211455, 13906834324667564038);
        Decimal{pos0: (v0 as u128)}
    }

    public fun from_u64_denominator(arg0: u64, arg1: u64) : Decimal {
        assert!(arg1 != 0, 13906834397681745922);
        let v0 = ((arg0 as u256) << 128) / ((arg1 as u256) << 64);
        assert!(v0 != 0 || arg0 == 0, 13906834423451680772);
        assert!(v0 <= 340282366920938463463374607431768211455, 13906834440631681030);
        Decimal{pos0: (v0 as u128)}
    }

    public fun ge(arg0: Decimal, arg1: Decimal) : bool {
        arg0.pos0 >= arg1.pos0
    }

    public fun gt(arg0: Decimal, arg1: Decimal) : bool {
        arg0.pos0 > arg1.pos0
    }

    public fun int_div(arg0: u128, arg1: Decimal) : u128 {
        assert!(arg1.pos0 != 0, 13906834719804817418);
        let v0 = ((arg0 as u256) << 64) / (arg1.pos0 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 13906834745574490120);
        (v0 as u128)
    }

    public fun int_mul(arg0: u128, arg1: Decimal) : u128 {
        let v0 = (arg0 as u256) * (arg1.pos0 as u256) >> 64;
        assert!(v0 <= 340282366920938463463374607431768211455, 13906834681149980680);
        (v0 as u128)
    }

    public fun is_zero(arg0: Decimal) : bool {
        arg0.pos0 == 0
    }

    public fun le(arg0: Decimal, arg1: Decimal) : bool {
        arg0.pos0 <= arg1.pos0
    }

    public fun lt(arg0: Decimal, arg1: Decimal) : bool {
        arg0.pos0 < arg1.pos0
    }

    public fun max(arg0: Decimal, arg1: Decimal) : Decimal {
        if (gt(arg0, arg1)) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: Decimal, arg1: Decimal) : Decimal {
        if (lt(arg0, arg1)) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{pos0: int_mul(arg0.pos0, arg1)}
    }

    public fun mul_div(arg0: Decimal, arg1: Decimal, arg2: Decimal) : Decimal {
        let v0 = (arg0.pos0 as u256) * (arg1.pos0 as u256) / (arg2.pos0 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 13906834840063770632);
        Decimal{pos0: (v0 as u128)}
    }

    public fun mul_div_trunc(arg0: Decimal, arg1: Decimal, arg2: Decimal) : Decimal {
        let v0 = (arg0.pos0 as u256) * (arg1.pos0 as u256) / (arg2.pos0 as u256);
        if (v0 <= 340282366920938463463374607431768211455) {
            Decimal{pos0: (v0 as u128)}
        } else {
            Decimal{pos0: 340282366920938463463374607431768211455}
        }
    }

    public fun percentage(arg0: Decimal, arg1: u64) : Decimal {
        mul(arg0, from_u64(arg1, 4))
    }

    public fun positive(arg0: Decimal) : bool {
        arg0.pos0 > 0
    }

    public fun round_percentage(arg0: Decimal) : u64 {
        round_u64(arg0, 4)
    }

    public fun round_u64(arg0: Decimal, arg1: u8) : u64 {
        let v0 = 0x1::u128::pow(10, arg1);
        let v1 = (to_int(arg0) as u128) * v0 + ((to_fractional(arg0) as u128) * v0 + 9223372036854775808 >> 64);
        assert!(v1 <= 18446744073709551615, 13906835080581939208);
        (v1 as u64)
    }

    public fun sub(arg0: Decimal, arg1: Decimal) : Decimal {
        assert!(arg0.pos0 >= arg1.pos0, 13906834809998999560);
        Decimal{pos0: arg0.pos0 - arg1.pos0}
    }

    public fun to_128(arg0: Decimal, arg1: u8) : u128 {
        let v0 = 0x1::u128::pow(10, arg1);
        let v1 = (to_int(arg0) as u128) * v0 + ((to_fractional(arg0) as u128) * v0 >> 64);
        assert!(v1 <= 340282366920938463463374607431768211455, 13906834977502724104);
        v1
    }

    public fun to_fractional(arg0: Decimal) : u64 {
        ((arg0.pos0 & 18446744073709551615) as u64)
    }

    public fun to_int(arg0: Decimal) : u64 {
        ((arg0.pos0 >> 64) as u64)
    }

    public fun to_percentage(arg0: Decimal) : u64 {
        to_u64(arg0, 4)
    }

    public fun to_scaled_int(arg0: Decimal) : Decimal {
        Decimal{pos0: arg0.pos0 >> 64 << 64}
    }

    public fun to_u64(arg0: Decimal, arg1: u8) : u64 {
        let v0 = 0x1::u128::pow(10, arg1);
        let v1 = (to_int(arg0) as u128) * v0 + ((to_fractional(arg0) as u128) * v0 >> 64);
        assert!(v1 <= 18446744073709551615, 13906835029042331656);
        (v1 as u64)
    }

    public fun zero() : Decimal {
        Decimal{pos0: 0}
    }

    // decompiled from Move bytecode v6
}

