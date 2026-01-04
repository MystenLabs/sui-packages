module 0x9f56168d45d16ce7a0d91a7b3c4d66133f62134a81145f69d60ac15abf06756d::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

