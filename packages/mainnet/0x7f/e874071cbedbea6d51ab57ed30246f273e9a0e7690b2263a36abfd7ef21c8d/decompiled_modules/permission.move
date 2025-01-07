module 0x7fe874071cbedbea6d51ab57ed30246f273e9a0e7690b2263a36abfd7ef21c8d::permission {
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

