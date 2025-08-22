module 0xaa2b61f8fe9b2623ab1747cedded7dda5d2d6c2b37894e1db277ff18b46445c0::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

