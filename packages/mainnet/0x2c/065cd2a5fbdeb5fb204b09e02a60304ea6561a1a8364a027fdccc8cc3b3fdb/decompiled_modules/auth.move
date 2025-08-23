module 0x2c065cd2a5fbdeb5fb204b09e02a60304ea6561a1a8364a027fdccc8cc3b3fdb::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

