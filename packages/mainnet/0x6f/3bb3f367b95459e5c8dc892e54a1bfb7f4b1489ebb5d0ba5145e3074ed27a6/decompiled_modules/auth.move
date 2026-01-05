module 0x6f3bb3f367b95459e5c8dc892e54a1bfb7f4b1489ebb5d0ba5145e3074ed27a6::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

