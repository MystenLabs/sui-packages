module 0xc03a8903d5bd6e6b07603f6f837ff92c089bb1d8cc7b6bee44cca32efc0d1d3e::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

