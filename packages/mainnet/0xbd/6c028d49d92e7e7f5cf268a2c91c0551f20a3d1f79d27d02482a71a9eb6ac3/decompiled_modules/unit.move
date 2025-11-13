module 0xfa84e5620fda505bbeb9178316a555e1db36f8932dee44210dd88a6464a76ef6::unit {
    struct Unit has drop {
        dummy_field: bool,
    }

    public fun unit() : Unit {
        Unit{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

