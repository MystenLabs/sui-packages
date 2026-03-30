module 0x650f78c6dd03afb036e203b9e78773d75f83a3843b3cfb1ac5ad3cbfedb155e5::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

