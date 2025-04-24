module 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals {
    struct Decimal has copy, drop, store {
        pos0: u128,
    }

    public fun add(arg0: Decimal, arg1: Decimal) : Decimal {
        let v0 = (arg0.pos0 as u256) + (arg1.pos0 as u256);
        assert!(v0 < 340282366920938463463374607431768211455, 9223372599495950344);
        Decimal{pos0: (v0 as u128)}
    }

    public fun div(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{pos0: int_div(arg0.pos0, arg1)}
    }

    public fun eq(arg0: Decimal, arg1: Decimal) : bool {
        arg0.pos0 == arg1.pos0
    }

    public fun from_percentage(arg0: u64) : Decimal {
        from_u64(arg0, 4)
    }

    public fun from_u128(arg0: u128, arg1: u8) : Decimal {
        assert!(arg1 != 0, 9223372273078042626);
        let v0 = ((arg0 as u256) << 128) / ((0x1::u64::pow(10, arg1) as u256) << 64);
        assert!(v0 != 0 || arg0 == 0, 9223372303142944772);
        assert!(v0 <= 340282366920938463463374607431768211455, 9223372320322945030);
        Decimal{pos0: (v0 as u128)}
    }

    public fun from_u128_denominator(arg0: u128, arg1: u128) : Decimal {
        assert!(arg1 != 0, 9223372341797519362);
        let v0 = ((arg0 as u256) << 128) / ((arg1 as u256) << 64);
        assert!(v0 != 0 || arg0 == 0, 9223372367567454212);
        assert!(v0 <= 340282366920938463463374607431768211455, 9223372384747454470);
        Decimal{pos0: (v0 as u128)}
    }

    public fun from_u64(arg0: u64, arg1: u8) : Decimal {
        assert!(arg1 != 0, 9223372139934056450);
        let v0 = ((arg0 as u256) << 128) / ((0x1::u64::pow(10, arg1) as u256) << 64);
        assert!(v0 != 0 || arg0 == 0, 9223372169998958596);
        assert!(v0 <= 340282366920938463463374607431768211455, 9223372187178958854);
        Decimal{pos0: (v0 as u128)}
    }

    public fun from_u64_denominator(arg0: u64, arg1: u64) : Decimal {
        assert!(arg1 != 0, 9223372208653533186);
        let v0 = ((arg0 as u256) << 128) / ((arg1 as u256) << 64);
        assert!(v0 != 0 || arg0 == 0, 9223372234423468036);
        assert!(v0 <= 340282366920938463463374607431768211455, 9223372251603468294);
        Decimal{pos0: (v0 as u128)}
    }

    public fun ge(arg0: Decimal, arg1: Decimal) : bool {
        arg0.pos0 >= arg1.pos0
    }

    public fun gt(arg0: Decimal, arg1: Decimal) : bool {
        arg0.pos0 > arg1.pos0
    }

    public fun int_div(arg0: u128, arg1: Decimal) : u128 {
        assert!(arg1.pos0 != 0, 9223372530776604682);
        let v0 = ((arg0 as u256) << 64) / (arg1.pos0 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 9223372556546277384);
        (v0 as u128)
    }

    public fun int_mul(arg0: u128, arg1: Decimal) : u128 {
        let v0 = (arg0 as u256) * (arg1.pos0 as u256) >> 64;
        assert!(v0 <= 340282366920938463463374607431768211455, 9223372492121767944);
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

    public fun mul(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{pos0: int_mul(arg0.pos0, arg1)}
    }

    public fun mul_div(arg0: Decimal, arg1: Decimal, arg2: Decimal) : Decimal {
        let v0 = (arg0.pos0 as u256) * (arg1.pos0 as u256) / (arg2.pos0 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 9223372651035557896);
        Decimal{pos0: (v0 as u128)}
    }

    public fun percentage(arg0: Decimal, arg1: u64) : Decimal {
        mul(arg0, from_u64(arg1, 4))
    }

    public fun positive(arg0: Decimal) : bool {
        arg0.pos0 > 0
    }

    public fun sub(arg0: Decimal, arg1: Decimal) : Decimal {
        assert!(arg0.pos0 >= arg1.pos0, 9223372620970786824);
        Decimal{pos0: arg0.pos0 - arg1.pos0}
    }

    public fun to_128(arg0: Decimal, arg1: u8) : u64 {
        let v0 = (to_int(arg0) as u256) | (to_fractional(arg0) as u256) * 0x1::u256::pow(10, arg1) >> 128;
        assert!(v0 <= 340282366920938463463374607431768211455, 9223372745524838408);
        (v0 as u64)
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

    public fun to_u64(arg0: Decimal, arg1: u8) : u64 {
        let v0 = 0x1::u128::pow(10, arg1);
        let v1 = (to_int(arg0) as u128) * v0 + ((to_fractional(arg0) as u128) * v0 + 9223372036854775808 >> 64);
        assert!(v1 <= 18446744073709551615, 9223372797064445960);
        (v1 as u64)
    }

    public fun zero() : Decimal {
        Decimal{pos0: 0}
    }

    // decompiled from Move bytecode v6
}

