module 0x3a00fe9ee52da14c7fe0737ea73570a4cd6fdc9c83d2d86fdb0ce901fa062890::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

