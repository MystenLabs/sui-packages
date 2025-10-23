module 0x3ceb9970ac0a5a65609ad7b27e52fee7dd42597c4f20232b505c4c9feda06226::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

