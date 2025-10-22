module 0x96951f5a2cc16f1501b1c20d47ccac37e08b24d8fe4817ee2cd7fdb9da6d9f26::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

