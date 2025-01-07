module 0xe62b6366b9c95813a4990a9d6f1976f8c7ced3837b1e7a7d7063dd3fb0535a1f::permission {
    struct Permission<phantom T0> has store {
        dummy_field: bool,
    }

    public fun cp<T0>(arg0: &Permission<T0>) : Permission<T0> {
        new<T0>()
    }

    public fun destroy<T0>(arg0: Permission<T0>) {
        let Permission {  } = arg0;
    }

    public(friend) fun new<T0>() : Permission<T0> {
        Permission<T0>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

