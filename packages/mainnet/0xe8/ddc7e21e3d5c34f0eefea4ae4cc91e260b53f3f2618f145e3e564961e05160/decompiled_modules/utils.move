module 0xe8ddc7e21e3d5c34f0eefea4ae4cc91e260b53f3f2618f145e3e564961e05160::utils {
    struct Marker<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun marker<T0>() : Marker<T0> {
        Marker<T0>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

