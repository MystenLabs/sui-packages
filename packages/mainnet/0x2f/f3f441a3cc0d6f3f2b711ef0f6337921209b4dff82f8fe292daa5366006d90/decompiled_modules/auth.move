module 0x2ff3f441a3cc0d6f3f2b711ef0f6337921209b4dff82f8fe292daa5366006d90::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

