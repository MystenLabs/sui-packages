module 0x3311b6202ee5dce0f4a7e961e19472dd7146e0cc4acb181ed7d50f29cf30a454::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

