module 0x5ecfe28cc81bb7c51549622196b61e386002a9ec827070ac1cf00e4c48baa120::permission {
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

