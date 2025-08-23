module 0xce93fd424b60e6903e702c05fea4b9fb5dbd3066ba322b9e7417b892ca81372a::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

