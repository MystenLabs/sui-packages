module 0x8169b4d3b86879b2b54cbf2c65b51c5c768252be1e3836e2d8c1eedb1300ddf9::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

