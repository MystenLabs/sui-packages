module 0x1::uq64_64 {
    struct UQ64_64 has copy, drop, store {
        pos0: u128,
    }

    public fun add(arg0: UQ64_64, arg1: UQ64_64) : UQ64_64 {
        let v0 = (arg0.pos0 as u256) + (arg1.pos0 as u256);
        if (v0 > 340282366920938463463374607431768211455) {
            abort 13906834483581419527
        };
        UQ64_64{pos0: (v0 as u128)}
    }

    public fun div(arg0: UQ64_64, arg1: UQ64_64) : UQ64_64 {
        UQ64_64{pos0: int_div(arg0.pos0, arg1)}
    }

    public fun from_int(arg0: u64) : UQ64_64 {
        UQ64_64{pos0: (arg0 as u128) << 64}
    }

    public fun from_quotient(arg0: u128, arg1: u128) : UQ64_64 {
        if (arg1 == 0) {
            abort 13906834414861549569
        };
        let v0 = ((arg0 as u256) << 128) / ((arg1 as u256) << 128 - 64);
        if (v0 == 0 && arg0 != 0) {
            abort 13906834419156647939
        };
        if (v0 > 340282366920938463463374607431768211455) {
            abort 13906834423451746309
        };
        UQ64_64{pos0: (v0 as u128)}
    }

    public fun from_raw(arg0: u128) : UQ64_64 {
        UQ64_64{pos0: arg0}
    }

    public fun ge(arg0: UQ64_64, arg1: UQ64_64) : bool {
        arg0.pos0 >= arg1.pos0
    }

    public fun gt(arg0: UQ64_64, arg1: UQ64_64) : bool {
        arg0.pos0 > arg1.pos0
    }

    public fun int_div(arg0: u128, arg1: UQ64_64) : u128 {
        let v0 = arg1.pos0;
        if (v0 == 0) {
            abort 13906834689739980809
        };
        let v1 = ((arg0 as u256) << 64) / (v0 as u256);
        if (v1 > 340282366920938463463374607431768211455) {
            abort 13906834694034817031
        };
        (v1 as u128)
    }

    public fun int_mul(arg0: u128, arg1: UQ64_64) : u128 {
        let v0 = (arg0 as u256) * (arg1.pos0 as u256) >> 64;
        if (v0 > 340282366920938463463374607431768211455) {
            abort 13906834633905274887
        };
        (v0 as u128)
    }

    public fun le(arg0: UQ64_64, arg1: UQ64_64) : bool {
        arg0.pos0 <= arg1.pos0
    }

    public fun lt(arg0: UQ64_64, arg1: UQ64_64) : bool {
        arg0.pos0 < arg1.pos0
    }

    public fun mul(arg0: UQ64_64, arg1: UQ64_64) : UQ64_64 {
        UQ64_64{pos0: int_mul(arg0.pos0, arg1)}
    }

    public fun sub(arg0: UQ64_64, arg1: UQ64_64) : UQ64_64 {
        let v0 = arg0.pos0;
        let v1 = arg1.pos0;
        if (v0 < v1) {
            abort 13906834509351223303
        };
        UQ64_64{pos0: v0 - v1}
    }

    public fun to_int(arg0: UQ64_64) : u64 {
        ((arg0.pos0 >> 64) as u64)
    }

    public fun to_raw(arg0: UQ64_64) : u128 {
        arg0.pos0
    }

    // decompiled from Move bytecode v6
}

