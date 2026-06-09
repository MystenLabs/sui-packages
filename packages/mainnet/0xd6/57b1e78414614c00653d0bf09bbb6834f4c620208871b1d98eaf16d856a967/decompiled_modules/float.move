module 0xd657b1e78414614c00653d0bf09bbb6834f4c620208871b1d98eaf16d856a967::float {
    struct Decimal has copy, drop, store {
        value: u256,
    }

    public fun add(arg0: Decimal, arg1: Decimal) : Decimal {
        abort 0
    }

    public fun add_u64(arg0: &Decimal, arg1: u64) : Decimal {
        abort 0
    }

    public fun ceil(arg0: Decimal) : u64 {
        abort 0
    }

    public fun div(arg0: Decimal, arg1: Decimal) : Decimal {
        abort 0
    }

    public fun div_u64(arg0: Decimal, arg1: u64) : Decimal {
        abort 0
    }

    public fun eq(arg0: Decimal, arg1: Decimal) : bool {
        abort 0
    }

    public fun floor(arg0: Decimal) : u64 {
        abort 0
    }

    public fun from(arg0: u64) : Decimal {
        abort 0
    }

    public fun from_percent(arg0: u8) : Decimal {
        abort 0
    }

    public fun from_quotient(arg0: u64, arg1: u64) : Decimal {
        abort 0
    }

    public fun ge(arg0: Decimal, arg1: Decimal) : bool {
        abort 0
    }

    public fun ge_u64(arg0: Decimal, arg1: u64) : bool {
        abort 0
    }

    public fun gt(arg0: Decimal, arg1: Decimal) : bool {
        abort 0
    }

    public fun gt_u64(arg0: &Decimal, arg1: u64) : bool {
        abort 0
    }

    public fun int_div(arg0: u64, arg1: Decimal) : u64 {
        abort 0
    }

    public fun int_mul(arg0: Decimal, arg1: u64) : u64 {
        abort 0
    }

    public fun is_zero(arg0: &Decimal) : bool {
        abort 0
    }

    public fun le(arg0: Decimal, arg1: Decimal) : bool {
        abort 0
    }

    public fun lt(arg0: Decimal, arg1: Decimal) : bool {
        abort 0
    }

    public fun min(arg0: Decimal, arg1: Decimal) : Decimal {
        abort 0
    }

    public fun mul(arg0: Decimal, arg1: Decimal) : Decimal {
        abort 0
    }

    public fun mul_u64(arg0: Decimal, arg1: u64) : Decimal {
        abort 0
    }

    public fun one() : Decimal {
        abort 0
    }

    public fun saturating_sub(arg0: Decimal, arg1: Decimal) : Decimal {
        abort 0
    }

    public fun sub(arg0: Decimal, arg1: Decimal) : Decimal {
        abort 0
    }

    public fun sub_u64(arg0: Decimal, arg1: u64) : Decimal {
        abort 0
    }

    public fun zero() : Decimal {
        abort 0
    }

    // decompiled from Move bytecode v7
}

