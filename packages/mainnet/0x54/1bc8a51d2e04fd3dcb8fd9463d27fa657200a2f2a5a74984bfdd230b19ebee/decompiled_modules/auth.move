module 0x541bc8a51d2e04fd3dcb8fd9463d27fa657200a2f2a5a74984bfdd230b19ebee::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

