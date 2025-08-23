module 0x1abbb6939d80af3cf7dff98a1b4a5c7f515a00b2b27cac519873f581dd57d6b::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

