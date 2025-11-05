module 0x7b0c676e1def01fef18dedc3f86eee783f0aa9e10d0913ececf9a16a2c6a498a::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

