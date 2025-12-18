module 0x1::internal {
    struct Permit<phantom T0> has drop {
        dummy_field: bool,
    }

    public fun permit<T0>() : Permit<T0> {
        Permit<T0>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

