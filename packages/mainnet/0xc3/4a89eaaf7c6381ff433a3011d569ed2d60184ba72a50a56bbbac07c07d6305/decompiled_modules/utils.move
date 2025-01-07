module 0xc34a89eaaf7c6381ff433a3011d569ed2d60184ba72a50a56bbbac07c07d6305::utils {
    struct Marker<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun marker<T0>() : Marker<T0> {
        Marker<T0>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

