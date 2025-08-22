module 0xb386d351022a15c4d0a1415136689d1e25df82a0c7c495c78163314c1ee88f38::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

