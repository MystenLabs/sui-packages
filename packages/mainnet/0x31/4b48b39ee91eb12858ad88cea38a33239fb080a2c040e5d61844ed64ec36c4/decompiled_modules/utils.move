module 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::utils {
    struct Marker<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun marker<T0>() : Marker<T0> {
        Marker<T0>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

