module 0x7d8f3c2f935aad544b43297937128cf2ea122ffae40c8183086db05102f6e9a9::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

