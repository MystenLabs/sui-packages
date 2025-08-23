module 0x804c1478ed2416a69e44cbe70425c72accc4d9fb5941c802a25e4dafcac19f07::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

