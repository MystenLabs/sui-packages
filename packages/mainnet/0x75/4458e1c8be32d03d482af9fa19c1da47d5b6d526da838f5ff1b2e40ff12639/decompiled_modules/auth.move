module 0x754458e1c8be32d03d482af9fa19c1da47d5b6d526da838f5ff1b2e40ff12639::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

