module 0x2266bbf5bfef7a64902f17fd32aa649ddf1e19bdb8646657bd6f6f64253c8f61::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

