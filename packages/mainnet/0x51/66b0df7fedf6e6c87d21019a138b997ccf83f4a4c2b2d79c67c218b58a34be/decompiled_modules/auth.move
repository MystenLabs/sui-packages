module 0x5166b0df7fedf6e6c87d21019a138b997ccf83f4a4c2b2d79c67c218b58a34be::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

