module 0x49572a64f6e256294bd187ce644a5a80efca79bb22320e0e98dad5d31b4bde4e::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

