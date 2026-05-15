module 0xb875de698170ddd09d2edd07041e0644f711dfc8693f613d8b2b2c7bd81bab2b::ud30x9 {
    struct UD30x9 has copy, drop, store {
        pos0: u128,
    }

    public fun max() : UD30x9 {
        UD30x9{pos0: 340282366920938463463374607431768211455}
    }

    public fun one() : UD30x9 {
        UD30x9{pos0: 1000000000}
    }

    public fun unwrap(arg0: UD30x9) : u128 {
        arg0.pos0
    }

    public fun wrap(arg0: u128) : UD30x9 {
        UD30x9{pos0: arg0}
    }

    public fun zero() : UD30x9 {
        UD30x9{pos0: 0}
    }

    // decompiled from Move bytecode v7
}

