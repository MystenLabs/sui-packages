module 0x9984fdb1f7937f99ed9755634734007ae4a3408ef0e4d31f87291d8133d93a65::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

