module 0x752f2abf4d843584d0ddb7032eb2f3d543694ff5f340ff99a89519380fff4203::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

