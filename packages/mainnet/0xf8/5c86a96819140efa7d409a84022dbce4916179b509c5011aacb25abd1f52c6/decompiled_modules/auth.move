module 0xf85c86a96819140efa7d409a84022dbce4916179b509c5011aacb25abd1f52c6::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

