module 0xe0d54df1a44302882b44a2503348b84de17fde62edffa8702a96cb5406d7a6cd::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

