module 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::permission {
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

