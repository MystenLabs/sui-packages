module 0xb1e4ac51b2585c24e69256a2dcb230ae7f589ea3f530530019f7de954d6d840f::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

