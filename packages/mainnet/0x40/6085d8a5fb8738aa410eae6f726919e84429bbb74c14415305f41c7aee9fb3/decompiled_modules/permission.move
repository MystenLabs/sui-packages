module 0x406085d8a5fb8738aa410eae6f726919e84429bbb74c14415305f41c7aee9fb3::permission {
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

