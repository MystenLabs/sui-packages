module 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::decimal {
    struct Decimal has copy, drop, store {
        value: u256,
    }

    public fun floor(arg0: Decimal) : u64 {
        abort 0
    }

    public fun from(arg0: u64) : Decimal {
        abort 0
    }

    public fun mul(arg0: Decimal, arg1: Decimal) : Decimal {
        abort 0
    }

    // decompiled from Move bytecode v6
}

