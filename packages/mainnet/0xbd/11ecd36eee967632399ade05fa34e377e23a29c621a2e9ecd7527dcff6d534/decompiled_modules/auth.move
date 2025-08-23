module 0xbd11ecd36eee967632399ade05fa34e377e23a29c621a2e9ecd7527dcff6d534::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

