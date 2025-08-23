module 0xde9de87ef2bf70304ecfa666b3f54e74bd899c7fdd4051e0e939ae026c37e55::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

