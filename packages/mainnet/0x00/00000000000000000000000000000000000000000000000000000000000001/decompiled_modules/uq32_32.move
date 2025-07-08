module 0x1::uq32_32 {
    struct UQ32_32 has copy, drop, store {
        pos0: u64,
    }

    public fun add(arg0: UQ32_32, arg1: UQ32_32) : UQ32_32 {
        let v0 = (arg0.pos0 as u128) + (arg1.pos0 as u128);
        if (v0 > 18446744073709551615) {
            abort 13906834483581419527
        };
        UQ32_32{pos0: (v0 as u64)}
    }

    public fun div(arg0: UQ32_32, arg1: UQ32_32) : UQ32_32 {
        UQ32_32{pos0: int_div(arg0.pos0, arg1)}
    }

    public fun from_int(arg0: u32) : UQ32_32 {
        UQ32_32{pos0: (arg0 as u64) << 32}
    }

    public fun from_quotient(arg0: u64, arg1: u64) : UQ32_32 {
        if (arg1 == 0) {
            abort 13906834414861549569
        };
        let v0 = ((arg0 as u128) << 64) / ((arg1 as u128) << 64 - 32);
        if (v0 == 0 && arg0 != 0) {
            abort 13906834419156647939
        };
        if (v0 > 18446744073709551615) {
            abort 13906834423451746309
        };
        UQ32_32{pos0: (v0 as u64)}
    }

    public fun from_raw(arg0: u64) : UQ32_32 {
        UQ32_32{pos0: arg0}
    }

    public fun ge(arg0: UQ32_32, arg1: UQ32_32) : bool {
        arg0.pos0 >= arg1.pos0
    }

    public fun gt(arg0: UQ32_32, arg1: UQ32_32) : bool {
        arg0.pos0 > arg1.pos0
    }

    public fun int_div(arg0: u64, arg1: UQ32_32) : u64 {
        let v0 = arg1.pos0;
        if (v0 == 0) {
            abort 13906834689739980809
        };
        let v1 = ((arg0 as u128) << 32) / (v0 as u128);
        if (v1 > 18446744073709551615) {
            abort 13906834694034817031
        };
        (v1 as u64)
    }

    public fun int_mul(arg0: u64, arg1: UQ32_32) : u64 {
        let v0 = (arg0 as u128) * (arg1.pos0 as u128) >> 32;
        if (v0 > 18446744073709551615) {
            abort 13906834633905274887
        };
        (v0 as u64)
    }

    public fun le(arg0: UQ32_32, arg1: UQ32_32) : bool {
        arg0.pos0 <= arg1.pos0
    }

    public fun lt(arg0: UQ32_32, arg1: UQ32_32) : bool {
        arg0.pos0 < arg1.pos0
    }

    public fun mul(arg0: UQ32_32, arg1: UQ32_32) : UQ32_32 {
        UQ32_32{pos0: int_mul(arg0.pos0, arg1)}
    }

    public fun sub(arg0: UQ32_32, arg1: UQ32_32) : UQ32_32 {
        let v0 = arg0.pos0;
        let v1 = arg1.pos0;
        if (v0 < v1) {
            abort 13906834509351223303
        };
        UQ32_32{pos0: v0 - v1}
    }

    public fun to_int(arg0: UQ32_32) : u32 {
        ((arg0.pos0 >> 32) as u32)
    }

    public fun to_raw(arg0: UQ32_32) : u64 {
        arg0.pos0
    }

    // decompiled from Move bytecode v6
}

