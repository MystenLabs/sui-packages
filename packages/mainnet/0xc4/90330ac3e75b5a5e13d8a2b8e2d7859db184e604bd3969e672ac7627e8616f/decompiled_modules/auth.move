module 0xc490330ac3e75b5a5e13d8a2b8e2d7859db184e604bd3969e672ac7627e8616f::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

